import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';

class FinanceTotals {
  const FinanceTotals({
    this.incomeMinor = 0,
    this.expenseMinor = 0,
    this.savingMinor = 0,
  });

  final int incomeMinor;
  final int expenseMinor;
  final int savingMinor;

  /// Income left after expenses and savings allocations.
  int get netMinor => incomeMinor - expenseMinor - savingMinor;

  double? get savingsRate =>
      incomeMinor <= 0 ? null : savingMinor / incomeMinor;

  bool get isEmpty => incomeMinor == 0 && expenseMinor == 0 && savingMinor == 0;
}

class CategoryTotal {
  const CategoryTotal(this.category, this.amountMinor, this.count);

  final String category;
  final int amountMinor;
  final int count;
}

class CashFlowBucket {
  const CashFlowBucket(this.label, this.inflowMinor, this.outflowMinor);

  final String label;
  final int inflowMinor;
  final int outflowMinor;
}

abstract final class FinanceStats {
  static FinanceTotals totals(Iterable<FinanceTransaction> items) {
    var income = 0, expense = 0, saving = 0;
    for (final t in items) {
      switch (t.type) {
        case TransactionType.income:
          income += t.amountMinor;
        case TransactionType.expense:
          expense += t.amountMinor;
        case TransactionType.saving:
          saving += t.amountMinor;
      }
    }
    return FinanceTotals(
      incomeMinor: income,
      expenseMinor: expense,
      savingMinor: saving,
    );
  }

  static List<CategoryTotal> spendingByCategory(
    Iterable<FinanceTransaction> items,
  ) {
    final sums = <String, (int, int)>{};
    for (final t in items.where((t) => t.type == TransactionType.expense)) {
      final (amount, count) = sums[t.category] ?? (0, 0);
      sums[t.category] = (amount + t.amountMinor, count + 1);
    }
    return [
      for (final MapEntry(:key, value: (amount, count)) in sums.entries)
        CategoryTotal(key, amount, count),
    ]..sort((a, b) => b.amountMinor.compareTo(a.amountMinor));
  }

  /// Weekly buckets (W1…W5) for a month, monthly buckets for a year.
  static List<CashFlowBucket> cashFlow(
    Iterable<FinanceTransaction> items,
    PeriodRange range, {
    required List<String> monthLabels,
  }) {
    final yearly = range.kind == PeriodKind.year;
    final count = yearly ? 12 : ((range.lengthInDays + 6) ~/ 7);
    final inflow = List.filled(count, 0);
    final outflow = List.filled(count, 0);
    for (final t in items) {
      final at = t.occurredAt.toLocal();
      if (!range.contains(at)) continue;
      final index = yearly
          ? at.month - 1
          : (startOfDay(at).difference(range.start).inDays ~/ 7).clamp(
              0,
              count - 1,
            );
      if (t.type == TransactionType.income) {
        inflow[index] += t.amountMinor;
      } else if (t.type == TransactionType.expense) {
        outflow[index] += t.amountMinor;
      }
    }
    return [
      for (var i = 0; i < count; i++)
        CashFlowBucket(
          yearly ? monthLabels[i] : 'W${i + 1}',
          inflow[i],
          outflow[i],
        ),
    ];
  }

  /// Relative change in expenses versus [previous]; null without a baseline.
  static double? expenseChange(FinanceTotals current, FinanceTotals previous) {
    if (previous.expenseMinor <= 0) return null;
    return (current.expenseMinor - previous.expenseMinor) /
        previous.expenseMinor;
  }
}
