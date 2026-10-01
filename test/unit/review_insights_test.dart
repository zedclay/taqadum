import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/domain/period.dart';
import 'package:taqadum/features/goals/data/goals_repository.dart';
import 'package:taqadum/features/goals/domain/goal_progress.dart';
import 'package:taqadum/features/progress/domain/progress_calculator.dart';
import 'package:taqadum/features/reviews/domain/review_insights.dart';

import '../helpers/fixtures.dart';

GoalView _view(Goal goal) => GoalView(
  goal,
  const GoalProgress(current: 0, target: 1, health: GoalHealth.onTrack),
);

void main() {
  group('review periods', () {
    test('weekly review covers this week from its fifth day', () {
      final thursday = DateTime(2027, 3, 11);
      final friday = DateTime(2027, 3, 12);
      expect(reviewWeek(thursday).startKey, '2027-03-01');
      expect(reviewWeek(friday).startKey, '2027-03-08');
      expect(
        reviewWeek(friday, weekStart: DateTime.saturday).startKey,
        '2027-03-06',
      );
    });

    test('monthly review covers this month in its last days', () {
      expect(reviewMonth(DateTime(2027, 3, 10)).startKey, '2027-02-01');
      expect(reviewMonth(DateTime(2027, 3, 28)).startKey, '2027-03-01');
    });
  });

  group('movements and gaps', () {
    final range = PeriodRange.week(DateTime(2027, 3, 10));
    final now = DateTime(2027, 3, 14, 20);
    final summary = ProgressCalculator.summarize(
      range: range,
      tasks: const [],
      events: [
        for (var d = 8; d <= 14; d++)
          makeActivity(DateTime(2027, 3, d, 9), area: LifeArea.quran),
      ],
      now: now,
      areas: const [LifeArea.quran, LifeArea.health],
    );

    final workouts = makeGoal(
      id: 'workouts',
      title: 'Workouts',
      area: LifeArea.health,
      type: GoalType.routine,
      periodTarget: 3,
    );
    final revenue = makeGoal(id: 'revenue', title: 'Revenue');
    final memorize = makeGoal(id: 'memorize', area: LifeArea.quran);
    final paused = makeGoal(id: 'paused', status: GoalStatus.paused);
    final future = makeGoal(id: 'future', createdAt: DateTime(2027, 4));

    final movements = goalMovements(
      views: [workouts, revenue, memorize, paused, future].map(_view).toList(),
      events: [
        makeEvent('workouts', 1, DateTime(2027, 3, 9)),
        makeEvent('memorize', 2, DateTime(2027, 3, 10)),
        makeEvent('memorize', 3, DateTime(2027, 3, 1)),
      ],
      milestones: const [],
      range: range,
    );

    test('movement only counts in-range progress', () {
      final memo = movements.firstWhere((m) => m.view.goal.id == 'memorize');
      expect(memo.moved, 2);
      expect(memo.logs, 1);
      expect(memo.hasMoved, isTrue);
      final rev = movements.firstWhere((m) => m.view.goal.id == 'revenue');
      expect(rev.hasMoved, isFalse);
    });

    test('gaps list routines short of cadence and stalled goals', () {
      final gaps = reviewGaps(
        movements: movements,
        summary: summary,
        range: range,
      );
      expect(gaps.map((g) => g.kind), [
        GapKind.routineShort,
        GapKind.noProgress,
        GapKind.lowConsistency,
      ]);
      expect(gaps.first.done, 1);
      expect(gaps.first.target, 3);
      expect(gaps.last.area, LifeArea.health);
    });

    test('wins include the goals that moved most', () {
      final wins = reviewWins(
        events: const [],
        movements: movements,
        summary: summary,
      );
      expect(wins.any((w) => w.kind == WinKind.goalMoved), isTrue);
      expect(wins.any((w) => w.kind == WinKind.consistency), isTrue);
    });
  });

  test('check-in lift compares days with and without a check-in', () {
    final today = DateTime(2027, 3, 14, 20);
    final range = PeriodRange.week(today);
    final summary = ProgressCalculator.summarize(
      range: range,
      tasks: [
        for (final (i, d) in ['08', '09', '10', '11'].indexed) ...[
          makeTask('2027-03-$d', title: 'a', done: true),
          makeTask('2027-03-$d', title: 'b', done: i < 2),
        ],
      ],
      events: const [],
      now: today,
      areas: const [LifeArea.work],
    );
    final lift = checkInLift(
      summary: summary,
      checkInDays: {'2027-03-08', '2027-03-09'},
      today: today,
    );
    expect(lift, closeTo(0.5, 1e-9));
    expect(
      checkInLift(summary: summary, checkInDays: const {}, today: today),
      isNull,
    );
  });
}
