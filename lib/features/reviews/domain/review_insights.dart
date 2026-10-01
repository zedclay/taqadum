import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../goals/data/goals_repository.dart';
import '../../progress/domain/progress_calculator.dart';

/// The week a weekly review covers: the current week once at least five of
/// its days have passed, otherwise the week before.
PeriodRange reviewWeek(DateTime today, {int weekStart = DateTime.monday}) {
  final current = PeriodRange.week(today, weekStart: weekStart);
  return current.elapsedDays(today).length >= 5 ? current : current.previous;
}

/// The month a monthly review covers: the current month during its last
/// five days, otherwise the month before.
PeriodRange reviewMonth(DateTime today) {
  final current = PeriodRange.month(today);
  final left = current.lengthInDays - today.day;
  return left < 5 ? current : current.previous;
}

/// How far a goal moved inside a period.
class GoalMovement {
  const GoalMovement({
    required this.view,
    required this.moved,
    required this.logs,
    required this.milestones,
  });

  final GoalView view;
  final double moved;
  final int logs;
  final int milestones;

  bool get hasMoved => logs > 0 || milestones > 0;
}

List<GoalMovement> goalMovements({
  required List<GoalView> views,
  required List<GoalProgressEvent> events,
  required List<GoalMilestone> milestones,
  required PeriodRange range,
}) {
  return [
    for (final v in views)
      () {
        final own = events.where(
          (e) => e.goalId == v.goal.id && range.contains(e.occurredAt),
        );
        final done = milestones
            .where(
              (m) =>
                  m.goalId == v.goal.id &&
                  m.completedAt != null &&
                  range.contains(m.completedAt!),
            )
            .length;
        return GoalMovement(
          view: v,
          moved: own.fold(0.0, (s, e) => s + e.delta),
          logs: own.length,
          milestones: done,
        );
      }(),
  ];
}

enum WinKind { goalCompleted, milestone, goalMoved, consistency }

class ReviewWin {
  const ReviewWin({
    required this.kind,
    required this.title,
    this.area,
    this.detail,
    this.amount,
    this.goal,
    this.days,
  });

  final WinKind kind;
  final String title;
  final LifeArea? area;
  final String? detail;
  final double? amount;
  final Goal? goal;
  final int? days;
}

/// Highlights for a period, most significant first.
List<ReviewWin> reviewWins({
  required List<ActivityEvent> events,
  required List<GoalMovement> movements,
  required PeriodSummary summary,
  int limit = 3,
}) {
  final wins = <ReviewWin>[];
  final seen = <String>{};
  final ordered = [...events]
    ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
  for (final e in ordered) {
    if (e.type == ActivityType.completed && e.entityType == 'goal') {
      if (seen.add('goal:${e.title}')) {
        wins.add(
          ReviewWin(kind: WinKind.goalCompleted, title: e.title, area: e.area),
        );
      }
    }
  }
  for (final e in ordered) {
    if (e.type == ActivityType.milestone && seen.add('m:${e.title}')) {
      wins.add(
        ReviewWin(
          kind: WinKind.milestone,
          title: e.title,
          area: e.area,
          detail: e.subtitle,
        ),
      );
    }
  }
  final moved =
      movements
          .where(
            (m) =>
                m.moved > 0 &&
                m.view.goal.type != GoalType.milestone &&
                !seen.contains('goal:${m.view.goal.title}'),
          )
          .toList()
        ..sort((a, b) => _share(b).compareTo(_share(a)));
  for (final m in moved.take(2)) {
    wins.add(
      ReviewWin(
        kind: WinKind.goalMoved,
        title: m.view.goal.title,
        area: m.view.goal.area,
        amount: m.moved,
        goal: m.view.goal,
      ),
    );
  }
  final strongest = summary.strongest;
  if (strongest != null && strongest.activeDays >= 3) {
    wins.add(
      ReviewWin(
        kind: WinKind.consistency,
        title: '',
        area: strongest.area,
        days: strongest.activeDays,
      ),
    );
  }
  return wins.take(limit).toList();
}

double _share(GoalMovement m) {
  final g = m.view.goal;
  final target = g.type == GoalType.routine
      ? g.periodTarget.toDouble()
      : (g.targetValue - g.startValue).abs();
  return target <= 0 ? 0 : m.moved / target;
}

enum GapKind { routineShort, noProgress, lowConsistency }

class ReviewGap {
  const ReviewGap({
    required this.kind,
    required this.title,
    this.area,
    this.done,
    this.target,
    this.consistency,
  });

  final GapKind kind;
  final String title;
  final LifeArea? area;
  final double? done;
  final double? target;
  final double? consistency;
}

/// What did not move in [range]: routine goals below their cadence,
/// active goals with no logged progress, and the weakest area.
List<ReviewGap> reviewGaps({
  required List<GoalMovement> movements,
  required PeriodSummary summary,
  required PeriodRange range,
  int limit = 3,
}) {
  final gaps = <ReviewGap>[];
  final weeks = (range.lengthInDays / 7).round().clamp(1, 6);
  for (final m in movements) {
    final g = m.view.goal;
    if (g.status != GoalStatus.active) continue;
    if (!g.createdAt.isBefore(range.end)) continue;
    if (g.type == GoalType.routine) {
      final expected = switch (g.frequency) {
        GoalFrequency.daily => g.periodTarget * range.lengthInDays,
        GoalFrequency.weekly => g.periodTarget * weeks,
        GoalFrequency.monthly =>
          range.kind == PeriodKind.month ? g.periodTarget : 0,
        GoalFrequency.once => 0,
      };
      if (expected > 0 && m.moved < expected) {
        gaps.add(
          ReviewGap(
            kind: GapKind.routineShort,
            title: g.title,
            area: g.area,
            done: m.moved,
            target: expected.toDouble(),
          ),
        );
      }
    } else if (!m.hasMoved) {
      gaps.add(
        ReviewGap(kind: GapKind.noProgress, title: g.title, area: g.area),
      );
    }
  }
  final weakest = summary.weakest;
  if (weakest != null && gaps.length < limit) {
    gaps.add(
      ReviewGap(
        kind: GapKind.lowConsistency,
        title: '',
        area: weakest.area,
        consistency: weakest.consistency,
      ),
    );
  }
  return gaps.take(limit).toList();
}

/// Average day score on days with a morning check-in minus days without.
/// Null when either group has fewer than two counted days.
double? checkInLift({
  required PeriodSummary summary,
  required Set<String> checkInDays,
  required DateTime today,
}) {
  final keys = summary.range
      .elapsedDays(today)
      .map(dayKeyOf)
      .where((k) => summary.scores[k]?.active ?? false);
  final withCheckIn = <double>[];
  final without = <double>[];
  for (final k in keys) {
    final score = summary.scores[k]!.score;
    (checkInDays.contains(k) ? withCheckIn : without).add(score);
  }
  if (withCheckIn.length < 2 || without.length < 2) return null;
  double avg(List<double> v) => v.reduce((a, b) => a + b) / v.length;
  return avg(withCheckIn) - avg(without);
}
