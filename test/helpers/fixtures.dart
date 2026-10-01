import 'package:taqadum/core/database/app_database.dart';

final _epoch = DateTime.utc(2027, 1, 1);

Goal makeGoal({
  String id = 'g1',
  String title = 'Goal',
  LifeArea area = LifeArea.work,
  GoalType type = GoalType.target,
  String unit = '',
  double targetValue = 100,
  double startValue = 0,
  GoalFrequency frequency = GoalFrequency.weekly,
  int periodTarget = 1,
  GoalStatus status = GoalStatus.active,
  bool isPrimary = false,
  DateTime? createdAt,
  DateTime? targetDate,
}) => Goal(
  id: id,
  title: title,
  area: area,
  type: type,
  unit: unit,
  targetValue: targetValue,
  startValue: startValue,
  frequency: frequency,
  periodTarget: periodTarget,
  status: status,
  isPrimary: isPrimary,
  targetDate: targetDate,
  createdAt: createdAt ?? _epoch,
  updatedAt: createdAt ?? _epoch,
);

GoalProgressEvent makeEvent(
  String goalId,
  double delta,
  DateTime at, {
  String id = '',
}) => GoalProgressEvent(
  id: id.isEmpty ? '$goalId-${at.microsecondsSinceEpoch}-$delta' : id,
  goalId: goalId,
  delta: delta,
  source: ProgressSource.manual,
  occurredAt: at,
);

Task makeTask(
  String dayKey, {
  String id = '',
  String title = 'Task',
  LifeArea area = LifeArea.work,
  bool done = false,
}) => Task(
  id: id.isEmpty ? '$dayKey-$title-$done' : id,
  dayKey: dayKey,
  title: title,
  area: area,
  completedAt: done ? DateTime.parse('${dayKey}T10:00:00') : null,
  sortOrder: 0,
  createdAt: DateTime.parse('${dayKey}T07:00:00'),
);

ActivityEvent makeActivity(
  DateTime at, {
  LifeArea? area = LifeArea.quran,
  ActivityType type = ActivityType.logged,
  String title = 'Logged',
  String? entityType = 'quran',
  String? subtitle,
  int? amountMinor,
}) => ActivityEvent(
  id: '${at.microsecondsSinceEpoch}-$title-$entityType',
  area: area,
  type: type,
  title: title,
  subtitle: subtitle,
  amountMinor: amountMinor,
  entityType: entityType,
  occurredAt: at,
);
