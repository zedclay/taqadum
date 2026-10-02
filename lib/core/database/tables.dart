import 'package:drift/drift.dart';

import '../domain/enums.dart';

mixin _Id on Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserProfiles extends Table with _Id {
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get role => text().nullable()();
  TextColumn get intention => text().nullable()();
  IntColumn get avatarColor => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

class Goals extends Table with _Id {
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get area => textEnum<LifeArea>()();
  TextColumn get type => textEnum<GoalType>()();
  TextColumn get unit => text().withDefault(const Constant(''))();
  RealColumn get targetValue => real().withDefault(const Constant(0))();
  RealColumn get startValue => real().withDefault(const Constant(0))();
  TextColumn get frequency =>
      textEnum<GoalFrequency>().withDefault(const Constant('once'))();
  IntColumn get periodTarget => integer().withDefault(const Constant(1))();
  DateTimeColumn get targetDate => dateTime().nullable()();
  TextColumn get why => text().nullable()();
  TextColumn get status =>
      textEnum<GoalStatus>().withDefault(const Constant('active'))();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class GoalActions extends Table with _Id {
  TextColumn get goalId =>
      text().references(Goals, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get detail => text().nullable()();
  TextColumn get frequency =>
      textEnum<GoalFrequency>().withDefault(const Constant('weekly'))();
  DateTimeColumn get lastCompletedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

class GoalMilestones extends Table with _Id {
  TextColumn get goalId =>
      text().references(Goals, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class GoalProgressEvents extends Table with _Id {
  TextColumn get goalId =>
      text().references(Goals, #id, onDelete: KeyAction.cascade)();
  RealColumn get delta => real()();
  TextColumn get note => text().nullable()();
  TextColumn get source =>
      textEnum<ProgressSource>().withDefault(const Constant('manual'))();
  TextColumn get sourceId => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
}

class Tasks extends Table with _Id {
  TextColumn get dayKey => text()();
  TextColumn get title => text()();
  TextColumn get area => textEnum<LifeArea>()();
  TextColumn get goalId =>
      text().nullable().references(Goals, #id, onDelete: KeyAction.setNull)();
  IntColumn get scheduledMinute => integer().nullable()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get badge => text().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get priorityRank => integer().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

class MorningCheckIns extends Table {
  TextColumn get dayKey => text()();
  TextColumn get energy => textEnum<Energy>()();
  TextColumn get capacity => textEnum<Capacity>()();
  TextColumn get intention => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {dayKey};
}

class NightReviews extends Table {
  TextColumn get dayKey => text()();
  IntColumn get rating => integer()();
  TextColumn get wentWellTags => text().withDefault(const Constant('[]'))();
  TextColumn get wentWellNote => text().nullable()();
  TextColumn get betterTags => text().withDefault(const Constant('[]'))();
  TextColumn get betterNote => text().nullable()();
  TextColumn get biggestWin => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {dayKey};
}

class QuranLogs extends Table with _Id {
  TextColumn get kind => textEnum<QuranKind>()();
  RealColumn get pages => real().withDefault(const Constant(0))();
  IntColumn get minutes => integer().withDefault(const Constant(0))();
  TextColumn get surah => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get goalId =>
      text().nullable().references(Goals, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get occurredAt => dateTime()();
}

class WorkActivities extends Table with _Id {
  TextColumn get kind => textEnum<WorkKind>()();
  TextColumn get title => text()();
  TextColumn get counterpart => text().nullable()();
  TextColumn get detail => text().nullable()();
  IntColumn get valueMinor => integer().nullable()();
  IntColumn get minutes => integer().nullable()();
  DateTimeColumn get scheduledAt => dateTime().nullable()();
  TextColumn get goalId =>
      text().nullable().references(Goals, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get occurredAt => dateTime()();
}

class FinanceTransactions extends Table with _Id {
  TextColumn get type => textEnum<TransactionType>()();
  IntColumn get amountMinor => integer()();
  TextColumn get category => text()();
  TextColumn get note => text().nullable()();
  TextColumn get tag =>
      textEnum<MoneyTag>().withDefault(const Constant('personal'))();
  TextColumn get goalId =>
      text().nullable().references(Goals, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get occurredAt => dateTime()();
}

class Habits extends Table with _Id {
  TextColumn get name => text()();
  TextColumn get area => textEnum<LifeArea>()();
  TextColumn get label => text().nullable()();

  /// Built-in starter habit id (e.g. `health1`); the name is then localized at
  /// display time. Cleared when the user renames the habit.
  TextColumn get templateId => text().nullable()();
  IntColumn get reminderMinute => integer().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

class HabitLogs extends Table with _Id {
  TextColumn get habitId =>
      text().references(Habits, #id, onDelete: KeyAction.cascade)();
  TextColumn get dayKey => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {habitId, dayKey},
  ];
}

class WorkoutLogs extends Table with _Id {
  TextColumn get title => text()();
  IntColumn get minutes => integer()();
  TextColumn get detail => text().nullable()();
  TextColumn get goalId =>
      text().nullable().references(Goals, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get occurredAt => dateTime()();
}

class WalkingLogs extends Table with _Id {
  IntColumn get minutes => integer()();
  IntColumn get steps => integer().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
}

class SleepLogs extends Table with _Id {
  TextColumn get dayKey => text()();
  DateTimeColumn get bedTime => dateTime()();
  DateTimeColumn get wakeTime => dateTime()();
  TextColumn get energy => textEnum<Energy>().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class LearningResources extends Table with _Id {
  TextColumn get title => text()();
  TextColumn get kind => textEnum<ResourceKind>()();
  IntColumn get totalUnits => integer()();
  IntColumn get completedUnits => integer().withDefault(const Constant(0))();
  TextColumn get skill => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

class LearningSessions extends Table with _Id {
  TextColumn get topic => text()();
  TextColumn get skill => text().nullable()();
  IntColumn get minutes => integer()();
  TextColumn get resourceId => text().nullable().references(
    LearningResources,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get takeaway => text().nullable()();
  TextColumn get goalId =>
      text().nullable().references(Goals, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get occurredAt => dateTime()();
}

class Notes extends Table with _Id {
  TextColumn get body => text()();
  TextColumn get area => textEnum<LifeArea>().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class WeeklyReviews extends Table {
  TextColumn get weekStart => text()();
  TextColumn get wentWellTags => text().withDefault(const Constant('[]'))();
  TextColumn get wentWellNote => text().nullable()();
  TextColumn get changeTags => text().withDefault(const Constant('[]'))();
  TextColumn get changeNote => text().nullable()();
  TextColumn get biggestWin => text().nullable()();
  TextColumn get priorities => text().withDefault(const Constant('[]'))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {weekStart};
}

class MonthlyReviews extends Table {
  TextColumn get monthKey => text()();
  TextColumn get proudTags => text().withDefault(const Constant('[]'))();
  TextColumn get proudNote => text().nullable()();
  TextColumn get heldBackTags => text().withDefault(const Constant('[]'))();
  TextColumn get heldBackNote => text().nullable()();
  TextColumn get differentTags => text().withDefault(const Constant('[]'))();
  TextColumn get differentNote => text().nullable()();
  TextColumn get lesson => text().nullable()();
  TextColumn get priorities => text().withDefault(const Constant('[]'))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {monthKey};
}

class Reminders extends Table with _Id {
  TextColumn get kind => textEnum<ReminderKind>()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get minuteOfDay => integer()();
  IntColumn get weekdays => integer().withDefault(const Constant(127))();
  TextColumn get habitId =>
      text().nullable().references(Habits, #id, onDelete: KeyAction.cascade)();
}

class ActivityEvents extends Table with _Id {
  TextColumn get area => textEnum<LifeArea>().nullable()();
  TextColumn get type => textEnum<ActivityType>()();
  TextColumn get title => text()();
  TextColumn get subtitle => text().nullable()();
  IntColumn get amountMinor => integer().nullable()();
  TextColumn get entityType => text().nullable()();
  TextColumn get entityId => text().nullable()();

  /// JSON facts (minutes, rating, kind…) used to render system titles in the
  /// active language; [title] and [subtitle] keep a readable fallback.
  TextColumn get facts => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
