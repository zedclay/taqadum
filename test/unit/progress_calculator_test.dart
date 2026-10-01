import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/domain/enums.dart';
import 'package:taqadum/core/domain/period.dart';
import 'package:taqadum/features/progress/domain/progress_calculator.dart';

import '../helpers/fixtures.dart';

void main() {
  group('dayScores', () {
    test('uses task completion when a plan exists', () {
      final scores = ProgressCalculator.dayScores(
        tasks: [
          makeTask('2027-03-01', title: 'a', done: true),
          makeTask('2027-03-01', title: 'b'),
          makeTask('2027-03-01', title: 'c', done: true),
          makeTask('2027-03-01', title: 'd', done: true),
        ],
        events: const [],
      );
      expect(scores['2027-03-01']!.score, 0.75);
    });

    test('falls back to logs and ignores task events as logs', () {
      final day = DateTime(2027, 3, 2, 9);
      final scores = ProgressCalculator.dayScores(
        tasks: const [],
        events: [
          makeActivity(day),
          makeActivity(day, entityType: 'task', title: 'Done'),
          makeActivity(day, area: LifeArea.health, entityType: 'walk'),
        ],
      );
      final s = scores['2027-03-02']!;
      expect(s.logs, 2);
      expect(s.score, closeTo(2 / 3, 1e-9));
      expect(s.areas, {LifeArea.quran, LifeArea.health});
    });
  });

  test('strengthOf maps scores into bands', () {
    DayStrength band(int done, int planned) => ProgressCalculator.strengthOf(
      ProgressCalculator.dayScores(
        tasks: [
          for (var i = 0; i < planned; i++)
            makeTask('2027-03-01', title: '$i', done: i < done),
        ],
        events: const [],
      )['2027-03-01'],
      isFuture: false,
    );
    expect(band(4, 4), DayStrength.strong);
    expect(band(2, 4), DayStrength.steady);
    expect(band(1, 4), DayStrength.light);
    expect(band(0, 4), DayStrength.none);
    expect(
      ProgressCalculator.strengthOf(null, isFuture: true),
      DayStrength.future,
    );
  });

  group('summarize', () {
    final now = DateTime(2027, 3, 10, 20);
    final range = PeriodRange.week(now);

    test('averages over elapsed days and counts active days', () {
      final summary = ProgressCalculator.summarize(
        range: range,
        tasks: [
          makeTask('2027-03-08', title: 'a', done: true),
          makeTask('2027-03-09', title: 'b', done: true),
          makeTask('2027-03-09', title: 'c'),
          makeTask('2027-03-12', title: 'future'),
        ],
        events: [makeActivity(DateTime(2027, 3, 8, 9))],
        now: now,
        areas: const [LifeArea.quran, LifeArea.work],
      );
      expect(summary.elapsedDays, 3);
      expect(summary.overall, closeTo((1 + 0.5 + 0) / 3, 1e-9));
      expect(summary.activeDays, 2);
      expect(summary.completedActions, 2);
      expect(summary.plannedActions, 4);
      expect(summary.hasData, isTrue);
      final quran = summary.areas.firstWhere((a) => a.area == LifeArea.quran);
      expect(quran.activeDays, 1);
      expect(summary.strongest?.area, LifeArea.quran);
      expect(summary.trend.length, 7);
      expect(summary.trend[2].isCurrent, isTrue);
      expect(summary.trend[4].value, isNull);
    });

    test('notBefore excludes days before the account existed', () {
      final summary = ProgressCalculator.summarize(
        range: range,
        tasks: const [],
        events: [makeActivity(DateTime(2027, 3, 10, 9))],
        now: now,
        areas: const [LifeArea.quran],
        notBefore: DateTime(2027, 3, 10),
      );
      expect(summary.elapsedDays, 1);
      expect(summary.areas.single.consistency, 1);
    });

    test('computes deltas against the previous period', () {
      final summary = ProgressCalculator.summarize(
        range: range,
        tasks: [makeTask('2027-03-08', done: true)],
        events: const [],
        previousTasks: [
          for (final d in ['01', '02', '03', '04', '05', '06', '07'])
            makeTask('2027-03-$d', done: d == '01'),
        ],
        now: now,
        areas: const [LifeArea.work],
      );
      expect(summary.overallDelta, closeTo(1 / 3 - 1 / 7, 1e-9));
    });

    test('empty period has no data', () {
      final summary = ProgressCalculator.summarize(
        range: range,
        tasks: const [],
        events: const [],
        now: now,
        areas: const [LifeArea.work],
      );
      expect(summary.hasData, isFalse);
      expect(summary.overall, 0);
      expect(summary.overallDelta, isNull);
      expect(summary.strongest, isNull);
    });

    test('month trend is bucketed in weeks', () {
      final summary = ProgressCalculator.summarize(
        range: PeriodRange.month(now),
        tasks: const [],
        events: const [],
        now: now,
        areas: const [],
      );
      expect(summary.trend.map((p) => p.label), ['W1', 'W2', 'W3', 'W4', 'W5']);
      expect(summary.trend[1].isCurrent, isTrue);
      expect(summary.trend[2].value, isNull);
    });
  });
}
