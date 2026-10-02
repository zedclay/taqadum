import 'package:flutter/widgets.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utilities/formatters.dart';
import '../domain/goal_units.dart';

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

String timeLeftLabel(
  BuildContext context,
  DateTime date, {
  required DateTime now,
}) {
  final l = context.l10n;
  final today = now;
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

/// Display name of a goal unit: built-in ids are localized, currencies use
/// their local symbol and custom units keep the user's text.
String unitName(AppLocalizations l, String unit) => switch (unit) {
  'pages' => l.unitNamePages,
  'juz' => l.unitNameJuz,
  'hours' => l.unitNameHours,
  'minutes' => l.unitNameMinutes,
  'sessions' => l.unitNameSessions,
  'books' => l.unitNameBooks,
  'km' => l.unitNameKm,
  'times' => l.unitNameTimes,
  _ when GoalUnits.isCurrency(unit) => Fmt.currency(unit),
  _ => unit,
};

/// "12 pages" / "12 صفحة": [number] is the formatted [value].
String unitQuantity(
  AppLocalizations l,
  String unit,
  double value,
  String number,
) => switch (unit) {
  'pages' => l.qtyPages(value, number),
  'juz' => l.qtyJuz(value, number),
  'hours' => l.qtyHours(value, number),
  'minutes' => l.qtyMinutes(value, number),
  'sessions' => l.qtySessions(value, number),
  'books' => l.qtyBooks(value, number),
  'km' => l.qtyKm(value, number),
  'times' => l.qtyTimes(value, number),
  '' => number,
  _ when GoalUnits.isCurrency(unit) => '$number ${Fmt.currency(unit)}',
  _ => '$number $unit',
};
