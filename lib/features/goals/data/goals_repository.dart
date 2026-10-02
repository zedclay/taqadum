import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/ids.dart';
import '../../history/data/activity_repository.dart';
import '../../settings/data/preferences.dart';
import '../domain/goal_progress.dart';
import '../../../core/database/activity_fallback.dart';

class GoalActionDraft {
  const GoalActionDraft({
    this.id,
    required this.title,
    this.detail,
    this.frequency = GoalFrequency.weekly,
  });

  final String? id;
  final String title;
  final String? detail;
  final GoalFrequency frequency;
}

class MilestoneDraft {
  const MilestoneDraft({this.id, required this.title, this.completed = false});

  final String? id;
  final String title;
  final bool completed;
}

class GoalDraft {
  const GoalDraft({
    this.id,
    required this.title,
    this.description,
    required this.area,
    required this.type,
    this.unit = '',
    this.targetValue = 0,
    this.startValue = 0,
    this.frequency = GoalFrequency.weekly,
    this.periodTarget = 1,
    this.targetDate,
    this.why,
    this.actions = const [],
    this.milestones = const [],
    this.makePrimary = false,
  });

  final String? id;
  final String title;
  final String? description;
  final LifeArea area;
  final GoalType type;
  final String unit;
  final double targetValue;
  final double startValue;
  final GoalFrequency frequency;
  final int periodTarget;
  final DateTime? targetDate;
  final String? why;
  final List<GoalActionDraft> actions;
  final List<MilestoneDraft> milestones;
  final bool makePrimary;
}

class GoalsRepository {
  GoalsRepository(this._db, this._activity);

  final AppDatabase _db;
  final ActivityRepository _activity;

  Stream<List<Goal>> watchGoals() =>
      (_db.select(_db.goals)..orderBy([
            (t) => OrderingTerm.desc(t.isPrimary),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
          .watch();

  Stream<Goal?> watchGoal(String id) => (_db.select(
    _db.goals,
  )..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<Goal?> getGoal(String id) =>
      (_db.select(_db.goals)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<GoalProgressEvent>> watchEvents() => (_db.select(
    _db.goalProgressEvents,
  )..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])).watch();

  Stream<List<GoalMilestone>> watchMilestones() => (_db.select(
    _db.goalMilestones,
  )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();

  Stream<List<GoalAction>> watchActions() => (_db.select(
    _db.goalActions,
  )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();

  Future<List<GoalAction>> actionsFor(String goalId) =>
      (_db.select(_db.goalActions)
            ..where((t) => t.goalId.equals(goalId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  Future<List<GoalMilestone>> milestonesFor(String goalId) =>
      (_db.select(_db.goalMilestones)
            ..where((t) => t.goalId.equals(goalId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  Future<String> save(GoalDraft draft) => _db.transaction(() async {
    final now = DateTime.now().toUtc();
    final id = draft.id ?? newId();
    final existing = draft.id == null ? null : await getGoal(draft.id!);
    final companion = GoalsCompanion(
      id: Value(id),
      title: Value(draft.title.trim()),
      description: Value(_blankToNull(draft.description)),
      area: Value(draft.area),
      type: Value(draft.type),
      unit: Value(draft.unit.trim()),
      targetValue: Value(draft.targetValue),
      startValue: Value(draft.startValue),
      frequency: Value(draft.frequency),
      periodTarget: Value(draft.periodTarget),
      targetDate: Value(draft.targetDate?.toUtc()),
      why: Value(_blankToNull(draft.why)),
      updatedAt: Value(now),
      createdAt: Value(existing?.createdAt ?? now),
      status: Value(existing?.status ?? GoalStatus.active),
      isPrimary: Value(existing?.isPrimary ?? false),
    );
    await _db.into(_db.goals).insertOnConflictUpdate(companion);

    final hasPrimary = await (_db.select(
      _db.goals,
    )..where((t) => t.isPrimary.equals(true))).get();
    if (draft.makePrimary || hasPrimary.isEmpty) await _setPrimaryTx(id);

    await _syncActions(id, draft.actions, now);
    await _syncMilestones(id, draft.milestones);

    await _activity.record(
      area: draft.area,
      type: existing == null ? ActivityType.created : ActivityType.updated,
      title: draft.title.trim(),
      subtitle: existing == null
          ? ActivityFallback.goalCreated
          : ActivityFallback.goalUpdated,
      entityType: 'goal',
      entityId: id,
    );
    return id;
  });

  Future<void> _syncActions(
    String goalId,
    List<GoalActionDraft> drafts,
    DateTime now,
  ) async {
    final keepIds = drafts.map((d) => d.id).whereType<String>().toSet();
    await (_db.delete(_db.goalActions)..where(
          (t) => t.goalId.equals(goalId) & t.id.isNotIn(keepIds.toList()),
        ))
        .go();
    for (var i = 0; i < drafts.length; i++) {
      final d = drafts[i];
      if (d.id != null) {
        await (_db.update(
          _db.goalActions,
        )..where((t) => t.id.equals(d.id!))).write(
          GoalActionsCompanion(
            title: Value(d.title),
            detail: Value(_blankToNull(d.detail)),
            frequency: Value(d.frequency),
            sortOrder: Value(i),
          ),
        );
      } else {
        await _db
            .into(_db.goalActions)
            .insert(
              GoalActionsCompanion.insert(
                id: newId(),
                goalId: goalId,
                title: d.title,
                detail: Value(_blankToNull(d.detail)),
                frequency: Value(d.frequency),
                sortOrder: Value(i),
                createdAt: now,
              ),
            );
      }
    }
  }

  Future<void> _syncMilestones(
    String goalId,
    List<MilestoneDraft> drafts,
  ) async {
    final keepIds = drafts.map((d) => d.id).whereType<String>().toSet();
    await (_db.delete(_db.goalMilestones)..where(
          (t) => t.goalId.equals(goalId) & t.id.isNotIn(keepIds.toList()),
        ))
        .go();
    for (var i = 0; i < drafts.length; i++) {
      final d = drafts[i];
      final completedAt = Value(d.completed ? DateTime.now().toUtc() : null);
      if (d.id != null) {
        final current = await (_db.select(
          _db.goalMilestones,
        )..where((t) => t.id.equals(d.id!))).getSingleOrNull();
        await (_db.update(
          _db.goalMilestones,
        )..where((t) => t.id.equals(d.id!))).write(
          GoalMilestonesCompanion(
            title: Value(d.title),
            sortOrder: Value(i),
            completedAt: d.completed == (current?.completedAt != null)
                ? const Value.absent()
                : completedAt,
          ),
        );
      } else {
        await _db
            .into(_db.goalMilestones)
            .insert(
              GoalMilestonesCompanion.insert(
                id: newId(),
                goalId: goalId,
                title: d.title,
                sortOrder: Value(i),
                completedAt: completedAt,
              ),
            );
      }
    }
  }

  /// Records progress toward a goal. Safe to call inside another transaction.
  Future<void> contribute({
    required String goalId,
    required double delta,
    required ProgressSource source,
    String? sourceId,
    String? note,
    DateTime? at,
  }) async {
    if (delta == 0) return;
    await _db
        .into(_db.goalProgressEvents)
        .insert(
          GoalProgressEventsCompanion.insert(
            id: newId(),
            goalId: goalId,
            delta: delta,
            note: Value(note),
            source: Value(source),
            sourceId: Value(sourceId),
            occurredAt: (at ?? DateTime.now()).toUtc(),
          ),
        );
  }

  Future<void> removeContributions(String sourceId) => (_db.delete(
    _db.goalProgressEvents,
  )..where((t) => t.sourceId.equals(sourceId))).go();

  Future<void> logProgress({
    required Goal goal,
    required double delta,
    String? note,
    DateTime? at,
  }) => _db.transaction(() async {
    final eventId = newId();
    await contribute(
      goalId: goal.id,
      delta: delta,
      source: ProgressSource.manual,
      sourceId: eventId,
      note: note,
      at: at,
    );
    await _activity.record(
      area: goal.area,
      type: ActivityType.logged,
      title: goal.title,
      subtitle: note ?? ActivityFallback.progressLogged,
      entityType: 'goalProgress',
      entityId: eventId,
      at: at,
    );
  });

  Future<void> setStatus(Goal goal, GoalStatus status) =>
      _db.transaction(() async {
        await (_db.update(_db.goals)..where((t) => t.id.equals(goal.id))).write(
          GoalsCompanion(
            status: Value(status),
            completedAt: Value(
              status == GoalStatus.completed ? DateTime.now().toUtc() : null,
            ),
            isPrimary: status == GoalStatus.active
                ? const Value.absent()
                : const Value(false),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
        if (status == GoalStatus.completed) {
          await _activity.record(
            area: goal.area,
            type: ActivityType.completed,
            title: goal.title,
            subtitle: ActivityFallback.goalCompleted,
            entityType: 'goal',
            entityId: goal.id,
          );
        }
      });

  Future<void> setPrimary(String goalId) =>
      _db.transaction(() => _setPrimaryTx(goalId));

  Future<void> _setPrimaryTx(String goalId) async {
    await _db
        .update(_db.goals)
        .write(const GoalsCompanion(isPrimary: Value(false)));
    await (_db.update(_db.goals)..where((t) => t.id.equals(goalId))).write(
      const GoalsCompanion(isPrimary: Value(true)),
    );
  }

  Future<void> delete(String goalId) =>
      (_db.delete(_db.goals)..where((t) => t.id.equals(goalId))).go();

  Future<void> toggleMilestone(GoalMilestone m, Goal goal) =>
      _db.transaction(() async {
        final done = m.completedAt == null;
        await (_db.update(
          _db.goalMilestones,
        )..where((t) => t.id.equals(m.id))).write(
          GoalMilestonesCompanion(
            completedAt: Value(done ? DateTime.now().toUtc() : null),
          ),
        );
        if (done) {
          await _activity.record(
            area: goal.area,
            type: ActivityType.milestone,
            title: m.title,
            subtitle: goal.title,
            entityType: 'milestone',
            entityId: m.id,
          );
        } else {
          await _activity.removeFor('milestone', m.id);
        }
      });

  Future<void> toggleAction(GoalAction action, Goal goal, bool done) =>
      _db.transaction(() async {
        await (_db.update(
          _db.goalActions,
        )..where((t) => t.id.equals(action.id))).write(
          GoalActionsCompanion(
            lastCompletedAt: Value(done ? DateTime.now().toUtc() : null),
          ),
        );
        if (done) {
          if (goal.type == GoalType.routine) {
            await contribute(
              goalId: goal.id,
              delta: 1,
              source: ProgressSource.task,
              sourceId:
                  'action:${action.id}:${DateTime.now().toIso8601String()}',
            );
          }
          await _activity.record(
            area: goal.area,
            type: ActivityType.completed,
            title: action.title,
            subtitle: goal.title,
            entityType: 'goalAction',
            entityId: action.id,
          );
        }
      });

  Future<void> addAction(String goalId, GoalActionDraft draft) async {
    final count = (await actionsFor(goalId)).length;
    await _db
        .into(_db.goalActions)
        .insert(
          GoalActionsCompanion.insert(
            id: newId(),
            goalId: goalId,
            title: draft.title,
            detail: Value(_blankToNull(draft.detail)),
            frequency: Value(draft.frequency),
            sortOrder: Value(count),
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  static String? _blankToNull(String? v) =>
      v == null || v.trim().isEmpty ? null : v.trim();
}

final goalsRepositoryProvider = Provider<GoalsRepository>(
  (ref) => GoalsRepository(
    ref.watch(databaseProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final goalsProvider = StreamProvider<List<Goal>>(
  (ref) => ref.watch(goalsRepositoryProvider).watchGoals(),
);

final goalEventsProvider = StreamProvider<List<GoalProgressEvent>>(
  (ref) => ref.watch(goalsRepositoryProvider).watchEvents(),
);

final goalMilestonesProvider = StreamProvider<List<GoalMilestone>>(
  (ref) => ref.watch(goalsRepositoryProvider).watchMilestones(),
);

final goalActionsProvider = StreamProvider<List<GoalAction>>(
  (ref) => ref.watch(goalsRepositoryProvider).watchActions(),
);

/// A goal together with its derived progress.
class GoalView {
  const GoalView(this.goal, this.progress);
  final Goal goal;
  final GoalProgress progress;
}

final goalViewsProvider = Provider<AsyncValue<List<GoalView>>>((ref) {
  final goals = ref.watch(goalsProvider);
  final events = ref.watch(goalEventsProvider);
  final milestones = ref.watch(goalMilestonesProvider);
  final now = ref.watch(clockProvider)();
  final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
  ref.watch(currentDayProvider);
  if (goals.hasError) return AsyncError(goals.error!, goals.stackTrace!);
  if (!goals.hasValue || !events.hasValue || !milestones.hasValue) {
    return const AsyncLoading();
  }
  return AsyncData([
    for (final g in goals.requireValue)
      GoalView(
        g,
        GoalProgressCalculator.compute(
          g,
          events: events.requireValue,
          milestones: milestones.requireValue,
          now: now,
          weekStart: weekStart,
        ),
      ),
  ]);
});

final goalViewProvider = Provider.family<AsyncValue<GoalView?>, String>((
  ref,
  id,
) {
  return ref
      .watch(goalViewsProvider)
      .whenData((views) => views.where((v) => v.goal.id == id).firstOrNull);
});
