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
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../settings/data/preferences.dart';
import '../data/goals_repository.dart';
import '../domain/goal_progress.dart';
import 'widgets/goal_mini_card.dart';
import 'widgets/goal_widgets.dart';
import '../../../core/utilities/bidi.dart';

enum _GoalFilter { all, active, completed }

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  _GoalFilter _filter = _GoalFilter.all;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final views = ref.watch(goalViewsProvider);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: AsyncView<List<GoalView>>(
          value: views,
          builder: (all) {
            final visible = all
                .where((v) => v.goal.status != GoalStatus.archived)
                .toList();
            final open = visible
                .where((v) => v.goal.status != GoalStatus.completed)
                .toList();
            final completed = visible
                .where((v) => v.goal.status == GoalStatus.completed)
                .toList();
            return ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.screen,
                AppSpacing.md,
                AppSpacing.screen,
                AppSpacing.huge,
              ),
              children: [
                _Header(open: open),
                AppSpacing.gap16,
                if (visible.isEmpty)
                  EmptyState(
                    icon: Symbols.flag,
                    title: l.goalsEmptyTitle,
                    message: l.goalsEmptyBody,
                    actionLabel: l.goalsNew,
                    onAction: () => context.push(AppRoutes.newGoal),
                  )
                else ...[
                  _Filters(
                    filter: _filter,
                    active: open.length,
                    completed: completed.length,
                    onChanged: (f) => setState(() => _filter = f),
                  ),
                  AppSpacing.gap20,
                  if (_filter != _GoalFilter.completed) ...[
                    ..._activeSections(context, open),
                  ],
                  if (_filter == _GoalFilter.completed)
                    _CompletedList(views: completed)
                  else if (_filter == _GoalFilter.all &&
                      completed.isNotEmpty) ...[
                    AppSpacing.gap20,
                    _CompletedArchive(views: completed),
                  ],
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _activeSections(BuildContext context, List<GoalView> open) {
    final l = context.l10n;
    if (open.isEmpty) {
      return [
        AppCard(child: Text(l.goalsNoneInFilter, style: AppTypography.caption)),
      ];
    }
    final primary = open
        .where((v) => v.goal.isPrimary && v.goal.status == GoalStatus.active)
        .firstOrNull;
    final rest = open.where((v) => v != primary).toList();
    final areas = {for (final v in open) v.goal.area}.length;
    return [
      if (primary != null) ...[
        SectionHeader(
          title: l.goalsPrimaryFocus,
          icon: Symbols.explore,
          iconColor: AppColors.primaryStrong,
          trailing: Pill(
            label: l.goalsKeystone.toUpperCase(),
            foreground: AppColors.primaryStrong,
            background: AppColors.brandSoft,
            dense: true,
          ),
        ),
        _PrimaryCard(view: primary),
        AppSpacing.gap16,
      ],
      const _MonthRecap(),
      AppSpacing.gap28,
      if (rest.isNotEmpty) ...[
        SectionHeader(title: l.goalsAll, trailingText: l.goalsAreas(areas)),
        for (final v in rest) ...[_GoalCard(view: v), AppSpacing.gap12],
      ],
    ];
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.open});

  final List<GoalView> open;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final active = open.where((v) => v.goal.status == GoalStatus.active);
    final onTrack = active
        .where(
          (v) =>
              v.progress.health == GoalHealth.onTrack ||
              v.progress.health == GoalHealth.completed,
        )
        .length;
    final attention = active
        .where((v) => v.progress.health == GoalHealth.needsAttention)
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.goalsTitle, style: AppTypography.pageTitle),
                  const SizedBox(height: 2),
                  Text(l.goalsSubtitle, style: AppTypography.body),
                ],
              ),
            ),
            SecondaryButton(
              key: const Key('goals-new'),
              label: l.goalsNew,
              leadingIcon: Symbols.add,
              foreground: AppColors.primaryStrong,
              background: AppColors.brandSoft,
              bordered: false,
              height: 44,
              expand: false,
              onPressed: () => context.push(AppRoutes.newGoal),
            ),
          ],
        ),
        if (active.isNotEmpty) ...[
          AppSpacing.gap16,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.mdAll,
            ),
            child: Wrap(
              spacing: AppSpacing.md,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  l.goalsActiveCount(active.length),
                  style: AppTypography.caption,
                ),
                _Dot(AppColors.success, l.goalsOnTrackCount(onTrack)),
                if (attention > 0)
                  _Dot(AppColors.danger, l.goalsAttentionCount(attention)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color, this.label);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.filter,
    required this.active,
    required this.completed,
    required this.onChanged,
  });

  final _GoalFilter filter;
  final int active;
  final int completed;
  final ValueChanged<_GoalFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final items = [
      (_GoalFilter.all, l.goalsFilterAll),
      (_GoalFilter.active, l.goalsFilterActive(active)),
      (_GoalFilter.completed, l.goalsFilterCompleted(completed)),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (i, (f, label)) in items.indexed) ...[
            if (i > 0) AppSpacing.gap8,
            FilterPill(
              key: Key('goals-filter-${f.name}'),
              label: label,
              selected: filter == f,
              onTap: () => onChanged(f),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrimaryCard extends ConsumerWidget {
  const _PrimaryCard({required this.view});

  final GoalView view;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final g = view.goal;
    final p = view.progress;
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((s) => s.weekStart));
    final actions =
        (ref.watch(goalActionsProvider).value ?? const <GoalAction>[])
            .where((a) => a.goalId == g.id)
            .toList();
    final next = nextActionOf(actions, now, weekStart: weekStart);
    return AppCard.hero(
      onTap: () => context.push(AppRoutes.goal(g.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CategoryChip(area: g.area, icon: true),
              AppSpacing.gap8,
              GoalHealthChip(health: p.health),
              const Spacer(),
              if (g.targetDate != null)
                Text(
                  l.goalsTargetOn(Fmt.monthDayYear(g.targetDate!.toLocal())),
                  style: AppTypography.captionSmall,
                ),
            ],
          ),
          AppSpacing.gap16,
          Text(bidiSafe(g.title), style: AppTypography.headline),
          if (g.description != null || g.why != null) ...[
            const SizedBox(height: 4),
            Text(
              bidiSafe(g.description ?? g.why!),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.body,
            ),
          ],
          AppSpacing.gap20,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: g.type == GoalType.target
                    ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: Fmt.number(p.current),
                              style: AppTypography.display.tabular,
                            ),
                            TextSpan(
                              text: ' / ${goalValue(l, g, p.target)}',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      )
                    : Text(
                        goalProgressLine(context, view),
                        style: AppTypography.sectionTitle,
                      ),
              ),
              Text(
                '${p.percent}%',
                style: AppTypography.headline.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          AppSpacing.gap8,
          AppProgressBar(value: p.ratio, height: 8),
          if (next != null) ...[
            AppSpacing.gap16,
            Material(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.mdAll,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 8, 10),
                child: Row(
                  children: [
                    CircleCheck(
                      checked: false,
                      semanticLabel: next.title,
                      onTap: () => ref
                          .read(goalsRepositoryProvider)
                          .toggleAction(next, g, true),
                    ),
                    AppSpacing.gap12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.goalsNextActionToday.toUpperCase(),
                            style: AppTypography.overline.copyWith(
                              color: AppColors.primaryStrong,
                            ),
                          ),
                          Text(
                            bidiSafe(next.title),
                            style: AppTypography.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Symbols.chevron_right,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (g.status == GoalStatus.active &&
              (g.type != GoalType.milestone || p.target > 0)) ...[
            AppSpacing.gap16,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: PrimaryButton(
                key: const Key('goals-primary-log'),
                label: l.goalsLogProgress,
                leadingIcon: Symbols.add,
                expand: false,
                onPressed: () => _log(context, view),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> _log(BuildContext context, GoalView view) async {
  if (view.goal.type == GoalType.milestone) {
    await context.push(AppRoutes.goal(view.goal.id));
    return;
  }
  final messenger = ScaffoldMessenger.of(context);
  final l = context.l10n;
  if (await showLogProgressSheet(context, view.goal)) {
    messenger.showSnackBar(SnackBar(content: Text(l.goalLogged)));
  }
}

class _MonthRecap extends ConsumerWidget {
  const _MonthRecap();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final month = PeriodRange.month(today);
    final events =
        (ref.watch(goalEventsProvider).value ?? const <GoalProgressEvent>[])
            .where((e) => month.contains(e.occurredAt))
            .toList();
    if (events.isEmpty) return const SizedBox.shrink();
    final goals = {
      for (final g in ref.watch(goalsProvider).value ?? const <Goal>[]) g.id: g,
    };
    final moved = {for (final e in events) e.goalId}.length;
    final byArea = <LifeArea, int>{};
    for (final e in events) {
      final area = goals[e.goalId]?.area;
      if (area != null) byArea[area] = (byArea[area] ?? 0) + 1;
    }
    final top =
        (byArea.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
            .take(2)
            .map((e) => e.key.label(context))
            .join(' & ');
    return AppCard(
      color: AppColors.surfaceMuted,
      borderColor: null,
      shadow: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconTile(
            icon: Symbols.auto_graph,
            color: AppColors.primaryStrong,
            background: AppColors.brandSoft,
          ),
          AppSpacing.gap12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${l.goalsMonthRecap}  ·  ',
                        style: AppTypography.label,
                      ),
                      TextSpan(
                        text: l.goalsMovedForward(moved),
                        style: AppTypography.label.copyWith(
                          color: AppColors.primaryStrong,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    l.goalsRecapBody(events.length),
                    if (top.isNotEmpty) l.goalsRecapStrongest(top),
                  ].join(' '),
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

class _GoalCard extends ConsumerWidget {
  const _GoalCard({required this.view});

  final GoalView view;

  String _meta(BuildContext context) {
    final l = context.l10n;
    final g = view.goal;
    final p = view.progress;
    if (g.type == GoalType.routine) {
      return switch (p.periodLabel) {
        PeriodKind.day => l.goalsDailyRhythm,
        PeriodKind.month => l.goalsMonthlyRhythm,
        _ => l.goalsWeeklyRhythm,
      };
    }
    if (p.health == GoalHealth.needsAttention && g.type == GoalType.target) {
      return l.goalsRemaining(goalValue(l, g, p.remaining, compact: true));
    }
    if (g.targetDate != null) return Fmt.monthDay(g.targetDate!.toLocal());
    return '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final g = view.goal;
    final p = view.progress;
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((s) => s.weekStart));
    final actions =
        (ref.watch(goalActionsProvider).value ?? const <GoalAction>[])
            .where((a) => a.goalId == g.id)
            .toList();
    final next = nextActionOf(actions, now, weekStart: weekStart);
    final met = g.type == GoalType.routine && p.ratio >= 1;
    final health = g.status == GoalStatus.paused ? GoalHealth.paused : p.health;
    return AppCard(
      onTap: () => context.push(AppRoutes.goal(g.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CategoryChip(area: g.area, icon: true),
              AppSpacing.gap8,
              met
                  ? StatusChip(
                      label: l.goalsMetPeriod,
                      icon: Symbols.done,
                      tone: StatusTone.brand,
                    )
                  : GoalHealthChip(health: health),
              const Spacer(),
              Text(
                met ? '100%' : _meta(context),
                style: AppTypography.captionSmall.copyWith(
                  color: health == GoalHealth.needsAttention || met
                      ? AppColors.primaryStrong
                      : null,
                ),
              ),
            ],
          ),
          AppSpacing.gap12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(bidiSafe(g.title), style: AppTypography.cardTitle),
              ),
              AppSpacing.gap8,
              Text(
                g.type == GoalType.target
                    ? '${Fmt.compact(p.current)} / ${goalValue(l, g, p.target, compact: true)}'
                    : '${Fmt.number(p.current)} / ${Fmt.number(p.target)}',
                style: AppTypography.label.tabular,
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(value: p.ratio, color: g.area.color, height: 6),
          AppSpacing.gap8,
          Row(
            children: [
              Expanded(
                child: Text(
                  g.type == GoalType.target
                      ? l.goalsPctCompleted(p.percent)
                      : goalProgressLine(context, view),
                  style: AppTypography.captionSmall,
                ),
              ),
              if (next != null)
                Flexible(
                  child: Text(
                    l.goalsNextShort(bidiSafe(next.title)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: AppTypography.captionSmall,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompletedArchive extends StatefulWidget {
  const _CompletedArchive({required this.views});

  final List<GoalView> views;

  @override
  State<_CompletedArchive> createState() => _CompletedArchiveState();
}

class _CompletedArchiveState extends State<_CompletedArchive> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppCard(
      padding: EdgeInsets.zero,
      color: AppColors.surfaceMuted,
      borderColor: null,
      shadow: false,
      child: Column(
        children: [
          InkWell(
            borderRadius: AppRadius.cardAll,
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  const Icon(
                    Symbols.check_circle,
                    size: 20,
                    color: AppColors.primaryStrong,
                  ),
                  AppSpacing.gap12,
                  Text(l.goalsCompletedGoals, style: AppTypography.bodyMedium),
                  AppSpacing.gap8,
                  Pill(
                    label: '${widget.views.length}',
                    foreground: AppColors.textBody,
                    background: AppColors.surface,
                    dense: true,
                  ),
                  const Spacer(),
                  Icon(
                    _open ? Symbols.expand_less : Symbols.expand_more,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (_open)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: _CompletedList(views: widget.views, flat: true),
            ),
        ],
      ),
    );
  }
}

class _CompletedList extends StatelessWidget {
  const _CompletedList({required this.views, this.flat = false});

  final List<GoalView> views;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    if (views.isEmpty) {
      return AppCard(
        child: Text(l.goalsNoCompleted, style: AppTypography.caption),
      );
    }
    final sorted = [...views]
      ..sort(
        (a, b) => (b.goal.completedAt ?? b.goal.updatedAt).compareTo(
          a.goal.completedAt ?? a.goal.updatedAt,
        ),
      );
    final rows = [
      for (final v in sorted)
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: flat ? 0 : 16),
          title: Text(bidiSafe(v.goal.title), style: AppTypography.bodyMedium),
          subtitle: Text(
            l.goalsCompletedOn(
              Fmt.monthDayYear(
                (v.goal.completedAt ?? v.goal.updatedAt).toLocal(),
              ),
            ),
            style: AppTypography.caption,
          ),
          trailing: const Icon(
            Symbols.verified,
            color: AppColors.primaryStrong,
          ),
          onTap: () => context.push(AppRoutes.goal(v.goal.id)),
        ),
    ];
    if (flat) return Column(children: rows);
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(children: rows),
    );
  }
}
