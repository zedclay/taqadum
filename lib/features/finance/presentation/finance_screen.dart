import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/relative_time.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/module_scaffold.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/segmented.dart';
import '../../../core/widgets/states.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../settings/data/preferences.dart';
import '../data/finance_repository.dart';
import '../domain/finance_categories.dart';
import '../domain/finance_stats.dart';
import 'transaction_form.dart';
import '../../../core/utilities/bidi.dart';

enum _FinancePeriod { thisMonth, lastMonth, year }

IconData categoryIcon(String category) => switch (category) {
  FinanceCategories.food => Symbols.restaurant,
  FinanceCategories.transport => Symbols.directions_car,
  FinanceCategories.home => Symbols.home,
  FinanceCategories.bills => Symbols.receipt_long,
  FinanceCategories.family => Symbols.family_restroom,
  FinanceCategories.health => Symbols.favorite,
  FinanceCategories.education => Symbols.school,
  FinanceCategories.business => Symbols.business_center,
  FinanceCategories.shopping => Symbols.shopping_bag,
  FinanceCategories.salary => Symbols.payments,
  FinanceCategories.clientPayment => Symbols.handshake,
  FinanceCategories.freelance => Symbols.laptop_mac,
  FinanceCategories.gift => Symbols.redeem,
  FinanceCategories.emergency => Symbols.shield,
  FinanceCategories.savingsGoal => Symbols.savings,
  FinanceCategories.investment => Symbols.trending_up,
  _ => Symbols.category,
};

Color transactionColor(TransactionType type) => switch (type) {
  TransactionType.income => AppColors.success,
  TransactionType.expense => AppColors.textPrimary,
  TransactionType.saving => AppColors.primaryStrong,
};

class FinanceScreen extends ConsumerStatefulWidget {
  const FinanceScreen({super.key});

  @override
  ConsumerState<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends ConsumerState<FinanceScreen> {
  _FinancePeriod _period = _FinancePeriod.thisMonth;

  PeriodRange _rangeFor(DateTime today) => switch (_period) {
    _FinancePeriod.thisMonth => PeriodRange.month(today),
    _FinancePeriod.lastMonth => PeriodRange.month(today).previous,
    _FinancePeriod.year => PeriodRange.year(today),
  };

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final range = _rangeFor(today);
    final items = ref.watch(transactionsInRangeProvider(range));
    return ModuleScaffold(
      title: l.financeTitle,
      subtitle: l.financeSubtitle,
      actions: [
        CircleIconButton(
          icon: Symbols.calendar_month,
          tooltip: l.commonHistory,
          background: Colors.transparent,
          onPressed: () => context.push(AppRoutes.activity),
        ),
      ],
      children: [
        AsyncView<List<FinanceTransaction>>(
          value: items,
          builder: (list) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_period == _FinancePeriod.thisMonth)
                _ComparisonBanner(current: list),
              _NetCard(
                totals: FinanceStats.totals(list),
                period: _period,
                onPeriod: (p) => setState(() => _period = p),
              ),
              AppSpacing.gap28,
              SectionHeader(title: l.financeQuickActions),
              EvenRow(
                children: [
                  for (final type in [
                    TransactionType.income,
                    TransactionType.expense,
                    TransactionType.saving,
                  ])
                    QuickActionButton(
                      key: Key('finance-add-${type.name}'),
                      vertical: true,
                      icon: switch (type) {
                        TransactionType.income => Symbols.add,
                        TransactionType.expense => Symbols.remove,
                        TransactionType.saving => Symbols.savings,
                      },
                      color: switch (type) {
                        TransactionType.income => AppColors.success,
                        TransactionType.expense => AppColors.finance,
                        TransactionType.saving => AppColors.primaryStrong,
                      },
                      label: transactionTypeLabel(context, type),
                      onTap: () => showTransactionSheet(context, type: type),
                    ),
                ],
              ),
              if (list.isEmpty) ...[
                AppSpacing.gap28,
                EmptyState(
                  icon: Symbols.account_balance_wallet,
                  title: l.financeEmptyTitle,
                  message: l.financeEmptyBody,
                ),
              ] else ...[
                AppSpacing.gap28,
                _CashFlowCard(items: list, range: range),
                AppSpacing.gap28,
                _SpendingSection(items: list),
              ],
              AppSpacing.gap28,
              SectionHeader(title: l.financeSavingsGoal),
              const _SavingsGoal(),
              if (list.isNotEmpty) ...[
                AppSpacing.gap28,
                _RecentSection(items: list),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ComparisonBanner extends ConsumerWidget {
  const _ComparisonBanner({required this.current});

  final List<FinanceTransaction> current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final previous =
        ref
            .watch(
              transactionsInRangeProvider(PeriodRange.month(today).previous),
            )
            .value ??
        const [];
    // Compare month-to-date with the same days of last month.
    final sameDays = previous.where(
      (t) => t.occurredAt.toLocal().day <= today.day,
    );
    final change = FinanceStats.expenseChange(
      FinanceStats.totals(current),
      FinanceStats.totals(sameDays),
    );
    if (change == null || change.abs() < 0.01) return const SizedBox.shrink();
    final pct = Fmt.percent(change.abs());
    final lower = change < 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: InfoBanner(
        message: lower
            ? l.financeExpensesLower(pct)
            : l.financeExpensesHigher(pct),
        icon: lower ? Symbols.trending_down : Symbols.trending_up,
        color: lower ? AppColors.finance : AppColors.warning,
        background: lower ? AppColors.financeSoft : AppColors.warningSoft,
      ),
    );
  }
}

class _NetCard extends ConsumerWidget {
  const _NetCard({
    required this.totals,
    required this.period,
    required this.onPeriod,
  });

  final FinanceTotals totals;
  final _FinancePeriod period;
  final ValueChanged<_FinancePeriod> onPeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final rate = totals.savingsRate;
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OverlineLabel(l.financeNet, color: AppColors.primaryStrong),
          AppSpacing.gap12,
          SegmentedPills<_FinancePeriod>(
            values: _FinancePeriod.values,
            selected: period,
            compact: true,
            labelOf: (p) => switch (p) {
              _FinancePeriod.thisMonth => l.commonThisMonth,
              _FinancePeriod.lastMonth => l.financeLastMonth,
              _FinancePeriod.year => l.financeThisYear,
            },
            onChanged: onPeriod,
          ),
          AppSpacing.gap16,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: Fmt.money(totals.netMinor, currency, withCode: false),
                  style: AppTypography.display.copyWith(
                    color: totals.netMinor < 0 ? AppColors.danger : null,
                  ),
                ),
                TextSpan(
                  text: ' ${Fmt.currency(currency)}',
                  style: AppTypography.sectionTitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(l.financeNetCaption, style: AppTypography.caption),
          AppSpacing.gap16,
          EvenRow(
            children: [
              StatTile(
                label: l.financeIncome,
                value: Fmt.money(
                  totals.incomeMinor,
                  currency,
                  compact: true,
                  signed: true,
                  withCode: false,
                ),
                valueColor: AppColors.success,
                caption: Fmt.currency(currency),
                color: AppColors.surfaceMuted,
              ),
              StatTile(
                label: l.financeExpenses,
                value: Fmt.money(
                  totals.expenseMinor,
                  currency,
                  compact: true,
                  withCode: false,
                ),
                caption: Fmt.currency(currency),
                color: AppColors.surfaceMuted,
              ),
              StatTile(
                label: l.financeSavings,
                value: Fmt.money(
                  totals.savingMinor,
                  currency,
                  compact: true,
                  withCode: false,
                ),
                valueColor: AppColors.primaryStrong,
                caption: Fmt.currency(currency),
                color: AppColors.surfaceMuted,
              ),
            ],
          ),
          if (rate != null) ...[
            AppSpacing.gap12,
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryStrong,
                    shape: BoxShape.circle,
                  ),
                ),
                AppSpacing.gap8,
                Text(
                  l.financeSavingsRate(Fmt.percent(rate)),
                  style: AppTypography.caption,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _CashFlowCard extends StatelessWidget {
  const _CashFlowCard({required this.items, required this.range});

  final List<FinanceTransaction> items;
  final PeriodRange range;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final months = [
      for (var m = 1; m <= 12; m++) Fmt.monthNarrow(DateTime(2024, m)),
    ];
    final buckets = FinanceStats.cashFlow(items, range, monthLabels: months);
    final maxY = buckets
        .expand((b) => [b.inflowMinor, b.outflowMinor])
        .fold<int>(0, (m, v) => v > m ? v : m);
    final yearly = range.kind == PeriodKind.year;
    Widget legend(Color color, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.captionSmall),
      ],
    );
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l.financeCashFlow, style: AppTypography.cardTitle),
              ),
              legend(AppColors.primaryStrong, l.financeInflow),
              AppSpacing.gap8,
              legend(AppColors.borderStrong, l.financeOutflow),
            ],
          ),
          AppSpacing.gap20,
          SizedBox(
            height: 160,
            child: Semantics(
              label: l.financeCashFlow,
              child: BarChart(
                BarChartData(
                  maxY: maxY == 0 ? 1 : maxY * 1.1,
                  alignment: BarChartAlignment.spaceAround,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          meta: meta,
                          child: Text(
                            buckets[value.toInt()].label,
                            style: AppTypography.captionSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                  barGroups: [
                    for (final (i, b) in buckets.indexed)
                      BarChartGroupData(
                        x: i,
                        barsSpace: yearly ? 2 : 6,
                        barRods: [
                          BarChartRodData(
                            toY: b.inflowMinor.toDouble(),
                            color: AppColors.primaryStrong,
                            width: yearly ? 7 : 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY: b.outflowMinor.toDouble(),
                            color: AppColors.borderStrong,
                            width: yearly ? 7 : 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpendingSection extends ConsumerWidget {
  const _SpendingSection({required this.items});

  final List<FinanceTransaction> items;

  static const _barColors = [
    AppColors.primaryStrong,
    AppColors.work,
    AppColors.finance,
    AppColors.learning,
    AppColors.textMuted,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final categories = FinanceStats.spendingByCategory(items);
    final total = categories.fold<int>(0, (s, c) => s + c.amountMinor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.financeSpending,
          trailingText: total > 0
              ? l.financeTotal(Fmt.money(total, currency))
              : null,
        ),
        AppCard(
          child: categories.isEmpty
              ? Text(l.financeNoSpending, style: AppTypography.caption)
              : Column(
                  children: [
                    for (final (i, c) in categories.take(5).indexed) ...[
                      if (i > 0) AppSpacing.gap16,
                      Row(
                        children: [
                          IconTile(
                            icon: categoryIcon(c.category),
                            color: _barColors[i],
                            background: AppColors.surfaceMuted,
                            size: 36,
                            iconSize: 18,
                          ),
                          AppSpacing.gap12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  financeCategoryLabel(l, c.category),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bodyMedium,
                                ),
                                Text(
                                  l.financeTxCount(c.count),
                                  style: AppTypography.captionSmall,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Fmt.money(c.amountMinor, currency),
                                style: AppTypography.label.tabular,
                              ),
                              Text(
                                Fmt.percent(c.amountMinor / total),
                                style: AppTypography.captionSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppSpacing.gap8,
                      AppProgressBar(
                        value: c.amountMinor / total,
                        color: _barColors[i],
                        height: 4,
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _SavingsGoal extends ConsumerWidget {
  const _SavingsGoal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final views =
        (ref.watch(goalViewsProvider).value ?? const <GoalView>[])
            .where(
              (v) =>
                  v.goal.area == LifeArea.finance &&
                  v.goal.status == GoalStatus.active &&
                  v.goal.type == GoalType.target,
            )
            .toList()
          ..sort(
            (a, b) =>
                (b.goal.isPrimary ? 1 : 0).compareTo(a.goal.isPrimary ? 1 : 0),
          );
    if (views.isEmpty) return const AreaGoalsSection(area: LifeArea.finance);
    final v = views.first;
    final g = v.goal;
    return AppCard(
      onTap: () => context.push(AppRoutes.goal(g.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.shield,
                size: 20,
                color: AppColors.primaryStrong,
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(bidiSafe(g.title), style: AppTypography.cardTitle),
              ),
              Pill(
                label: '${v.progress.percent}%',
                foreground: AppColors.primaryStrong,
                background: AppColors.brandSoft,
                dense: true,
              ),
            ],
          ),
          AppSpacing.gap12,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: Fmt.number(v.progress.current),
                  style: AppTypography.headline.tabular,
                ),
                TextSpan(
                  text: ' / ${goalValue(l, g, v.progress.target)}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          AppSpacing.gap8,
          AppProgressBar(value: v.progress.ratio),
          AppSpacing.gap12,
          Row(
            children: [
              Expanded(
                child: Text(
                  l.financeRemaining(goalValue(l, g, v.progress.remaining)),
                  style: AppTypography.caption,
                ),
              ),
              SecondaryButton(
                label: l.financeAddSaving,
                leadingIcon: Symbols.add,
                height: 36,
                expand: false,
                onPressed: () =>
                    showTransactionSheet(context, type: TransactionType.saving),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentSection extends ConsumerStatefulWidget {
  const _RecentSection({required this.items});

  final List<FinanceTransaction> items;

  @override
  ConsumerState<_RecentSection> createState() => _RecentSectionState();
}

class _RecentSectionState extends ConsumerState<_RecentSection> {
  static const _collapsed = 6;
  TransactionType? _filter;
  bool _all = false;

  Future<void> _delete(FinanceTransaction t) async {
    final l = context.l10n;
    final ok = await showConfirmDialog(
      context,
      title: l.commonDeleteEntry,
      message: l.commonDeleteEntryBody,
      confirmLabel: l.commonDelete,
      destructive: true,
    );
    if (ok) await ref.read(financeRepositoryProvider).delete(t);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final today = ref.watch(currentDayProvider);
    final filtered =
        widget.items.where((t) => _filter == null || t.type == _filter).toList()
          ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    final visible = _all ? filtered : filtered.take(_collapsed).toList();
    final filters = <(TransactionType?, String)>[
      (null, l.financeAll),
      (TransactionType.income, l.financeIncome),
      (TransactionType.expense, l.financeExpenses),
      (TransactionType.saving, l.financeSavings),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l.financeRecent),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final (i, (type, label)) in filters.indexed) ...[
                if (i > 0) AppSpacing.gap8,
                FilterPill(
                  label: label,
                  selected: _filter == type,
                  onTap: () => setState(() => _filter = type),
                ),
              ],
            ],
          ),
        ),
        AppSpacing.gap12,
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: visible.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(l.financeNoMatches, style: AppTypography.caption),
                )
              : Column(
                  children: [
                    for (final t in visible)
                      TransactionRow(
                        icon: categoryIcon(t.category),
                        title: t.note ?? financeCategoryLabel(l, t.category),
                        meta: t.note == null
                            ? whenLabel(
                                context,
                                t.occurredAt,
                                use24h: use24h,
                                now: today,
                              )
                            : '${financeCategoryLabel(l, t.category)} · ${whenLabel(context, t.occurredAt, use24h: use24h, now: today)}',
                        amount: Fmt.money(
                          t.type == TransactionType.income
                              ? t.amountMinor
                              : -t.amountMinor,
                          currency,
                          signed: true,
                        ),
                        amountColor: transactionColor(t.type),
                        tag: t.type == TransactionType.saving
                            ? StatusChip(
                                label: l.moneySaving,
                                tone: StatusTone.brand,
                              )
                            : StatusChip(
                                label: t.tag == MoneyTag.business
                                    ? l.moneyBusiness
                                    : l.moneyPersonal,
                                tone: StatusTone.neutral,
                              ),
                        onTap: () => _delete(t),
                      ),
                  ],
                ),
        ),
        if (filtered.length > _collapsed) ...[
          AppSpacing.gap8,
          Center(
            child: AppTextButton(
              label: _all ? l.commonShowLess : l.financeViewAll,
              icon: _all ? Symbols.expand_less : Symbols.chevron_right,
              onPressed: () => setState(() => _all = !_all),
            ),
          ),
        ],
      ],
    );
  }
}
