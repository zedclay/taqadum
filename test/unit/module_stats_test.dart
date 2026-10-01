import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/domain/period.dart';
import 'package:taqadum/features/finance/domain/finance_stats.dart';
import 'package:taqadum/features/quran/domain/quran_stats.dart';
import 'package:taqadum/features/today/domain/today_summary.dart';
import 'package:taqadum/features/work/domain/work_stats.dart';

import '../helpers/fixtures.dart';

FinanceTransaction _tx(
  TransactionType type,
  int amount,
  DateTime at, {
  String category = 'General',
}) => FinanceTransaction(
  id: '$type-$amount-${at.microsecondsSinceEpoch}',
  type: type,
  amountMinor: amount,
  category: category,
  tag: MoneyTag.personal,
  occurredAt: at,
);

QuranLog _quran(QuranKind kind, DateTime at, {double pages = 0, int min = 0}) =>
    QuranLog(
      id: '$kind-${at.microsecondsSinceEpoch}',
      kind: kind,
      pages: pages,
      minutes: min,
      occurredAt: at,
    );

WorkActivity _work(
  WorkKind kind,
  DateTime at, {
  int? minutes,
  int? value,
  DateTime? scheduledAt,
}) => WorkActivity(
  id: '$kind-${at.microsecondsSinceEpoch}',
  kind: kind,
  title: kind.name,
  minutes: minutes,
  valueMinor: value,
  scheduledAt: scheduledAt,
  occurredAt: at,
);

void main() {
  group('FinanceStats', () {
    final march = DateTime(2027, 3, 10);
    final items = [
      _tx(TransactionType.income, 1000000, DateTime(2027, 3, 1)),
      _tx(TransactionType.expense, 20000, march, category: 'Food'),
      _tx(TransactionType.expense, 50000, march, category: 'Rent'),
      _tx(TransactionType.expense, 10000, march, category: 'Food'),
      _tx(TransactionType.saving, 200000, DateTime(2027, 3, 20)),
    ];

    test('totals, net and savings rate', () {
      final t = FinanceStats.totals(items);
      expect(t.incomeMinor, 1000000);
      expect(t.expenseMinor, 80000);
      expect(t.savingMinor, 200000);
      expect(t.netMinor, 720000);
      expect(t.savingsRate, 0.2);
      expect(const FinanceTotals().savingsRate, isNull);
    });

    test('spending by category is sorted by amount', () {
      final cats = FinanceStats.spendingByCategory(items);
      expect(cats.map((c) => c.category), ['Rent', 'Food']);
      expect(cats.last.amountMinor, 30000);
      expect(cats.last.count, 2);
    });

    test('cash flow buckets a month by week', () {
      final flow = FinanceStats.cashFlow(
        items,
        PeriodRange.month(march),
        monthLabels: const [],
      );
      expect(flow.length, 5);
      expect(flow[0].inflowMinor, 1000000);
      expect(flow[1].outflowMinor, 80000);
    });

    test('expense change needs a baseline', () {
      expect(
        FinanceStats.expenseChange(
          const FinanceTotals(expenseMinor: 150),
          const FinanceTotals(expenseMinor: 100),
        ),
        0.5,
      );
      expect(
        FinanceStats.expenseChange(
          const FinanceTotals(expenseMinor: 150),
          const FinanceTotals(),
        ),
        isNull,
      );
    });
  });

  group('QuranStats', () {
    final today = DateTime(2027, 3, 10, 21);

    test('totals by kind', () {
      final t = QuranStats.totals([
        _quran(QuranKind.reading, today, pages: 4),
        _quran(QuranKind.reading, today, pages: 2),
        _quran(QuranKind.memorization, today, pages: 1),
        _quran(QuranKind.revision, today, min: 20),
      ]);
      expect(t.readPages, 6);
      expect(t.memorizedPages, 1);
      expect(t.revisionMinutes, 20);
    });

    test('streak counts back from today or yesterday', () {
      expect(
        QuranStats.streak({'2027-03-10', '2027-03-09', '2027-03-08'}, today),
        3,
      );
      expect(QuranStats.streak({'2027-03-09', '2027-03-08'}, today), 2);
      expect(QuranStats.streak({'2027-03-07'}, today), 0);
    });

    test('consistency note recognises a return after a gap', () {
      expect(QuranStats.note({}, today), ConsistencyNote.start);
      expect(
        QuranStats.note({'2027-03-10', '2027-03-08'}, today),
        ConsistencyNote.returned,
      );
      expect(
        QuranStats.note({'2027-03-10', '2027-03-09'}, today),
        ConsistencyNote.streak,
      );
    });
  });

  group('WorkStats', () {
    test('totals only count activity inside the range', () {
      final week = PeriodRange.week(DateTime(2027, 3, 10));
      final t = WorkStats.totals([
        _work(WorkKind.deepWork, DateTime(2027, 3, 8, 9), minutes: 90),
        _work(WorkKind.deepWork, DateTime(2027, 3, 1, 9), minutes: 60),
        _work(WorkKind.lead, DateTime(2027, 3, 9)),
        _work(WorkKind.clientWon, DateTime(2027, 3, 9), value: 500000),
        _work(
          WorkKind.meeting,
          DateTime(2027, 3, 1),
          scheduledAt: DateTime(2027, 3, 11, 10),
        ),
      ], week);
      expect(t.deepMinutes, 90);
      expect(t.leads, 1);
      expect(t.wins, 1);
      expect(t.wonValueMinor, 500000);
      expect(t.meetings, 1);
      expect(t.isEmpty, isFalse);
    });
  });

  group('TodaySummary', () {
    test('counts completion and compares with yesterday', () {
      final s = TodaySummary.of(
        [
          makeTask('2027-03-10', title: 'a', done: true),
          makeTask('2027-03-10', title: 'b'),
        ],
        yesterday: [
          makeTask('2027-03-09', title: 'a'),
          makeTask('2027-03-09', title: 'b'),
          makeTask('2027-03-09', title: 'c'),
          makeTask('2027-03-09', title: 'd'),
        ],
      );
      expect(s.total, 2);
      expect(s.left, 1);
      expect(s.percent, 50);
      expect(s.deltaVsYesterday, 0.5);
      expect(TodaySummary.of(const []).isEmpty, isTrue);
    });

    test('load compares planned minutes with capacity', () {
      expect(loadOf(0, Capacity.balanced), DayLoad.light);
      expect(loadOf(10000, Capacity.light), DayLoad.heavy);
      expect(
        loadOf(capacityMinutes(Capacity.focused), Capacity.focused),
        DayLoad.balanced,
      );
    });
  });
}
