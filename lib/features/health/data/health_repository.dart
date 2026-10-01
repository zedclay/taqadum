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

class HealthRepository {
  HealthRepository(this._db, this._goals, this._activity);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final ActivityRepository _activity;

  Stream<List<Habit>> watchHabits() =>
      (_db.select(_db.habits)
            ..where((t) => t.archived.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Stream<List<HabitLog>> watchHabitLogs(PeriodRange range) =>
      (_db.select(_db.habitLogs)..where(
            (t) =>
                t.dayKey.isBiggerOrEqualValue(range.startKey) &
                t.dayKey.isSmallerOrEqualValue(range.endKeyInclusive),
          ))
          .watch();

  Stream<List<WorkoutLog>> watchWorkouts(PeriodRange range) =>
      (_db.select(_db.workoutLogs)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(range.end.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<WalkingLog>> watchWalks(PeriodRange range) =>
      (_db.select(_db.walkingLogs)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(range.end.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<SleepLog>> watchSleep(PeriodRange range) =>
      (_db.select(_db.sleepLogs)
            ..where(
              (t) =>
                  t.dayKey.isBiggerOrEqualValue(range.startKey) &
                  t.dayKey.isSmallerOrEqualValue(range.endKeyInclusive),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.dayKey)]))
          .watch();

  Future<String> addHabit({
    required String name,
    required LifeArea area,
    String? label,
    int? reminderMinute,
  }) async {
    final id = newId();
    final count = (await _db.select(_db.habits).get()).length;
    await _db
        .into(_db.habits)
        .insert(
          HabitsCompanion.insert(
            id: id,
            name: name.trim(),
            area: area,
            label: Value(label),
            reminderMinute: Value(reminderMinute),
            sortOrder: Value(count),
            createdAt: DateTime.now().toUtc(),
          ),
        );
    await _activity.record(
      area: area,
      type: ActivityType.created,
      title: name.trim(),
      subtitle: 'Habit added',
      entityType: 'habit',
      entityId: id,
    );
    return id;
  }

  Future<void> updateHabit(Habit habit) =>
      _db.update(_db.habits).replace(habit);

  Future<void> archiveHabit(Habit habit) =>
      (_db.update(_db.habits)..where((t) => t.id.equals(habit.id))).write(
        const HabitsCompanion(archived: Value(true)),
      );

  Future<void> setHabitDone(Habit habit, String dayKey, bool done) =>
      _db.transaction(() async {
        final logId = '${habit.id}:$dayKey';
        if (done) {
          await _db
              .into(_db.habitLogs)
              .insert(
                HabitLogsCompanion.insert(
                  id: logId,
                  habitId: habit.id,
                  dayKey: dayKey,
                  createdAt: DateTime.now().toUtc(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
          await _activity.record(
            area: habit.area,
            type: ActivityType.completed,
            title: habit.name,
            subtitle: habit.label ?? 'Habit',
            entityType: 'habitLog',
            entityId: logId,
            at: _momentFor(dayKey),
          );
        } else {
          await (_db.delete(
            _db.habitLogs,
          )..where((t) => t.id.equals(logId))).go();
          await _activity.removeFor('habitLog', logId);
        }
      });

  Future<void> logWorkout({
    required String title,
    required int minutes,
    String? detail,
    Goal? goal,
    DateTime? at,
  }) => _db.transaction(() async {
    final id = newId();
    final when = (at ?? DateTime.now()).toUtc();
    await _db
        .into(_db.workoutLogs)
        .insert(
          WorkoutLogsCompanion.insert(
            id: id,
            title: title.trim(),
            minutes: minutes,
            detail: Value(detail),
            goalId: Value(goal?.id),
            occurredAt: when,
          ),
        );
    if (goal != null) {
      await _goals.contribute(
        goalId: goal.id,
        delta: GoalContribution.deltaFor(goal, minutes: minutes),
        source: ProgressSource.health,
        sourceId: id,
        at: when,
      );
    }
    await _activity.record(
      area: LifeArea.health,
      type: ActivityType.logged,
      title: title.trim(),
      subtitle: [?detail, Fmt.minutes(minutes)].join(' · '),
      entityType: 'workout',
      entityId: id,
      at: when,
    );
  });

  Future<void> logWalk({required int minutes, int? steps, DateTime? at}) =>
      _db.transaction(() async {
        final id = newId();
        final when = (at ?? DateTime.now()).toUtc();
        await _db
            .into(_db.walkingLogs)
            .insert(
              WalkingLogsCompanion.insert(
                id: id,
                minutes: minutes,
                steps: Value(steps),
                occurredAt: when,
              ),
            );
        await _activity.record(
          area: LifeArea.health,
          type: ActivityType.logged,
          title: 'Walk · ${Fmt.minutes(minutes)}',
          subtitle: steps == null ? null : '${Fmt.number(steps)} steps',
          entityType: 'walk',
          entityId: id,
          at: when,
        );
      });

  Future<void> logSleep({
    required DateTime bedTime,
    required DateTime wakeTime,
    Energy? energy,
  }) => _db.transaction(() async {
    final dayKey = dayKeyOf(wakeTime);
    await (_db.delete(
      _db.sleepLogs,
    )..where((t) => t.dayKey.equals(dayKey))).go();
    final id = newId();
    await _db
        .into(_db.sleepLogs)
        .insert(
          SleepLogsCompanion.insert(
            id: id,
            dayKey: dayKey,
            bedTime: bedTime.toUtc(),
            wakeTime: wakeTime.toUtc(),
            energy: Value(energy),
            createdAt: DateTime.now().toUtc(),
          ),
        );
    await _activity.removeFor('sleep', dayKey);
    await _activity.record(
      area: LifeArea.health,
      type: ActivityType.logged,
      title: 'Sleep · ${Fmt.minutes(wakeTime.difference(bedTime).inMinutes)}',
      subtitle:
          'Bed ${Fmt.time(bedTime, use24h: true)} · '
          'Wake ${Fmt.time(wakeTime, use24h: true)}',
      entityType: 'sleep',
      entityId: dayKey,
      at: wakeTime,
    );
  });

  static DateTime _momentFor(String dayKey) {
    final now = DateTime.now();
    if (dayKeyOf(now) == dayKey) return now;
    return dateOfKey(dayKey).add(const Duration(hours: 12));
  }
}

final healthRepositoryProvider = Provider<HealthRepository>(
  (ref) => HealthRepository(
    ref.watch(databaseProvider),
    ref.watch(goalsRepositoryProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final habitsProvider = StreamProvider<List<Habit>>(
  (ref) => ref.watch(healthRepositoryProvider).watchHabits(),
);

final habitLogsProvider = StreamProvider.family<List<HabitLog>, PeriodRange>(
  (ref, range) => ref.watch(healthRepositoryProvider).watchHabitLogs(range),
);

final workoutsProvider = StreamProvider.family<List<WorkoutLog>, PeriodRange>(
  (ref, range) => ref.watch(healthRepositoryProvider).watchWorkouts(range),
);

final walksProvider = StreamProvider.family<List<WalkingLog>, PeriodRange>(
  (ref, range) => ref.watch(healthRepositoryProvider).watchWalks(range),
);

final sleepProvider = StreamProvider.family<List<SleepLog>, PeriodRange>(
  (ref, range) => ref.watch(healthRepositoryProvider).watchSleep(range),
);
