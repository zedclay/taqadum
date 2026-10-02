import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/ids.dart';
import '../../goals/data/goals_repository.dart';
import '../../history/data/activity_repository.dart';

class TaskDraft {
  const TaskDraft({
    required this.title,
    required this.area,
    required this.dayKey,
    this.goalId,
    this.scheduledMinute,
    this.durationMinutes,
    this.badge,
    this.note,
    this.priorityRank,
  });

  final String title;
  final LifeArea area;
  final String dayKey;
  final String? goalId;
  final int? scheduledMinute;
  final int? durationMinutes;
  final String? badge;
  final String? note;
  final int? priorityRank;
}

class TasksRepository {
  TasksRepository(this._db, this._goals, this._activity, this._now);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final ActivityRepository _activity;
  final Clock _now;

  Stream<List<Task>> watchDay(String dayKey) =>
      (_db.select(_db.tasks)
            ..where((t) => t.dayKey.equals(dayKey))
            ..orderBy([
              (t) => OrderingTerm.asc(t.sortOrder),
              (t) => OrderingTerm.asc(t.createdAt),
            ]))
          .watch();

  Stream<List<Task>> watchRange(PeriodRange range) =>
      (_db.select(_db.tasks)..where(
            (t) =>
                t.dayKey.isBiggerOrEqualValue(range.startKey) &
                t.dayKey.isSmallerOrEqualValue(range.endKeyInclusive),
          ))
          .watch();

  Future<List<Task>> dayTasks(String dayKey) =>
      (_db.select(_db.tasks)..where((t) => t.dayKey.equals(dayKey))).get();

  Future<String> add(TaskDraft draft) async {
    final id = newId();
    final siblings = await dayTasks(draft.dayKey);
    await _db
        .into(_db.tasks)
        .insert(
          TasksCompanion.insert(
            id: id,
            dayKey: draft.dayKey,
            title: draft.title.trim(),
            area: draft.area,
            goalId: Value(draft.goalId),
            scheduledMinute: Value(draft.scheduledMinute),
            durationMinutes: Value(draft.durationMinutes),
            badge: Value(draft.badge),
            note: Value(draft.note),
            priorityRank: Value(draft.priorityRank),
            sortOrder: Value(siblings.length),
            createdAt: _now().toUtc(),
          ),
        );
    return id;
  }

  Future<void> update(Task task) => _db.update(_db.tasks).replace(task);

  Future<void> delete(Task task) => _db.transaction(() async {
    await _goals.removeContributions('task:${task.id}');
    await _activity.removeFor('task', task.id);
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(task.id))).go();
  });

  Future<void> setDone(Task task, bool done) => _db.transaction(() async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(completedAt: Value(done ? _now().toUtc() : null)),
    );
    if (done) {
      await _activity.record(
        area: task.area,
        type: ActivityType.completed,
        title: task.title,
        subtitle: task.badge ?? task.note,
        entityType: 'task',
        entityId: task.id,
      );
      if (task.goalId != null) {
        final goal = await _goals.getGoal(task.goalId!);
        if (goal != null && goal.type == GoalType.routine) {
          await _goals.contribute(
            goalId: goal.id,
            delta: 1,
            source: ProgressSource.task,
            sourceId: 'task:${task.id}',
          );
        }
      }
    } else {
      await _activity.removeFor('task', task.id);
      await _goals.removeContributions('task:${task.id}');
    }
  });

  Future<void> reschedule(
    Task task, {
    required String dayKey,
    int? Function()? minute,
  }) => (_db.update(_db.tasks)..where((t) => t.id.equals(task.id))).write(
    TasksCompanion(
      dayKey: Value(dayKey),
      scheduledMinute: minute == null ? const Value.absent() : Value(minute()),
      priorityRank: dayKey == task.dayKey
          ? const Value.absent()
          : const Value(null),
    ),
  );

  /// Sets the day's top priorities to [taskIds] in order (max 3).
  Future<void> setPriorities(String dayKey, List<String> taskIds) =>
      _db.transaction(() async {
        await (_db.update(_db.tasks)..where((t) => t.dayKey.equals(dayKey)))
            .write(const TasksCompanion(priorityRank: Value(null)));
        for (var i = 0; i < taskIds.length && i < 3; i++) {
          await (_db.update(_db.tasks)..where((t) => t.id.equals(taskIds[i])))
              .write(TasksCompanion(priorityRank: Value(i + 1)));
        }
      });

  Future<void> reorder(List<Task> ordered) => _db.transaction(() async {
    for (var i = 0; i < ordered.length; i++) {
      await (_db.update(_db.tasks)..where((t) => t.id.equals(ordered[i].id)))
          .write(TasksCompanion(sortOrder: Value(i)));
    }
  });
}

final tasksRepositoryProvider = Provider<TasksRepository>(
  (ref) => TasksRepository(
    ref.watch(databaseProvider),
    ref.watch(goalsRepositoryProvider),
    ref.watch(activityRepositoryProvider),
    ref.watch(clockProvider),
  ),
);

final tasksForDayProvider = StreamProvider.family<List<Task>, String>(
  (ref, dayKey) => ref.watch(tasksRepositoryProvider).watchDay(dayKey),
);

final tasksInRangeProvider = StreamProvider.family<List<Task>, PeriodRange>(
  (ref, range) => ref.watch(tasksRepositoryProvider).watchRange(range),
);
