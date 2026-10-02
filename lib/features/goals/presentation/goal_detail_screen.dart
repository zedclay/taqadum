import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
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
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../settings/data/preferences.dart';
import '../data/goals_repository.dart';
import 'goal_editor_sheets.dart';
import 'goal_labels.dart';
import 'widgets/goal_mini_card.dart';
import 'widgets/goal_widgets.dart';
import '../../../core/utilities/bidi.dart';

enum _Menu { edit, pause, resume, complete, reopen, primary, archive, delete }

class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({super.key, required this.goalId});

  final String goalId;

  Future<void> _onMenu(
    BuildContext context,
    WidgetRef ref,
    Goal g,
    _Menu m,
  ) async {
    final l = context.l10n;
    final repo = ref.read(goalsRepositoryProvider);
    switch (m) {
      case _Menu.edit:
        await context.push(AppRoutes.editGoal(g.id));
      case _Menu.pause:
        await repo.setStatus(g, GoalStatus.paused);
      case _Menu.resume || _Menu.reopen:
        await repo.setStatus(g, GoalStatus.active);
      case _Menu.complete:
        await repo.setStatus(g, GoalStatus.completed);
      case _Menu.primary:
        await repo.setPrimary(g.id);
      case _Menu.archive:
        final ok = await showConfirmDialog(
          context,
          title: l.goalArchiveTitle,
          message: l.goalArchiveBody,
          confirmLabel: l.goalMenuArchive,
        );
        if (ok) {
          await repo.setStatus(g, GoalStatus.archived);
          if (context.mounted) context.pop();
        }
      case _Menu.delete:
        final ok = await showConfirmDialog(
          context,
          title: l.goalDeleteTitle,
          message: l.goalDeleteBody,
          confirmLabel: l.goalMenuDelete,
          destructive: true,
        );
        if (ok) {
          if (context.mounted) context.pop();
          await repo.delete(g.id);
        }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final view = ref.watch(goalViewProvider(goalId));
    final goal = view.value?.goal;
    return Scaffold(
      appBar: AppTopBar(
        title: l.goalDetailTitle,
        centerTitle: true,
        actions: [
          if (goal != null)
            PopupMenuButton<_Menu>(
              key: const Key('goal-menu'),
              tooltip: l.commonMore,
              icon: const Icon(Symbols.more_horiz),
              onSelected: (m) => _onMenu(context, ref, goal, m),
              itemBuilder: (_) => [
                PopupMenuItem(value: _Menu.edit, child: Text(l.goalMenuEdit)),
                if (goal.status == GoalStatus.active) ...[
                  if (!goal.isPrimary)
                    PopupMenuItem(
                      value: _Menu.primary,
                      child: Text(l.goalMenuPrimary),
                    ),
                  PopupMenuItem(
                    value: _Menu.pause,
                    child: Text(l.goalMenuPause),
                  ),
                  PopupMenuItem(
                    value: _Menu.complete,
                    child: Text(l.goalMenuComplete),
                  ),
                ],
                if (goal.status == GoalStatus.paused)
                  PopupMenuItem(
                    value: _Menu.resume,
                    child: Text(l.goalMenuResume),
                  ),
                if (goal.status == GoalStatus.completed ||
                    goal.status == GoalStatus.archived)
                  PopupMenuItem(
                    value: _Menu.reopen,
                    child: Text(l.goalMenuReopen),
                  ),
                if (goal.status != GoalStatus.archived)
                  PopupMenuItem(
                    value: _Menu.archive,
                    child: Text(l.goalMenuArchive),
                  ),
                PopupMenuItem(
                  value: _Menu.delete,
                  child: Text(
                    l.goalMenuDelete,
                    style: const TextStyle(color: AppColors.danger),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: AsyncView<GoalView?>(
        value: view,
        builder: (v) => v == null
            ? Padding(
                padding: const EdgeInsets.all(AppSpacing.screen),
                child: EmptyState(
                  icon: Symbols.flag,
                  title: l.goalNotFound,
                  message: '',
                  actionLabel: l.goalsTitle,
                  onAction: () => context.go(AppRoutes.goals),
                ),
              )
            : _Body(view: v),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.view});

  final GoalView view;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final g = view.goal;
    final actions =
        (ref.watch(goalActionsProvider).value ?? const <GoalAction>[])
            .where((a) => a.goalId == g.id)
            .toList()
          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final milestones =
        (ref.watch(goalMilestonesProvider).value ?? const <GoalMilestone>[])
            .where((m) => m.goalId == g.id)
            .toList()
          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final events =
        (ref.watch(goalEventsProvider).value ?? const <GoalProgressEvent>[])
            .where((e) => e.goalId == g.id)
            .toList()
          ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.xs,
        AppSpacing.screen,
        AppSpacing.huge,
      ),
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            CategoryChip(area: g.area, icon: true),
            if (g.isPrimary)
              Pill(
                label: l.goalPrimaryFocus,
                dot: true,
                foreground: AppColors.finance,
                background: AppColors.financeSoft,
              ),
          ],
        ),
        AppSpacing.gap12,
        Text(bidiSafe(g.title), style: AppTypography.pageTitle),
        if (g.description != null) ...[
          const SizedBox(height: 4),
          Text(g.description!, style: AppTypography.body),
        ],
        AppSpacing.gap20,
        if (g.status == GoalStatus.completed) ...[
          InfoBanner(message: l.goalCompletedBanner, icon: Symbols.verified),
          AppSpacing.gap16,
        ] else if (g.status == GoalStatus.paused) ...[
          InfoBanner(
            message: l.goalPausedBanner,
            icon: Symbols.pause_circle,
            color: AppColors.textSecondary,
            background: AppColors.surfaceMuted,
          ),
          AppSpacing.gap16,
        ],
        _Trajectory(view: view, hasMilestones: milestones.isNotEmpty),
        AppSpacing.gap28,
        _ActionsSection(goal: g, actions: actions),
        if (milestones.isNotEmpty) ...[
          AppSpacing.gap28,
          _Milestones(goal: g, milestones: milestones),
        ],
        AppSpacing.gap28,
        _History(goal: g, events: events),
        if (g.why != null) ...[
          AppSpacing.gap28,
          SectionHeader(title: l.goalWhyTitle),
          AppCard(
            color: AppColors.surfaceMuted,
            borderColor: null,
            shadow: false,
            child: Text(bidiSafe(g.why!), style: AppTypography.bodyLarge),
          ),
        ],
      ],
    );
  }
}

class _Trajectory extends ConsumerWidget {
  const _Trajectory({required this.view, required this.hasMilestones});

  final GoalView view;
  final bool hasMilestones;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final g = view.goal;
    final p = view.progress;
    final canLog =
        g.status == GoalStatus.active &&
        !(g.type == GoalType.milestone && hasMilestones);
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: OverlineLabel(l.goalTrajectory)),
              GoalHealthChip(health: p.health),
            ],
          ),
          AppSpacing.gap12,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: Fmt.number(p.current),
                  style: AppTypography.display.tabular,
                ),
                TextSpan(
                  text: '  ${l.goalOfTarget(goalValue(l, g, p.target))}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          if (g.type == GoalType.routine)
            Text(goalProgressLine(context, view), style: AppTypography.caption),
          AppSpacing.gap12,
          AppProgressBar(value: p.ratio, height: 8),
          AppSpacing.gap8,
          Row(
            children: [
              Expanded(
                child: Text(
                  l.goalsPctCompleted(p.percent),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryStrong,
                  ),
                ),
              ),
              if (g.targetDate != null)
                Text(
                  '${l.goalsTargetOn(Fmt.monthDayYear(g.targetDate!.toLocal()))} · '
                  '${timeLeftLabel(context, g.targetDate!.toLocal(), now: ref.watch(currentDayProvider))}',
                  style: AppTypography.caption,
                ),
            ],
          ),
          if (canLog) ...[
            AppSpacing.gap16,
            PrimaryButton(
              key: const Key('goal-log-progress'),
              label: l.goalsLogProgress,
              leadingIcon: Symbols.add_circle,
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                if (await showLogProgressSheet(context, g)) {
                  messenger.showSnackBar(SnackBar(content: Text(l.goalLogged)));
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionsSection extends ConsumerWidget {
  const _ActionsSection({required this.goal, required this.actions});

  final Goal goal;
  final List<GoalAction> actions;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final draft = await showActionSheet(context);
    if (draft == null) return;
    await ref.read(goalsRepositoryProvider).addAction(goal.id, draft);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final next = nextActionOf(actions, now, weekStart: weekStart);
    final repo = ref.read(goalsRepositoryProvider);
    final editable = goal.status == GoalStatus.active;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l.goalNextAction),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: next == null
              ? Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    actions.isEmpty ? l.goalNoActions : l.goalAllActionsDone,
                    style: AppTypography.caption,
                  ),
                )
              : TaskRow(
                  title: next.title,
                  subtitle: [
                    if (next.detail != null) bidiSafe(next.detail!),
                    frequencyLabel(context, next.frequency),
                  ].whereType<String>().join(' · '),
                  done: false,
                  onToggle: editable
                      ? () => repo.toggleAction(next, goal, true)
                      : null,
                ),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.goalActions,
          badge: actions.isEmpty
              ? null
              : Pill(
                  label: l.goalActiveCount(actions.length),
                  foreground: AppColors.textBody,
                  background: AppColors.surfaceMuted,
                  dense: true,
                ),
          trailingText: editable ? l.goalAddAction : null,
          onTrailingTap: editable ? () => _add(context, ref) : null,
        ),
        if (actions.isEmpty)
          AddRowButton(
            key: const Key('goal-detail-add-action'),
            label: l.goalAddAction,
            onTap: editable ? () => _add(context, ref) : null,
          )
        else
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              children: [
                for (final a in actions)
                  Builder(
                    builder: (context) {
                      final done = actionDone(a, now, weekStart: weekStart);
                      return TaskRow(
                        title: a.title,
                        subtitle: [
                          frequencyLabel(context, a.frequency),
                          done
                              ? l.goalDoneForPeriod
                              : (a.detail == null ? null : bidiSafe(a.detail!)),
                        ].whereType<String>().join(' · '),
                        done: done,
                        onToggle: editable
                            ? () => repo.toggleAction(a, goal, !done)
                            : null,
                      );
                    },
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Milestones extends ConsumerWidget {
  const _Milestones({required this.goal, required this.milestones});

  final Goal goal;
  final List<GoalMilestone> milestones;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final done = milestones.where((m) => m.completedAt != null).length;
    final current = milestones.where((m) => m.completedAt == null).firstOrNull;
    final repo = ref.read(goalsRepositoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.goalMilestonesTitle,
          trailingText: l.goalMilestonesDone(done, milestones.length),
        ),
        AppCard(
          child: Column(
            children: [
              for (final (i, m) in milestones.indexed)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 24,
                        child: Column(
                          children: [
                            CircleCheck(
                              checked: m.completedAt != null,
                              size: 20,
                              semanticLabel: m.title,
                              onTap: goal.status == GoalStatus.active
                                  ? () => repo.toggleMilestone(m, goal)
                                  : null,
                            ),
                            if (i < milestones.length - 1)
                              Expanded(
                                child: Container(
                                  width: 2,
                                  color: m.completedAt != null
                                      ? AppColors.primaryStrong
                                      : AppColors.border,
                                ),
                              ),
                          ],
                        ),
                      ),
                      AppSpacing.gap12,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      m.title,
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: m == current
                                            ? AppColors.primaryStrong
                                            : m.completedAt == null
                                            ? AppColors.textSecondary
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      m.completedAt != null
                                          ? l.goalMilestoneCompleted(
                                              Fmt.monthDay(
                                                m.completedAt!.toLocal(),
                                              ),
                                            )
                                          : m.targetDate != null
                                          ? l.goalsTargetOn(
                                              Fmt.monthDayYear(
                                                m.targetDate!.toLocal(),
                                              ),
                                            )
                                          : l.goalMilestoneUpcoming,
                                      style: AppTypography.captionSmall,
                                    ),
                                  ],
                                ),
                              ),
                              if (m == current)
                                Pill(
                                  label: l.goalMilestoneCurrent,
                                  foreground: AppColors.primaryStrong,
                                  background: AppColors.brandSoft,
                                  dense: true,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _History extends ConsumerWidget {
  const _History({required this.goal, required this.events});

  final Goal goal;
  final List<GoalProgressEvent> events;

  IconData _icon(ProgressSource s) => switch (s) {
    ProgressSource.manual => Symbols.trending_up,
    ProgressSource.quran => Symbols.menu_book,
    ProgressSource.finance => Symbols.account_balance_wallet,
    ProgressSource.work => Symbols.work,
    ProgressSource.learning => Symbols.school,
    ProgressSource.health => Symbols.favorite,
    ProgressSource.task => Symbols.task_alt,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final latest = events.reversed.take(5).toList();
    final showChart = goal.type == GoalType.target && events.length >= 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.goalHistory,
          trailingText: events.isEmpty
              ? null
              : daysAgoLabel(
                  context,
                  events.last.occurredAt,
                  now: ref.watch(currentDayProvider),
                ),
        ),
        if (events.isEmpty)
          AppCard(child: Text(l.goalNoHistory, style: AppTypography.caption))
        else ...[
          if (showChart) ...[
            _TrendChart(goal: goal, events: events),
            AppSpacing.gap12,
          ],
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              children: [
                for (final e in latest)
                  ActivityRow(
                    icon: _icon(e.source),
                    color: AppColors.primaryStrong,
                    background: AppColors.brandSoft,
                    title:
                        e.note ??
                        l.goalProgressAdded(goalValue(l, goal, e.delta)),
                    subtitle: e.note == null
                        ? null
                        : l.goalProgressAdded(goalValue(l, goal, e.delta)),
                    trailing: Fmt.monthDay(e.occurredAt.toLocal()),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.goal, required this.events});

  final Goal goal;
  final List<GoalProgressEvent> events;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final origin = goal.createdAt.toLocal();
    var value = goal.startValue;
    final points = <FlSpot>[FlSpot(0, value)];
    for (final e in events) {
      value += e.delta;
      final x = e.occurredAt.toLocal().difference(origin).inHours / 24;
      points.add(FlSpot(x < 0 ? 0 : x, value));
    }
    final maxX = points.last.x <= 0 ? 1.0 : points.last.x;
    final change = goal.startValue > 0
        ? (value - goal.startValue) / goal.startValue
        : null;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: OverlineLabel(l.goalTrend)),
              if (change != null)
                Text(
                  l.goalTrendChange(Fmt.signedPercent(change)),
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryStrong,
                  ),
                ),
            ],
          ),
          AppSpacing.gap16,
          SizedBox(
            height: 140,
            child: Semantics(
              label: l.goalTrend,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: maxX,
                  minY: 0,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineTouchData: const LineTouchData(enabled: false),
                  titlesData: const FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: points,
                      isCurved: false,
                      color: AppColors.primaryStrong,
                      barWidth: 2.5,
                      dotData: FlDotData(
                        getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
                          radius: 3,
                          color: AppColors.primaryStrong,
                          strokeWidth: 0,
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
          AppSpacing.gap8,
          Row(
            children: [
              Text(Fmt.monthDay(origin), style: AppTypography.captionSmall),
              const Spacer(),
              Text(
                Fmt.monthDay(events.last.occurredAt.toLocal()),
                style: AppTypography.captionSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
