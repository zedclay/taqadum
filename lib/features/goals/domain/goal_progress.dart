import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';

enum GoalHealth { onTrack, needsAttention, completed, paused }

class GoalProgress {
  const GoalProgress({
    required this.current,
    required this.target,
    required this.health,
    this.periodLabel,
  });

  final double current;
  final double target;
  final GoalHealth health;
  final PeriodKind? periodLabel;

  double get ratio => target <= 0 ? 0 : (current / target).clamp(0.0, 1.0);
  int get percent => (ratio * 100).round();
  double get remaining => (target - current).clamp(0, double.infinity);
}

abstract final class GoalProgressCalculator {
  static GoalProgress compute(
    Goal goal, {
    required List<GoalProgressEvent> events,
    required List<GoalMilestone> milestones,
    required DateTime now,
    int weekStart = DateTime.monday,
  }) {
    final own = events.where((e) => e.goalId == goal.id);
    final ownMilestones = milestones.where((m) => m.goalId == goal.id).toList();
    late final double current;
    late final double target;
    PeriodKind? period;

    switch (goal.type) {
      case GoalType.target:
        current = goal.startValue + own.fold(0.0, (s, e) => s + e.delta);
        target = goal.targetValue;
      case GoalType.routine:
        period = _periodOf(goal.frequency);
        final range = PeriodRange.of(period, now, weekStart: weekStart);
        current = own
            .where((e) => range.contains(e.occurredAt))
            .fold(0.0, (s, e) => s + e.delta);
        target = goal.periodTarget.toDouble();
      case GoalType.milestone:
        if (ownMilestones.isEmpty) {
          current = goal.startValue + own.fold(0.0, (s, e) => s + e.delta);
          target = goal.targetValue;
        } else {
          current = ownMilestones
              .where((m) => m.completedAt != null)
              .length
              .toDouble();
          target = ownMilestones.length.toDouble();
        }
    }

    final health = _health(goal, current, target, now, weekStart, period);
    return GoalProgress(
      current: current,
      target: target,
      health: health,
      periodLabel: period,
    );
  }

  static PeriodKind _periodOf(GoalFrequency f) => switch (f) {
    GoalFrequency.daily => PeriodKind.day,
    GoalFrequency.weekly => PeriodKind.week,
    GoalFrequency.monthly => PeriodKind.month,
    GoalFrequency.once => PeriodKind.year,
  };

  static GoalHealth _health(
    Goal goal,
    double current,
    double target,
    DateTime now,
    int weekStart,
    PeriodKind? period,
  ) {
    if (goal.status == GoalStatus.completed) return GoalHealth.completed;
    if (goal.status == GoalStatus.paused) return GoalHealth.paused;
    if (target > 0 && current >= target) return GoalHealth.completed;
    final ratio = target <= 0 ? 0.0 : current / target;
    final expected = expectedRatio(goal, now, weekStart: weekStart);
    return ratio + 0.05 >= expected * 0.85
        ? GoalHealth.onTrack
        : GoalHealth.needsAttention;
  }

  /// Share of the goal that should be done by [now] if progress were linear.
  static double expectedRatio(
    Goal goal,
    DateTime now, {
    int weekStart = DateTime.monday,
  }) {
    if (goal.type == GoalType.routine) {
      final range = PeriodRange.of(
        _periodOf(goal.frequency),
        now,
        weekStart: weekStart,
      );
      final total = range.end.difference(range.start).inMinutes;
      final elapsed = now.difference(range.start).inMinutes;
      return total <= 0 ? 0 : (elapsed / total).clamp(0.0, 1.0);
    }
    final deadline = goal.targetDate;
    if (deadline == null) return 0;
    final start = goal.createdAt;
    final total = deadline.difference(start).inHours;
    if (total <= 0) return 1;
    final baseline = goal.targetValue <= 0
        ? 0.0
        : (goal.startValue / goal.targetValue).clamp(0.0, 1.0);
    final elapsed = (now.difference(start).inHours / total).clamp(0.0, 1.0);
    return baseline + (1 - baseline) * elapsed;
  }
}

/// Converts a module log into the unit of a linked goal.
abstract final class GoalContribution {
  static const pagesPerJuz = 20;

  static double deltaFor(
    Goal goal, {
    double? pages,
    int? minutes,
    double? money,
    int count = 1,
  }) {
    if (goal.type == GoalType.routine) return count.toDouble();
    final unit = goal.unit.toLowerCase().trim();
    if (unit.contains('juz')) return (pages ?? 0) / pagesPerJuz;
    if (unit.contains('page')) return pages ?? 0;
    if (unit.contains('hour') || unit == 'h' || unit == 'hrs') {
      return (minutes ?? 0) / 60;
    }
    if (unit.contains('min')) return (minutes ?? 0).toDouble();
    if (money != null) return money;
    if (pages != null) return pages;
    if (minutes != null) return minutes / 60;
    return count.toDouble();
  }

  /// The goal a new log in [area] counts toward by default.
  static Goal? defaultGoal(List<Goal> goals, LifeArea area) {
    final candidates = goals
        .where((g) => g.area == area && g.status == GoalStatus.active)
        .toList();
    if (candidates.isEmpty) return null;
    return candidates.firstWhere(
      (g) => g.isPrimary,
      orElse: () => candidates.first,
    );
  }
}
