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
import '../../today/data/tasks_repository.dart';

class LearningRepository {
  LearningRepository(this._db, this._goals, this._tasks, this._activity);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final TasksRepository _tasks;
  final ActivityRepository _activity;

  Stream<List<LearningSession>> watchSessions(PeriodRange range) =>
      (_db.select(_db.learningSessions)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(range.end.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<LearningResource>> watchResources() =>
      (_db.select(_db.learningResources)
            ..where((t) => t.archived.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .watch();

  Future<void> logSession({
    required String topic,
    required int minutes,
    String? skill,
    LearningResource? resource,
    int? resourceUnits,
    String? takeaway,
    String? appliedAction,
    Goal? goal,
    DateTime? at,
  }) => _db.transaction(() async {
    final id = newId();
    final when = (at ?? DateTime.now()).toUtc();
    await _db
        .into(_db.learningSessions)
        .insert(
          LearningSessionsCompanion.insert(
            id: id,
            topic: topic.trim(),
            skill: Value(skill),
            minutes: minutes,
            resourceId: Value(resource?.id),
            takeaway: Value(
              takeaway == null || takeaway.trim().isEmpty
                  ? null
                  : takeaway.trim(),
            ),
            goalId: Value(goal?.id),
            occurredAt: when,
          ),
        );
    if (resource != null && resourceUnits != null && resourceUnits > 0) {
      final next = (resource.completedUnits + resourceUnits).clamp(
        0,
        resource.totalUnits,
      );
      await (_db.update(_db.learningResources)
            ..where((t) => t.id.equals(resource.id)))
          .write(LearningResourcesCompanion(completedUnits: Value(next)));
    }
    if (goal != null) {
      await _goals.contribute(
        goalId: goal.id,
        delta: GoalContribution.deltaFor(goal, minutes: minutes),
        source: ProgressSource.learning,
        sourceId: id,
        at: when,
      );
    }
    if (appliedAction != null && appliedAction.trim().isNotEmpty) {
      await _tasks.add(
        TaskDraft(
          title: appliedAction.trim(),
          area: LifeArea.learning,
          dayKey: dayKeyOf(addDays(DateTime.now(), 1)),
          badge: skill,
          note: 'applied',
        ),
      );
    }
    await _activity.record(
      area: LifeArea.learning,
      type: ActivityType.logged,
      title: 'Study session · ${topic.trim()}',
      subtitle: [?skill, Fmt.minutes(minutes)].join(' · '),
      entityType: 'learning',
      entityId: id,
      at: when,
    );
  });

  Future<void> addResource({
    required String title,
    required ResourceKind kind,
    required int totalUnits,
    int completedUnits = 0,
    String? skill,
  }) => _db
      .into(_db.learningResources)
      .insert(
        LearningResourcesCompanion.insert(
          id: newId(),
          title: title.trim(),
          kind: kind,
          totalUnits: totalUnits,
          completedUnits: Value(completedUnits),
          skill: Value(skill),
          createdAt: DateTime.now().toUtc(),
        ),
      );

  Future<void> setResourceProgress(LearningResource r, int completed) =>
      (_db.update(
        _db.learningResources,
      )..where((t) => t.id.equals(r.id))).write(
        LearningResourcesCompanion(
          completedUnits: Value(completed.clamp(0, r.totalUnits)),
        ),
      );

  Future<void> archiveResource(LearningResource r) =>
      (_db.update(_db.learningResources)..where((t) => t.id.equals(r.id)))
          .write(const LearningResourcesCompanion(archived: Value(true)));
}

final learningRepositoryProvider = Provider<LearningRepository>(
  (ref) => LearningRepository(
    ref.watch(databaseProvider),
    ref.watch(goalsRepositoryProvider),
    ref.watch(tasksRepositoryProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final learningSessionsProvider =
    StreamProvider.family<List<LearningSession>, PeriodRange>(
      (ref, range) =>
          ref.watch(learningRepositoryProvider).watchSessions(range),
    );

final learningResourcesProvider = StreamProvider<List<LearningResource>>(
  (ref) => ref.watch(learningRepositoryProvider).watchResources(),
);
