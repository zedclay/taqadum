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
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../goals/data/goals_repository.dart';
import '../../progress/data/progress_providers.dart';
import '../../profile/data/profile_repository.dart';
import '../../settings/data/preferences.dart';
import '../../settings/data/settings_store.dart';
import '../data/daily_repository.dart';
import '../data/tasks_repository.dart';
import '../domain/today_summary.dart';
import 'widgets/task_labels.dart';
import 'widgets/task_sheets.dart';
import '../../../core/utilities/bidi.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  static const visibleActions = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(currentDayProvider);
    final todayKey = dayKeyOf(today);
    final tasks = ref.watch(tasksForDayProvider(todayKey));
    final yesterday = ref.watch(
      tasksForDayProvider(dayKeyOf(addDays(today, -1))),
    );

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async =>
              ref.read(currentDayProvider.notifier).refresh(),
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.huge,
            ),
            children: [
              _Header(today: today),
              AppSpacing.gap20,
              AsyncView<List<Task>>(
                value: tasks,
                builder: (list) {
                  final summary = TodaySummary.of(
                    list,
                    yesterday: yesterday.value ?? const [],
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _MomentumCard(summary: summary),
                      _RitualCard(todayKey: todayKey),
                      AppSpacing.gap28,
                      _FocusSection(summary: summary, tasks: list),
                      AppSpacing.gap28,
                      _ActionsSection(summary: summary, tasks: list),
                    ],
                  );
                },
              ),
              AppSpacing.gap28,
              const _AreasSection(),
              const _InsightSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.today});

  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final name = ref.watch(profileProvider).value?.name ?? '';
    final first = name.trim().split(RegExp(r'\s+')).first;
    final hour = ref.watch(clockProvider)().hour;
    final greeting = hour < 12
        ? l.todayGreetingMorning(first)
        : hour < 18
        ? l.todayGreetingAfternoon(first)
        : l.todayGreetingEvening(first);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.headline.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 2),
              Text(Fmt.weekdayDayMonth(today), style: AppTypography.body),
            ],
          ),
        ),
        CircleIconButton(
          icon: Symbols.notifications,
          tooltip: l.todayNotifications,
          bordered: true,
          onPressed: () => context.push(AppRoutes.notifications),
        ),
        AppSpacing.gap8,
        Semantics(
          button: true,
          label: l.todayProfile,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context.go(AppRoutes.profile),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.brandSoft,
              child: Text(
                initialsOf(name),
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MomentumCard extends StatelessWidget {
  const _MomentumCard({required this.summary});

  final TodaySummary summary;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    if (summary.isEmpty) {
      return AppCard.hero(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.todayEmptyTitle, style: AppTypography.cardTitle),
            AppSpacing.gap4,
            Text(l.todayEmptyBody, style: AppTypography.body),
            AppSpacing.gap16,
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: l.todayCheckInCta,
                    height: 48,
                    leadingIcon: Symbols.wb_twilight,
                    onPressed: () => context.push(AppRoutes.morningCheckIn),
                  ),
                ),
                AppSpacing.gap12,
                Expanded(
                  child: SecondaryButton(
                    label: l.taskAdd,
                    height: 48,
                    leadingIcon: Symbols.add,
                    onPressed: () => showTaskSheet(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    final delta = summary.deltaVsYesterday;
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.todayMomentum,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (delta != null && delta.abs() >= 0.01)
                StatusChip(
                  label: l.todayVsYesterday(Fmt.signedPercent(delta)),
                  tone: delta >= 0 ? StatusTone.info : StatusTone.neutral,
                ),
            ],
          ),
          AppSpacing.gap12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('${summary.percent}%', style: AppTypography.display),
              AppSpacing.gap8,
              Text(
                l.todayComplete,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(value: summary.ratio),
          AppSpacing.gap12,
          Row(
            children: [
              Expanded(
                child: Text(
                  l.todayActionsCompleted(summary.done, summary.total),
                  style: AppTypography.caption,
                ),
              ),
              Text(
                l.todayActionsLeft(summary.left),
                style: AppTypography.caption.copyWith(
                  color: summary.left == 0
                      ? AppColors.success
                      : AppColors.primaryStrong,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Suggests the morning check-in or night review when relevant.
class _RitualCard extends ConsumerWidget {
  const _RitualCard({required this.todayKey});

  final String todayKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final hour = ref.watch(clockProvider)().hour;
    final checkIn = ref.watch(checkInProvider(todayKey));
    final night = ref.watch(nightReviewProvider(todayKey));
    if (!checkIn.hasValue || !night.hasValue) return const SizedBox.shrink();
    final Widget card;
    if (checkIn.value == null && hour < 15) {
      card = _ritual(
        context,
        key: const Key('today-checkin-card'),
        icon: Symbols.wb_twilight,
        title: l.todayCheckInTitle,
        body: l.todayCheckInBody,
        cta: l.todayCheckInCta,
        onTap: () => context.push(AppRoutes.morningCheckIn),
      );
    } else if (night.value == null && hour >= 18) {
      card = _ritual(
        context,
        key: const Key('today-night-card'),
        icon: Symbols.bedtime,
        title: l.todayNightTitle,
        body: l.todayNightBody,
        cta: l.todayNightCta,
        onTap: () => context.push(AppRoutes.nightReview),
      );
    } else {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: card,
    );
  }

  Widget _ritual(
    BuildContext context, {
    required Key key,
    required IconData icon,
    required String title,
    required String body,
    required String cta,
    required VoidCallback onTap,
  }) => AppCard(
    key: key,
    color: AppColors.brandSoft,
    borderColor: AppColors.brandSoft,
    shadow: false,
    onTap: onTap,
    child: Row(
      children: [
        IconTile(
          icon: icon,
          color: AppColors.primaryStrong,
          background: AppColors.surface,
          fill: true,
        ),
        AppSpacing.gap12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.cardTitle.copyWith(fontSize: 15),
              ),
              Text(
                body,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textBody,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gap8,
        Text(
          cta,
          style: AppTypography.label.copyWith(color: AppColors.primaryStrong),
        ),
        const Icon(
          Symbols.chevron_right,
          color: AppColors.primaryStrong,
          size: 20,
        ),
      ],
    ),
  );
}

class _FocusSection extends ConsumerWidget {
  const _FocusSection({required this.summary, required this.tasks});

  final TodaySummary summary;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final priorities = summary.priorities;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.todayFocus,
          badge: priorities.isEmpty
              ? null
              : Pill(label: l.todayPriorities(priorities.length), dense: true),
        ),
        if (priorities.isEmpty)
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.todayNoPriorities, style: AppTypography.body),
                AppSpacing.gap12,
                AppTextButton(
                  label: l.todayChoosePriorities,
                  icon: Symbols.flag,
                  color: AppColors.primaryStrong,
                  onPressed: () => context.push(AppRoutes.morningCheckIn),
                ),
              ],
            ),
          )
        else
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              children: [
                for (final task in priorities)
                  _PriorityRow(
                    task: task,
                    onTap: () =>
                        showTaskOptions(context, ref, task, dayTasks: tasks),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PriorityRow extends StatelessWidget {
  const _PriorityRow({required this.task, required this.onTap});

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final done = task.completedAt != null;
    final rank = task.priorityRank!.toString().padLeft(2, '0');
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: task.area.soft,
                borderRadius: AppRadius.smAll,
              ),
              child: Text(
                rank,
                style: AppTypography.captionSmall
                    .copyWith(
                      color: task.area.color,
                      fontWeight: FontWeight.w700,
                    )
                    .tabular,
              ),
            ),
            AppSpacing.gap12,
            Expanded(
              child: Text(
                bidiSafe(task.title),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: done ? AppColors.textMuted : AppColors.textPrimary,
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            if (done)
              const Icon(
                Symbols.check_circle,
                color: AppColors.success,
                size: 18,
                fill: 1,
              )
            else
              CategoryChip(area: task.area, dot: false),
            const SizedBox(width: 4),
            const Icon(
              Symbols.chevron_right,
              color: AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionsSection extends ConsumerWidget {
  const _ActionsSection({required this.summary, required this.tasks});

  final TodaySummary summary;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final ordered = [...tasks]
      ..sort((a, b) {
        final ta = a.scheduledMinute ?? 24 * 60;
        final tb = b.scheduledMinute ?? 24 * 60;
        return ta != tb ? ta.compareTo(tb) : a.sortOrder.compareTo(b.sortOrder);
      });
    final visible = ordered.take(TodayScreen.visibleActions).toList();
    final hidden = ordered.length - visible.length;
    final repo = ref.read(tasksRepositoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.todayActions,
          trailingText: tasks.isEmpty
              ? null
              : l.todayCompletedOf(summary.done, summary.total),
        ),
        for (final task in visible)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: TaskRow(
              key: ValueKey('today-task-${task.id}'),
              title: task.title,
              done: task.completedAt != null,
              onToggle: () => repo.setDone(task, task.completedAt == null),
              onTap: () => showTaskOptions(context, ref, task, dayTasks: tasks),
              trailing: _badge(task, use24h),
            ),
          ),
        if (hidden > 0)
          AppTextButton(
            label: l.todayMoreActions(hidden),
            color: AppColors.textSecondary,
            onPressed: () => context.push(AppRoutes.plan),
          ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AppTextButton(
              key: const Key('today-add-action'),
              label: l.todayAddAction,
              icon: Symbols.add_circle,
              color: AppColors.primaryStrong,
              onPressed: () => showTaskSheet(context),
            ),
            if (tasks.isNotEmpty) ...[
              Container(width: 1, height: 16, color: AppColors.border),
              AppTextButton(
                key: const Key('today-view-plan'),
                label: l.todayViewPlan,
                icon: Symbols.view_agenda,
                onPressed: () => context.push(AppRoutes.plan),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget? _badge(Task task, bool use24h) {
    final label = taskBadge(task) ?? taskTimeLabel(task, use24h: use24h);
    if (label == null) return null;
    return Pill(label: label, dense: true);
  }
}

class _AreasSection extends ConsumerWidget {
  const _AreasSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final views = ref.watch(goalViewsProvider);
    final focus = ref.watch(focusAreasProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l.todayYourProgress, subtitle: l.todayKeyAreas),
        AsyncView<List<GoalView>>(
          value: views,
          builder: (list) {
            final active = list.where(
              (v) => v.goal.status == GoalStatus.active,
            );
            final byArea = <LifeArea, List<double>>{};
            for (final v in active) {
              (byArea[v.goal.area] ??= []).add(v.progress.ratio);
            }
            final areas = [
              ...focus.where(byArea.containsKey),
              ...byArea.keys.where((a) => !focus.contains(a)),
            ];
            if (areas.isEmpty) {
              return EmptyState(
                icon: Symbols.adjust,
                title: l.todayCreateGoal,
                message: l.todayNoGoals,
                actionLabel: l.todayCreateGoal,
                onAction: () => context.push(AppRoutes.newGoal),
              );
            }
            return AppCard.hero(
              child: Column(
                children: [
                  for (final (i, area) in areas.indexed) ...[
                    if (i > 0) AppSpacing.gap16,
                    _AreaBar(
                      area: area,
                      ratio:
                          byArea[area]!.reduce((a, b) => a + b) /
                          byArea[area]!.length,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AreaBar extends StatelessWidget {
  const _AreaBar({required this.area, required this.ratio});

  final LifeArea area;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final route = area.route;
    return InkWell(
      onTap: route == null ? null : () => context.push(route),
      borderRadius: AppRadius.smAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    area.longLabel(context),
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  Fmt.percent(ratio),
                  style: AppTypography.bodyMedium
                      .copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      )
                      .tabular,
                ),
              ],
            ),
            AppSpacing.gap8,
            AppProgressBar(value: ratio, color: area.color),
          ],
        ),
      ),
    );
  }
}

class _InsightSection extends ConsumerWidget {
  const _InsightSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final summary = ref
        .watch(
          periodSummaryProvider(PeriodRange.week(today, weekStart: weekStart)),
        )
        .value;
    if (summary == null || summary.activeDays < 3) {
      return const SizedBox.shrink();
    }
    final strongest = summary.strongest;
    final String message;
    if (strongest != null && strongest.activeDays >= 3) {
      message = l.todayInsightArea(
        strongest.area.longLabel(context),
        strongest.activeDays,
        summary.elapsedDays,
      );
    } else {
      final strong = summary.scores.values.where((s) => s.score >= 0.75).length;
      if (strong == 0) return const SizedBox.shrink();
      message = l.todayInsightStrongDays(strong);
    }
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: InsightCard(title: l.todayInsightTitle, message: message),
    );
  }
}
