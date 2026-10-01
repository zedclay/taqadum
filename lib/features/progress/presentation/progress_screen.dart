import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/module_scaffold.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/segmented.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../settings/data/preferences.dart';
import '../../today/presentation/quick_add/quick_add_sheet.dart';
import '../data/progress_providers.dart';
import '../domain/progress_calculator.dart';
import 'widgets/month_grid.dart';

String weekdayName(int weekday) =>
    DateFormat('EEEE').format(DateTime(2024, 1, weekday));

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  PeriodKind _kind = PeriodKind.month;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final range = PeriodRange.of(_kind, today, weekStart: weekStart);
    final summary = ref.watch(periodSummaryProvider(range));
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.huge,
          ),
          children: [
            PageTitle(
              title: l.progressTitle,
              subtitle: l.progressSubtitle,
              trailing: CircleIconButton(
                key: const Key('progress-calendar'),
                icon: Symbols.calendar_month,
                tooltip: l.progressCalendar,
                onPressed: () => context.push(AppRoutes.calendar),
              ),
            ),
            AppSpacing.gap20,
            PeriodSelector(
              selected: _kind,
              onChanged: (k) => setState(() => _kind = k),
            ),
            AppSpacing.gap20,
            AsyncView<PeriodSummary>(
              value: summary,
              builder: (s) => s.hasData
                  ? _Content(summary: s, today: today, weekStart: weekStart)
                  : EmptyState(
                      icon: Symbols.monitoring,
                      title: l.progressEmptyTitle,
                      message: l.progressEmptyBody,
                      actionLabel: l.progressAddAction,
                      onAction: () => showQuickAddSheet(context),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.summary,
    required this.today,
    required this.weekStart,
  });

  final PeriodSummary summary;
  final DateTime today;
  final int weekStart;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = summary;
    final strongest = s.strongest;
    final weakest = s.weakest;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _OverallCard(summary: s),
        AppSpacing.gap16,
        _TrendCard(summary: s),
        AppSpacing.gap28,
        SectionHeader(
          title: l.progressLifeAreas,
          trailingText: l.progressTracked(s.areas.length),
        ),
        AppCard(
          child: Column(
            children: [
              for (final (i, a) in s.areas.indexed) ...[
                if (i > 0) AppSpacing.gap16,
                _AreaRow(stat: a, needsFocus: a == weakest),
              ],
            ],
          ),
        ),
        if (strongest != null || weakest != null) ...[
          AppSpacing.gap16,
          EvenRow(
            gap: AppSpacing.md,
            children: [
              if (strongest != null)
                _HighlightCard(
                  icon: Symbols.stars,
                  color: AppColors.success,
                  label: l.progressStrongest,
                  area: strongest.area,
                  body: l.progressStrongestBody(
                    Fmt.percent(strongest.consistency),
                    strongest.activeDays,
                    s.elapsedDays,
                  ),
                ),
              if (weakest != null)
                _HighlightCard(
                  icon: Symbols.adjust,
                  color: AppColors.primaryStrong,
                  label: l.progressAttention,
                  area: weakest.area,
                  body: l.progressAttentionBody(
                    Fmt.percent(weakest.consistency),
                  ),
                ),
            ],
          ),
        ],
        if (s.range.kind != PeriodKind.year) ...[
          AppSpacing.gap28,
          _ConsistencyCard(summary: s, today: today, weekStart: weekStart),
        ],
        AppSpacing.gap28,
        const _GoalsSection(),
        AppSpacing.gap28,
        _ReviewCard(today: today),
      ],
    );
  }
}

class _OverallCard extends StatelessWidget {
  const _OverallCard({required this.summary});

  final PeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = summary;
    final (periodLabel, deltaLabel) = switch (s.range.kind) {
      PeriodKind.week ||
      PeriodKind.day => (l.progressThisWeek, l.progressVsLastWeek),
      PeriodKind.month => (l.progressThisMonth, l.progressVsLastMonth),
      PeriodKind.year => (l.progressThisYear, l.progressVsLastYear),
    };
    final delta = s.overallDelta;
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Pill(
                label: periodLabel,
                foreground: AppColors.textBody,
                background: AppColors.surfaceMuted,
                dense: true,
              ),
              const Spacer(),
              if (delta != null)
                Pill(
                  label: deltaLabel(Fmt.signedPercent(delta)),
                  icon: delta >= 0
                      ? Symbols.trending_up
                      : Symbols.trending_down,
                  foreground: delta >= 0
                      ? AppColors.success
                      : AppColors.textSecondary,
                  background: delta >= 0
                      ? AppColors.successSoft
                      : AppColors.surfaceMuted,
                  dense: true,
                ),
            ],
          ),
          AppSpacing.gap16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  l.progressOverall,
                  style: AppTypography.sectionTitle,
                ),
              ),
              Text(
                Fmt.percent(s.overall),
                style: AppTypography.display.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          AppSpacing.gap8,
          AppProgressBar(value: s.overall),
          AppSpacing.gap12,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: l.progressDaysBody(s.activeDays, s.elapsedDays),
                  style: AppTypography.label,
                ),
                TextSpan(
                  text: ' ${l.progressDaysTail}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.summary});

  final PeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = summary;
    final points = s.trend;
    final kind = s.range.kind;
    final subtitle = switch (kind) {
      PeriodKind.week || PeriodKind.day => l.progressDailyTrajectory,
      PeriodKind.month => l.progressWeeklyTrajectory,
      PeriodKind.year => l.progressMonthlyTrajectory,
    };
    String label(int i) {
      final p = points[i];
      return switch (kind) {
        PeriodKind.week || PeriodKind.day => Fmt.weekdayNarrow(s.range.days[i]),
        PeriodKind.month => p.label,
        PeriodKind.year => DateFormat('MMMMM').format(DateTime(2024, i + 1)),
      };
    }

    final spots = [
      for (final (i, p) in points.indexed)
        if (p.value != null) FlSpot(i.toDouble(), p.value! * 100),
    ];
    final currentIndex = points.indexWhere((p) => p.isCurrent);
    final current = currentIndex >= 0 ? points[currentIndex].value : null;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.progressOverTime, style: AppTypography.cardTitle),
                    Text(subtitle, style: AppTypography.caption),
                  ],
                ),
              ),
              if (current != null)
                Pill(
                  label: l.progressCurrent(Fmt.percent(current)),
                  dot: true,
                  foreground: Colors.white,
                  background: AppColors.textPrimary,
                  dense: true,
                ),
            ],
          ),
          AppSpacing.gap20,
          SizedBox(
            height: 150,
            child: Semantics(
              label: '${l.progressOverTime}, $subtitle',
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: (points.length - 1).toDouble(),
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (_) => const FlLine(
                      color: AppColors.border,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: const LineTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 24,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= points.length) {
                            return const SizedBox.shrink();
                          }
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              label(i),
                              style: AppTypography.captionSmall.copyWith(
                                color: points[i].isCurrent
                                    ? AppColors.primaryStrong
                                    : null,
                                fontWeight: points[i].isCurrent
                                    ? FontWeight.w700
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      preventCurveOverShooting: true,
                      color: AppColors.primaryStrong,
                      barWidth: 2.5,
                      dotData: FlDotData(
                        getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
                          radius: spot.x == currentIndex ? 5 : 3,
                          color: spot.x == currentIndex
                              ? Colors.white
                              : AppColors.primaryStrong,
                          strokeWidth: spot.x == currentIndex ? 2.5 : 0,
                          strokeColor: AppColors.primaryStrong,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primaryStrong.withValues(alpha: 0.08),
                      ),
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

class _AreaRow extends StatelessWidget {
  const _AreaRow({required this.stat, required this.needsFocus});

  final AreaStat stat;
  final bool needsFocus;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final area = stat.area;
    final delta = stat.delta;
    return InkWell(
      onTap: area.route == null ? null : () => context.push(area.route!),
      child: Column(
        children: [
          Row(
            children: [
              IconTile(
                icon: area.icon,
                color: area.color,
                background: area.soft,
                size: 32,
                iconSize: 16,
              ),
              AppSpacing.gap12,
              Text(area.label(context), style: AppTypography.bodyMedium),
              if (needsFocus) ...[
                AppSpacing.gap8,
                StatusChip(
                  label: l.progressNeedsFocus,
                  tone: StatusTone.danger,
                ),
              ],
              const Spacer(),
              if (delta != null)
                Text(
                  Fmt.signedPercent(delta),
                  style: AppTypography.captionSmall.copyWith(
                    color: delta >= 0 ? AppColors.success : AppColors.danger,
                  ),
                ),
              AppSpacing.gap12,
              SizedBox(
                width: 40,
                child: Text(
                  Fmt.percent(stat.consistency),
                  textAlign: TextAlign.end,
                  style: AppTypography.label.tabular,
                ),
              ),
            ],
          ),
          AppSpacing.gap8,
          AppProgressBar(value: stat.consistency, color: area.color, height: 5),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.area,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String label;
  final LifeArea area;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(
            icon: icon,
            color: color,
            background: color.withValues(alpha: 0.1),
            size: 32,
            iconSize: 18,
          ),
          AppSpacing.gap12,
          Text(label, style: AppTypography.captionSmall),
          Text(area.label(context), style: AppTypography.sectionTitle),
          AppSpacing.gap4,
          Text(body, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _ConsistencyCard extends StatelessWidget {
  const _ConsistencyCard({
    required this.summary,
    required this.today,
    required this.weekStart,
  });

  final PeriodSummary summary;
  final DateTime today;
  final int weekStart;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = summary;
    final monthly = s.range.kind == PeriodKind.month;
    final period = monthly
        ? Fmt.monthName(s.range.start)
        : l.progressThisWeek.toLowerCase();
    DayStrength strength(DateTime d) => ProgressCalculator.strengthOf(
      s.scores[dayKeyOf(d)],
      isFuture: d.isAfter(today),
    );
    final best = s.strongestWeekdays;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.progressConsistency, style: AppTypography.cardTitle),
                    Text(
                      l.progressMeaningfulDays(s.activeDays, period),
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              CircleIconButton(
                icon: Symbols.insights,
                tooltip: l.progressCalendar,
                background: AppColors.surfaceMuted,
                size: 40,
                iconSize: 18,
                onPressed: () => context.push(AppRoutes.calendar),
              ),
            ],
          ),
          AppSpacing.gap16,
          if (monthly)
            MonthGrid(
              month: s.range.start,
              weekStart: weekStart,
              today: today,
              strengthOf: strength,
              onTap: (d) => context.push(AppRoutes.activityOn(dayKeyOf(d))),
            )
          else
            Row(
              children: [
                for (final d in s.range.days)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        children: [
                          Text(
                            Fmt.weekdayNarrow(d),
                            style: AppTypography.captionSmall,
                          ),
                          const SizedBox(height: 6),
                          AspectRatio(
                            aspectRatio: 1,
                            child: Material(
                              color: strengthFill(strength(d)),
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () => context.push(
                                  AppRoutes.activityOn(dayKeyOf(d)),
                                ),
                                child: Center(
                                  child: Text(
                                    '${d.day}',
                                    style: AppTypography.caption.copyWith(
                                      color: strength(d) == DayStrength.strong
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          AppSpacing.gap16,
          const StrengthLegend(),
          if (best.length == 2) ...[
            AppSpacing.gap16,
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Symbols.verified,
                    size: 18,
                    color: AppColors.primaryStrong,
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: Text(
                      l.progressBestDays(
                        weekdayName(best[0]),
                        weekdayName(best[1]),
                      ),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GoalsSection extends ConsumerWidget {
  const _GoalsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final views =
        (ref.watch(goalViewsProvider).value ?? const <GoalView>[])
            .where((v) => v.goal.status == GoalStatus.active)
            .toList()
          ..sort(
            (a, b) =>
                (b.goal.isPrimary ? 1 : 0).compareTo(a.goal.isPrimary ? 1 : 0),
          );
    if (views.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.progressActiveGoals,
          trailingText: l.progressViewGoals,
          onTrailingTap: () => context.go(AppRoutes.goals),
        ),
        AppCard(
          child: Column(
            children: [
              for (final (i, v) in views.take(3).indexed) ...[
                if (i > 0) AppSpacing.gap16,
                InkWell(
                  onTap: () => context.push(AppRoutes.goal(v.goal.id)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              v.goal.title,
                              style: AppTypography.bodyMedium,
                            ),
                          ),
                          Text(
                            '${v.progress.percent}%',
                            style: AppTypography.label.copyWith(
                              color: v.goal.area.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          CategoryChip(area: v.goal.area),
                          AppSpacing.gap8,
                          Expanded(
                            child: Text(
                              goalProgressLine(context, v),
                              style: AppTypography.captionSmall,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.gap8,
                      AppProgressBar(
                        value: v.progress.ratio,
                        color: v.goal.area.color,
                        height: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.today});

  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          color: AppColors.brandSoft,
          borderColor: null,
          shadow: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const IconTile(
                    icon: Symbols.auto_awesome,
                    color: AppColors.primaryStrong,
                    background: AppColors.surface,
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.progressMonthlyReady,
                          style: AppTypography.sectionTitle,
                        ),
                        Text(
                          l.progressMonthlySummary(Fmt.monthName(today)),
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.gap12,
              Text(l.progressMonthlyBody, style: AppTypography.body),
              AppSpacing.gap16,
              PrimaryButton(
                key: const Key('progress-monthly-review'),
                label: l.progressReviewMonth,
                icon: Symbols.arrow_forward,
                onPressed: () => context.push(AppRoutes.monthlyReview),
              ),
            ],
          ),
        ),
        AppSpacing.gap8,
        Center(
          child: AppTextButton(
            key: const Key('progress-weekly-review'),
            label: l.progressWeeklyLink,
            icon: Symbols.arrow_forward,
            onPressed: () => context.push(AppRoutes.weeklyReview),
          ),
        ),
      ],
    );
  }
}
