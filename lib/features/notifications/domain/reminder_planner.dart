import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/services/notification_service.dart';
import '../data/reminders_repository.dart';

class ReminderCopy {
  const ReminderCopy(this.title, this.body);
  final String title;
  final String body;
}

class PlannerInput {
  const PlannerInput({
    required this.now,
    required this.reminders,
    required this.habitNames,
    required this.masterOn,
    required this.quietEnabled,
    required this.quietStart,
    required this.quietEnd,
    required this.smartSuppression,
    required this.isDone,
    required this.copy,
    this.weekStart = DateTime.monday,
    this.days = 7,
  });

  final DateTime now;
  final List<Reminder> reminders;
  final Map<String, String> habitNames;
  final bool masterOn;
  final bool quietEnabled;
  final int quietStart;
  final int quietEnd;
  final bool smartSuppression;

  /// Whether the activity behind [reminder] is already done on [dayKey].
  final bool Function(Reminder reminder, String dayKey) isDone;
  final ReminderCopy Function(Reminder reminder, String? habitName) copy;
  final int weekStart;
  final int days;
}

abstract final class ReminderPlanner {
  static const maxPending = 60;

  static bool inQuietHours(int minute, int start, int end) {
    if (start == end) return false;
    return start < end
        ? minute >= start && minute < end
        : minute >= start || minute < end;
  }

  static List<ScheduledReminder> plan(PlannerInput input) {
    if (!input.masterOn) return const [];
    final result = <ScheduledReminder>[];
    var id = 1;
    final today = startOfDay(input.now);
    for (var offset = 0; offset < input.days; offset++) {
      final day = addDays(today, offset);
      final key = dayKeyOf(day);
      for (final r in input.reminders) {
        if (!r.enabled) continue;
        if (!_occursOn(r, day)) continue;
        if (input.quietEnabled &&
            inQuietHours(r.minuteOfDay, input.quietStart, input.quietEnd)) {
          continue;
        }
        final at = day.add(Duration(minutes: r.minuteOfDay));
        if (!at.isAfter(input.now)) continue;
        if (input.smartSuppression && input.isDone(r, key)) continue;
        final habitName = r.habitId == null
            ? null
            : input.habitNames[r.habitId];
        if (r.kind == ReminderKind.habit && habitName == null) continue;
        final copy = input.copy(r, habitName);
        result.add(
          ScheduledReminder(
            id: id++,
            title: copy.title,
            body: copy.body,
            at: at,
          ),
        );
      }
    }
    result.sort((a, b) => a.at.compareTo(b.at));
    return result.take(maxPending).toList();
  }

  static bool _occursOn(Reminder r, DateTime day) {
    if (r.kind == ReminderKind.monthlyReview) {
      return addDays(day, 1).month != day.month;
    }
    return maskHas(r.weekdays, day.weekday);
  }
}
