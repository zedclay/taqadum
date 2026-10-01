import 'package:flutter/widgets.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utilities/formatters.dart';
import '../../../../core/widgets/area_style.dart';

String? taskBadge(Task t) =>
    t.badge ??
    (t.durationMinutes != null ? Fmt.minutes(t.durationMinutes!) : null);

String? taskTimeLabel(Task t, {required bool use24h}) {
  final start = t.scheduledMinute;
  if (start == null) return null;
  final from = Fmt.timeOfDay(start, use24h: use24h);
  final duration = t.durationMinutes;
  if (duration == null || duration < 60) return from;
  final end = (start + duration) % (24 * 60);
  return '$from–${Fmt.timeOfDay(end, use24h: use24h)}';
}

/// "08:30–10:30 · Work · 2h" style metadata line.
String taskMeta(BuildContext context, Task t, {required bool use24h}) => [
  ?taskTimeLabel(t, use24h: use24h),
  t.area.label(context),
  ?taskBadge(t),
].join(' · ');
