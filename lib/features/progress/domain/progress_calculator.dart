import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';

class DayScore {
  const DayScore({
    required this.dayKey,
    this.planned = 0,
    this.completed = 0,
    this.logs = 0,
    this.areas = const {},
  });

  final String dayKey;
  final int planned;
  final int completed;
  final int logs;
  final Set<LifeArea> areas;

  /// Task completion when a plan exists, otherwise logged activity (3 logs = full day).
  double get score {
    if (planned > 0) return (completed / planned).clamp(0.0, 1.0);
    return (logs / 3).clamp(0.0, 1.0);
  }

  bool get active => completed > 0 || logs > 0;
}

class AreaStat {
  const AreaStat({
    required this.area,
    required this.activeDays,
    required this.consistency,
    this.delta,
  });

  final LifeArea area;
  final int activeDays;
  final double consistency;
  final double? delta;
}

class TrendPoint {
  const TrendPoint(this.label, this.value, {this.isCurrent = false});
  final String label;
  final double? value;
  final bool isCurrent;
}

class PeriodSummary {
  const PeriodSummary({
    required this.range,
    required this.scores,
    required this.elapsedDays,
    required this.overall,
    required this.activeDays,
    required this.completedActions,
    required this.plannedActions,
    required this.areas,
    required this.trend,
    this.overallDelta,
    this.strongestWeekdays = const [],
  });

  final PeriodRange range;
  final Map<String, DayScore> scores;
  final int elapsedDays;
  final double overall;
  final int activeDays;
  final int completedActions;
  final int plannedActions;
  final List<AreaStat> areas;
  final List<TrendPoint> trend;
  final double? overallDelta;
  final List<int> strongestWeekdays;

  bool get hasData => activeDays > 0 || plannedActions > 0;

  AreaStat? get strongest {
    final active = areas.where((a) => a.activeDays > 0).toList()
      ..sort((a, b) => b.consistency.compareTo(a.consistency));
    return active.firstOrNull;
  }

  AreaStat? get weakest {
    if (areas.length < 2) return null;
    final sorted = [...areas]
      ..sort((a, b) => a.consistency.compareTo(b.consistency));
    final w = sorted.first;
    return w.consistency < 0.5 && w != strongest ? w : null;
  }
}

abstract final class ProgressCalculator {
  static const strongThreshold = 0.75;
  static const steadyThreshold = 0.4;

  static Map<String, DayScore> dayScores({
    required List<Task> tasks,
    required List<ActivityEvent> events,
  }) {
    final planned = <String, int>{};
    final completed = <String, int>{};
    for (final t in tasks) {
      planned.update(t.dayKey, (v) => v + 1, ifAbsent: () => 1);
      if (t.completedAt != null) {
        completed.update(t.dayKey, (v) => v + 1, ifAbsent: () => 1);
      }
    }
    final logs = <String, int>{};
    final areas = <String, Set<LifeArea>>{};
    for (final e in events) {
      final key = dayKeyOf(e.occurredAt);
      if (e.area != null) (areas[key] ??= {}).add(e.area!);
      if (e.entityType != 'task') {
        logs.update(key, (v) => v + 1, ifAbsent: () => 1);
      }
    }
    final keys = {...planned.keys, ...logs.keys, ...areas.keys};
    return {
      for (final k in keys)
        k: DayScore(
          dayKey: k,
          planned: planned[k] ?? 0,
          completed: completed[k] ?? 0,
          logs: logs[k] ?? 0,
          areas: areas[k] ?? const {},
        ),
    };
  }

  static DayStrength strengthOf(DayScore? score, {required bool isFuture}) {
    if (isFuture) return DayStrength.future;
    if (score == null || !score.active) return DayStrength.none;
    final s = score.score;
    if (s >= strongThreshold) return DayStrength.strong;
    if (s >= steadyThreshold) return DayStrength.steady;
    return DayStrength.light;
  }

  static List<DateTime> countedDays(
    PeriodRange range,
    DateTime now, {
    DateTime? notBefore,
  }) {
    final floor = notBefore == null ? null : startOfDay(notBefore);
    return range
        .elapsedDays(now)
        .where((d) => floor == null || !d.isBefore(floor))
        .toList();
  }

  static PeriodSummary summarize({
    required PeriodRange range,
    required List<Task> tasks,
    required List<ActivityEvent> events,
    required DateTime now,
    required List<LifeArea> areas,
    List<Task> previousTasks = const [],
    List<ActivityEvent> previousEvents = const [],
    DateTime? notBefore,
  }) {
    final scores = dayScores(tasks: tasks, events: events);
    final days = countedDays(range, now, notBefore: notBefore);
    final keys = days.map(dayKeyOf).toList();
    final daily = [for (final k in keys) scores[k]];
    final overall = keys.isEmpty
        ? 0.0
        : daily.fold(0.0, (s, d) => s + (d?.score ?? 0)) / keys.length;
    final activeDays = daily.where((d) => d?.active ?? false).length;
    final inRange = tasks.where((t) => range.containsKey(t.dayKey));

    final prev = _previous(
      range.previous,
      previousTasks,
      previousEvents,
      notBefore,
    );

    final areaStats = [
      for (final area in areas)
        _areaStat(area, keys, scores, prev?.$2, range.previous, notBefore),
    ];

    return PeriodSummary(
      range: range,
      scores: scores,
      elapsedDays: keys.length,
      overall: overall,
      activeDays: activeDays,
      completedActions: inRange.where((t) => t.completedAt != null).length,
      plannedActions: inRange.length,
      areas: areaStats,
      trend: _trend(range, scores, now),
      overallDelta: prev == null ? null : overall - prev.$1,
      strongestWeekdays: _strongestWeekdays(days, scores),
    );
  }

  static (double, Map<String, DayScore>)? _previous(
    PeriodRange range,
    List<Task> tasks,
    List<ActivityEvent> events,
    DateTime? notBefore,
  ) {
    if (tasks.isEmpty && events.isEmpty) return null;
    final scores = dayScores(tasks: tasks, events: events);
    final days = countedDays(range, range.end, notBefore: notBefore);
    if (days.isEmpty) return null;
    final active = days.where((d) => scores[dayKeyOf(d)]?.active ?? false);
    if (active.isEmpty) return null;
    final overall =
        days.fold(0.0, (s, d) => s + (scores[dayKeyOf(d)]?.score ?? 0)) /
        days.length;
    return (overall, scores);
  }

  static AreaStat _areaStat(
    LifeArea area,
    List<String> keys,
    Map<String, DayScore> scores,
    Map<String, DayScore>? previous,
    PeriodRange previousRange,
    DateTime? notBefore,
  ) {
    final active = keys.where((k) => scores[k]?.areas.contains(area) ?? false);
    final consistency = keys.isEmpty ? 0.0 : active.length / keys.length;
    double? delta;
    if (previous != null) {
      final prevDays = countedDays(
        previousRange,
        previousRange.end,
        notBefore: notBefore,
      ).map(dayKeyOf).toList();
      final prevActive = prevDays.where(
        (k) => previous[k]?.areas.contains(area) ?? false,
      );
      if (prevDays.isNotEmpty) {
        delta = consistency - prevActive.length / prevDays.length;
      }
    }
    return AreaStat(
      area: area,
      activeDays: active.length,
      consistency: consistency,
      delta: delta,
    );
  }

  static List<TrendPoint> _trend(
    PeriodRange range,
    Map<String, DayScore> scores,
    DateTime now,
  ) {
    final today = startOfDay(now);
    double? mean(Iterable<DateTime> days) {
      final elapsed = days.where((d) => !d.isAfter(today)).toList();
      if (elapsed.isEmpty) return null;
      return elapsed.fold(
            0.0,
            (s, d) => s + (scores[dayKeyOf(d)]?.score ?? 0),
          ) /
          elapsed.length;
    }

    switch (range.kind) {
      case PeriodKind.day:
      case PeriodKind.week:
        return [
          for (final d in range.days)
            TrendPoint(
              '${d.weekday}',
              d.isAfter(today) ? null : (scores[dayKeyOf(d)]?.score ?? 0),
              isCurrent: d == today,
            ),
        ];
      case PeriodKind.month:
        final days = range.days;
        final points = <TrendPoint>[];
        for (var i = 0; i < days.length; i += 7) {
          final chunk = days.skip(i).take(7).toList();
          points.add(
            TrendPoint(
              'W${i ~/ 7 + 1}',
              mean(chunk),
              isCurrent: chunk.contains(today),
            ),
          );
        }
        return points;
      case PeriodKind.year:
        return [
          for (var m = 1; m <= 12; m++)
            TrendPoint(
              '$m',
              mean(PeriodRange.month(DateTime(range.start.year, m)).days),
              isCurrent: today.year == range.start.year && today.month == m,
            ),
        ];
    }
  }

  static List<int> _strongestWeekdays(
    List<DateTime> days,
    Map<String, DayScore> scores,
  ) {
    if (days.length < 14) return const [];
    final sums = <int, double>{};
    final counts = <int, int>{};
    for (final d in days) {
      sums.update(
        d.weekday,
        (v) => v + (scores[dayKeyOf(d)]?.score ?? 0),
        ifAbsent: () => scores[dayKeyOf(d)]?.score ?? 0,
      );
      counts.update(d.weekday, (v) => v + 1, ifAbsent: () => 1);
    }
    final means = {for (final w in sums.keys) w: sums[w]! / counts[w]!};
    final sorted = means.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (sorted.isEmpty || sorted.first.value == 0) return const [];
    return sorted.take(2).map((e) => e.key).toList();
  }
}
