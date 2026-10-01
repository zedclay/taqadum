import '../../../core/database/app_database.dart';

enum DayPart { morning, afternoon, evening, anytime }

enum DayLoad { light, balanced, heavy }

class TodaySummary {
  const TodaySummary({
    required this.total,
    required this.done,
    required this.priorities,
    required this.plannedMinutes,
    this.deltaVsYesterday,
  });

  factory TodaySummary.of(List<Task> today, {List<Task> yesterday = const []}) {
    final done = today.where((t) => t.completedAt != null).length;
    final priorities = today.where((t) => t.priorityRank != null).toList()
      ..sort((a, b) => a.priorityRank!.compareTo(b.priorityRank!));
    double? delta;
    if (yesterday.isNotEmpty && today.isNotEmpty) {
      final y =
          yesterday.where((t) => t.completedAt != null).length /
          yesterday.length;
      delta = done / today.length - y;
    }
    return TodaySummary(
      total: today.length,
      done: done,
      priorities: priorities,
      plannedMinutes: today.fold(0, (s, t) => s + (t.durationMinutes ?? 0)),
      deltaVsYesterday: delta,
    );
  }

  final int total;
  final int done;
  final List<Task> priorities;
  final int plannedMinutes;
  final double? deltaVsYesterday;

  int get left => total - done;
  double get ratio => total == 0 ? 0 : done / total;
  int get percent => (ratio * 100).round();
  bool get isEmpty => total == 0;
}

DayPart dayPartOf(Task task) {
  final m = task.scheduledMinute;
  if (m == null) return DayPart.anytime;
  if (m < 12 * 60) return DayPart.morning;
  if (m < 17 * 60) return DayPart.afternoon;
  return DayPart.evening;
}

/// Groups tasks into day parts, ordered by time then manual order.
Map<DayPart, List<Task>> groupByDayPart(List<Task> tasks) {
  final groups = {for (final p in DayPart.values) p: <Task>[]};
  for (final t in tasks) {
    groups[dayPartOf(t)]!.add(t);
  }
  for (final list in groups.values) {
    list.sort((a, b) {
      final byTime = (a.scheduledMinute ?? 0).compareTo(b.scheduledMinute ?? 0);
      return byTime != 0 ? byTime : a.sortOrder.compareTo(b.sortOrder);
    });
  }
  return groups;
}

int capacityMinutes(Capacity? capacity) => switch (capacity) {
  Capacity.light => 180,
  Capacity.focused => 480,
  _ => 360,
};

DayLoad loadOf(int plannedMinutes, Capacity? capacity) {
  final cap = capacityMinutes(capacity);
  if (plannedMinutes > cap * 1.15) return DayLoad.heavy;
  if (plannedMinutes < cap * 0.4) return DayLoad.light;
  return DayLoad.balanced;
}
