import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/domain/period.dart';
import 'package:taqadum/features/goals/domain/goal_progress.dart';

import '../helpers/fixtures.dart';

GoalMilestone _milestone(String id, {bool done = false}) => GoalMilestone(
  id: id,
  goalId: 'g1',
  title: id,
  completedAt: done ? DateTime(2027, 1, 5) : null,
  sortOrder: 0,
);

void main() {
  final now = DateTime(2027, 3, 10, 12);

  group('GoalProgressCalculator', () {
    test('target goal sums start value and deltas', () {
      final goal = makeGoal(startValue: 10, targetValue: 50);
      final p = GoalProgressCalculator.compute(
        goal,
        events: [
          makeEvent('g1', 15, DateTime(2027, 3, 1)),
          makeEvent('g1', 5, DateTime(2027, 3, 2)),
          makeEvent('other', 100, DateTime(2027, 3, 2)),
        ],
        milestones: const [],
        now: now,
      );
      expect(p.current, 30);
      expect(p.target, 50);
      expect(p.percent, 60);
      expect(p.remaining, 20);
    });

    test('routine goal only counts the current period', () {
      final goal = makeGoal(
        type: GoalType.routine,
        frequency: GoalFrequency.weekly,
        periodTarget: 3,
      );
      final p = GoalProgressCalculator.compute(
        goal,
        events: [
          makeEvent('g1', 1, DateTime(2027, 3, 8, 7)),
          makeEvent('g1', 1, DateTime(2027, 3, 9, 7)),
          makeEvent('g1', 1, DateTime(2027, 3, 5, 7)),
        ],
        milestones: const [],
        now: now,
      );
      expect(p.current, 2);
      expect(p.target, 3);
      expect(p.periodLabel, PeriodKind.week);
    });

    test('milestone goal counts completed milestones', () {
      final goal = makeGoal(type: GoalType.milestone);
      final p = GoalProgressCalculator.compute(
        goal,
        events: const [],
        milestones: [
          _milestone('a', done: true),
          _milestone('b'),
          _milestone('c'),
          _milestone('d', done: true),
        ],
        now: now,
      );
      expect(p.current, 2);
      expect(p.target, 4);
      expect(p.ratio, 0.5);
    });

    test('health reflects deadline pace', () {
      final goal = makeGoal(
        createdAt: DateTime(2027, 1, 1),
        targetDate: DateTime(2027, 12, 31),
      );
      GoalHealth healthAt(double done) => GoalProgressCalculator.compute(
        goal,
        events: [makeEvent('g1', done, DateTime(2027, 2, 1))],
        milestones: const [],
        now: DateTime(2027, 7, 1),
      ).health;

      expect(healthAt(50), GoalHealth.onTrack);
      expect(healthAt(5), GoalHealth.needsAttention);
      expect(healthAt(100), GoalHealth.completed);
    });

    test('paused status wins over progress', () {
      final goal = makeGoal(status: GoalStatus.paused);
      final p = GoalProgressCalculator.compute(
        goal,
        events: const [],
        milestones: const [],
        now: now,
      );
      expect(p.health, GoalHealth.paused);
    });
  });

  group('GoalContribution', () {
    test('converts module logs into goal units', () {
      expect(GoalContribution.deltaFor(makeGoal(unit: 'pages'), pages: 4), 4);
      expect(GoalContribution.deltaFor(makeGoal(unit: 'juz'), pages: 10), 0.5);
      expect(
        GoalContribution.deltaFor(makeGoal(unit: 'hours'), minutes: 90),
        1.5,
      );
      expect(
        GoalContribution.deltaFor(makeGoal(unit: 'minutes'), minutes: 25),
        25,
      );
      expect(GoalContribution.deltaFor(makeGoal(unit: 'SAR'), money: 250), 250);
      expect(
        GoalContribution.deltaFor(
          makeGoal(type: GoalType.routine),
          minutes: 45,
        ),
        1,
      );
    });

    test('defaultGoal prefers the primary active goal of an area', () {
      final goals = [
        makeGoal(id: 'a', area: LifeArea.quran),
        makeGoal(id: 'b', area: LifeArea.quran, isPrimary: true),
        makeGoal(id: 'c', area: LifeArea.work, isPrimary: true),
        makeGoal(id: 'd', area: LifeArea.quran, status: GoalStatus.paused),
      ];
      expect(GoalContribution.defaultGoal(goals, LifeArea.quran)?.id, 'b');
      expect(GoalContribution.defaultGoal(goals, LifeArea.finance), isNull);
    });
  });
}
