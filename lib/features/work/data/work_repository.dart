import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/ids.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/domain/goal_progress.dart';
import '../../history/data/activity_repository.dart';
import '../../../core/database/activity_fallback.dart';

class WorkRepository {
  WorkRepository(this._db, this._goals, this._activity);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final ActivityRepository _activity;

  Stream<List<WorkActivity>> watchRange(PeriodRange range) =>
      (_db.select(_db.workActivities)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(range.end.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<WorkActivity>> watchSince(DateTime since) =>
      (_db.select(_db.workActivities)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(since.toUtc()) |
                  t.scheduledAt.isBiggerOrEqualValue(since.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Future<void> add({
    required WorkKind kind,
    required String title,
    String? counterpart,
    String? detail,
    int? valueMinor,
    int? minutes,
    DateTime? scheduledAt,
    Goal? goal,
    DateTime? at,
  }) => _db.transaction(() async {
    final id = newId();
    final when = (at ?? DateTime.now()).toUtc();
    await _db
        .into(_db.workActivities)
        .insert(
          WorkActivitiesCompanion.insert(
            id: id,
            kind: kind,
            title: title.trim(),
            counterpart: Value(_clean(counterpart)),
            detail: Value(_clean(detail)),
            valueMinor: Value(valueMinor),
            minutes: Value(minutes),
            scheduledAt: Value(scheduledAt?.toUtc()),
            goalId: Value(goal?.id),
            occurredAt: when,
          ),
        );
    if (goal != null) {
      final delta = GoalContribution.deltaFor(
        goal,
        minutes: minutes,
        money: kind == WorkKind.clientWon && valueMinor != null
            ? Fmt.minorToMajor(valueMinor)
            : null,
      );
      await _goals.contribute(
        goalId: goal.id,
        delta: delta,
        source: ProgressSource.work,
        sourceId: id,
        at: when,
      );
    }
    await _activity.record(
      area: LifeArea.work,
      type: ActivityType.logged,
      title: title.trim(),
      subtitle: [
        ActivityFallback.workKind(kind),
        ?_clean(counterpart),
        if (minutes != null) ActivityFallback.duration(minutes),
      ].join(' · '),
      amountMinor: kind == WorkKind.clientWon ? valueMinor : null,
      entityType: 'work',
      entityId: id,
      facts: {
        'kind': kind.name,
        'counterpart': _clean(counterpart),
        'minutes': minutes,
      },
      at: when,
    );
  });

  Future<void> delete(WorkActivity a) => _db.transaction(() async {
    await _goals.removeContributions(a.id);
    await _activity.removeFor('work', a.id);
    await (_db.delete(
      _db.workActivities,
    )..where((t) => t.id.equals(a.id))).go();
  });

  static String? _clean(String? v) =>
      v == null || v.trim().isEmpty ? null : v.trim();
}

final workRepositoryProvider = Provider<WorkRepository>(
  (ref) => WorkRepository(
    ref.watch(databaseProvider),
    ref.watch(goalsRepositoryProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final workInRangeProvider =
    StreamProvider.family<List<WorkActivity>, PeriodRange>(
      (ref, range) => ref.watch(workRepositoryProvider).watchRange(range),
    );
