import 'package:flutter/widgets.dart';

import '../domain/period.dart';
import '../localization/l10n.dart';
import 'formatters.dart';

/// Whole calendar days between [moment] and [now] (0 = same day).
int daysBetween(DateTime moment, DateTime now) =>
    startOfDay(now).difference(startOfDay(moment)).inDays;

/// "Today · 8:30 AM", "Yesterday · 9:15 PM" or "Oct 22 · 7:00 PM".
String whenLabel(
  BuildContext context,
  DateTime moment, {
  required bool use24h,
  required DateTime now,
}) {
  final l = context.l10n;
  final local = moment.toLocal();
  final time = Fmt.time(local, use24h: use24h);
  return switch (daysBetween(local, now)) {
    0 => l.commonTodayAt(time),
    1 => l.commonYesterdayAt(time),
    _ => l.commonDateAt(Fmt.monthDay(local), time),
  };
}

/// "today", "yesterday" or "4 days ago".
String daysAgoLabel(
  BuildContext context,
  DateTime moment, {
  required DateTime now,
}) => context.l10n.commonDaysAgo(
  daysBetween(moment.toLocal(), now).clamp(0, 9999),
);
