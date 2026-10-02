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

class QuranRepository {
  QuranRepository(this._db, this._goals, this._activity);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final ActivityRepository _activity;

  Stream<List<QuranLog>> watchRange(PeriodRange range) =>
      (_db.select(_db.quranLogs)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(range.end.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<QuranLog>> watchRecent({int limit = 20}) =>
      (_db.select(_db.quranLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])
            ..limit(limit))
          .watch();

  Future<void> add({
    required QuranKind kind,
    double pages = 0,
    int minutes = 0,
    String? surah,
    String? note,
    Goal? goal,
    DateTime? at,
  }) => _db.transaction(() async {
    final id = newId();
    final when = (at ?? DateTime.now()).toUtc();
    await _db
        .into(_db.quranLogs)
        .insert(
          QuranLogsCompanion.insert(
            id: id,
            kind: kind,
            pages: Value(pages),
            minutes: Value(minutes),
            surah: Value(surah),
            note: Value(note),
            goalId: Value(goal?.id),
            occurredAt: when,
          ),
        );
    if (goal != null) {
      await _goals.contribute(
        goalId: goal.id,
        delta: GoalContribution.deltaFor(goal, pages: pages, minutes: minutes),
        source: ProgressSource.quran,
        sourceId: id,
        at: when,
      );
    }
    await _activity.record(
      area: LifeArea.quran,
      type: ActivityType.logged,
      title: ActivityFallback.quran(
        kind,
        kind == QuranKind.reading ? Fmt.number(pages) : pagesLabel(pages),
        minutes,
      ),
      subtitle: surah,
      entityType: 'quran',
      entityId: id,
      facts: {'kind': kind.name, 'pages': pages, 'minutes': minutes},
      at: when,
    );
  });

  Future<void> delete(QuranLog log) => _db.transaction(() async {
    await _goals.removeContributions(log.id);
    await _activity.removeFor('quran', log.id);
    await (_db.delete(_db.quranLogs)..where((t) => t.id.equals(log.id))).go();
  });

  static String pagesLabel(double pages) {
    const fractions = {25: '¼', 50: '½', 75: '¾'};
    final whole = pages.floor();
    final frac = fractions[((pages - whole) * 100).round()];
    if (frac == null) return Fmt.number(pages);
    return whole == 0 ? frac : '$whole$frac';
  }
}

final quranRepositoryProvider = Provider<QuranRepository>(
  (ref) => QuranRepository(
    ref.watch(databaseProvider),
    ref.watch(goalsRepositoryProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final quranLogsInRangeProvider =
    StreamProvider.family<List<QuranLog>, PeriodRange>(
      (ref, range) => ref.watch(quranRepositoryProvider).watchRange(range),
    );
