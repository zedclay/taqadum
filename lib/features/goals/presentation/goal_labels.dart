import 'package:flutter/widgets.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';

String goalTypeLabel(BuildContext context, GoalType type) {
  final l = context.l10n;
  return switch (type) {
    GoalType.target => l.goalTypeTarget,
    GoalType.routine => l.goalTypeRoutine,
    GoalType.milestone => l.goalTypeMilestone,
  };
}

String goalTypeHint(BuildContext context, GoalType type) {
  final l = context.l10n;
  return switch (type) {
    GoalType.target => l.goalTypeTargetHint,
    GoalType.routine => l.goalTypeRoutineHint,
    GoalType.milestone => l.goalTypeMilestoneHint,
  };
}

String frequencyLabel(BuildContext context, GoalFrequency f) {
  final l = context.l10n;
  return switch (f) {
    GoalFrequency.daily => l.freqDaily,
    GoalFrequency.weekly => l.freqWeekly,
    GoalFrequency.monthly => l.freqMonthly,
    GoalFrequency.once => l.freqOnce,
  };
}

String timeLeftLabel(BuildContext context, DateTime date, {DateTime? now}) {
  final l = context.l10n;
  final today = now ?? DateTime.now();
  final days = DateTime(
    date.year,
    date.month,
    date.day,
  ).difference(DateTime(today.year, today.month, today.day)).inDays;
  if (days < 0) return l.goalPastDate;
  if (days >= 365) return l.goalYearsLeft((days / 365).round());
  if (days >= 60) return l.goalMonthsLeft((days / 30.44).round());
  return l.goalDaysLeft(days);
}
