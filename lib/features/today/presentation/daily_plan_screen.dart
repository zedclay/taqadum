import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/pickers.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../settings/data/preferences.dart';
import '../data/daily_repository.dart';
import '../data/tasks_repository.dart';
import '../domain/today_summary.dart';
import 'widgets/day_labels.dart';
import 'widgets/task_labels.dart';
import 'widgets/task_sheets.dart';

class DailyPlanScreen extends ConsumerStatefulWidget {
  const DailyPlanScreen({super.key, this.initialDayKey});

  final String? initialDayKey;

  @override
  ConsumerState<DailyPlanScreen> createState() => _DailyPlanScreenState();
}

class _DailyPlanScreenState extends ConsumerState<DailyPlanScreen> {
  late String _dayKey = widget.initialDayKey ?? ref.read(todayKeyProvider);
  bool _reorderPriorities = false;
  bool _hideCompleted = false;

  Future<void> _pickDay() async {
    final date = await pickDate(context, initial: dateOfKey(_dayKey));
    if (date != null) setState(() => _dayKey = dayKeyOf(date));
  }

  Future<void> _moveUnfinished(List<Task> tasks) async {
    final tomorrow = dayKeyOf(addDays(dateOfKey(_dayKey), 1));
    final unfinished = tasks.where((t) => t.completedAt == null).toList();
    final repo = ref.read(tasksRepositoryProvider);
    for (final t in unfinished) {
      await repo.reschedule(t, dayKey: tomorrow);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.planMovedCount(unfinished.length))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final todayKey = ref.watch(todayKeyProvider);
    final day = dateOfKey(_dayKey);
    final tasks = ref.watch(tasksForDayProvider(_dayKey));
    final list = tasks.value ?? const <Task>[];
    return Scaffold(
      appBar: AppTopBar(
        title: _dayKey == todayKey ? l.planTitleToday : Fmt.weekdayLong(day),
        subtitle: Fmt.weekdayDayMonth(day),
        actions: [
          CircleIconButton(
            icon: Symbols.calendar_today,
            tooltip: l.planCalendar,
            bordered: true,
            onPressed: _pickDay,
          ),
          PopupMenuButton<String>(
            tooltip: l.planMore,
            icon: const Icon(Symbols.more_vert),
            onSelected: (v) {
              if (v == 'move') _moveUnfinished(list);
              if (v == 'completed') {
                setState(() => _hideCompleted = !_hideCompleted);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'move',
                enabled: list.any((t) => t.completedAt == null),
                child: Text(l.planMoveUnfinished),
              ),
              PopupMenuItem(
                value: 'completed',
                child: Text(
                  _hideCompleted ? l.planShowCompleted : l.planClearCompleted,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _DateStrip(
            selectedKey: _dayKey,
            todayKey: todayKey,
            onSelect: (k) => setState(() => _dayKey = k),
          ),
          Expanded(
            child: AsyncView<List<Task>>(
              value: tasks,
              builder: (list) => _PlanBody(
                dayKey: _dayKey,
                tasks: list,
                isPast: _dayKey.compareTo(todayKey) < 0,
                isToday: _dayKey == todayKey,
                hideCompleted: _hideCompleted,
                reorderPriorities: _reorderPriorities,
                onToggleReorder: () =>
                    setState(() => _reorderPriorities = !_reorderPriorities),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateStrip extends StatelessWidget {
  const _DateStrip({
    required this.selectedKey,
    required this.todayKey,
    required this.onSelect,
  });

  final String selectedKey;
  final String todayKey;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final center = dateOfKey(selectedKey);
    final days = [for (var i = -3; i <= 3; i++) addDays(center, i)];
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen - 4,
        AppSpacing.xs,
        AppSpacing.screen - 4,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          for (final d in days)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _DayChip(
                  date: d,
                  label: dayKeyOf(d) == todayKey
                      ? l.commonToday.toUpperCase()
                      : Fmt.weekdayShort(d),
                  selected: dayKeyOf(d) == selectedKey,
                  isToday: dayKeyOf(d) == todayKey,
                  onTap: () => onSelect(dayKeyOf(d)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.date,
    required this.label,
    required this.selected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime date;
  final String label;
  final bool selected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.white : AppColors.textPrimary;
    return Semantics(
      selected: selected,
      button: true,
      label: Fmt.weekdayDayMonth(date),
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.small),
        height: selected ? 64 : 56,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryStrong : AppColors.surface,
          borderRadius: AppRadius.mdAll,
          border: Border.all(
            color: selected ? AppColors.primaryStrong : AppColors.border,
          ),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: AppColors.fabShadow,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.mdAll,
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: AppTypography.captionSmall.copyWith(
                    color: selected ? Colors.white : AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${date.day}',
                  style: AppTypography.sectionTitle.copyWith(color: fg).tabular,
                ),
                if (isToday)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected ? Colors.white : AppColors.brand,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanBody extends ConsumerWidget {
  const _PlanBody({
    required this.dayKey,
    required this.tasks,
    required this.isPast,
    required this.isToday,
    required this.hideCompleted,
    required this.reorderPriorities,
    required this.onToggleReorder,
  });

  final String dayKey;
  final List<Task> tasks;
  final bool isPast;
  final bool isToday;
  final bool hideCompleted;
  final bool reorderPriorities;
  final VoidCallback onToggleReorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final summary = TodaySummary.of(tasks);
    final checkIn = ref.watch(checkInProvider(dayKey)).value;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final now = ref.watch(clockProvider)();
    final nowMinute = now.hour * 60 + now.minute;
    final visible = hideCompleted
        ? tasks.where((t) => t.completedAt == null).toList()
        : tasks;
    final groups = groupByDayPart(visible);
    final repo = ref.read(tasksRepositoryProvider);

    Widget taskCard(Task t, {Widget? trailing}) {
      final start = t.scheduledMinute;
      final current =
          isToday &&
          start != null &&
          t.completedAt == null &&
          nowMinute >= start &&
          nowMinute < start + (t.durationMinutes ?? 30);
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: TaskRow(
          key: ValueKey('plan-task-${t.id}'),
          title: t.title,
          subtitle: taskMeta(context, t, use24h: use24h),
          done: t.completedAt != null,
          highlight: current,
          onToggle: () => repo.setDone(t, t.completedAt == null),
          onTap: () => showTaskOptions(context, ref, t, dayTasks: tasks),
          trailing: trailing,
        ),
      );
    }

    if (tasks.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          EmptyState(
            icon: Symbols.event_note,
            title: l.planEmptyTitle,
            message: l.planEmptyBody,
            actionLabel: l.planAddAction,
            onAction: () => showTaskSheet(context, dayKey: dayKey),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        0,
        AppSpacing.screen,
        AppSpacing.huge,
      ),
      children: [
        _SummaryCard(summary: summary, capacity: checkIn?.capacity),
        if (isPast) ...[
          AppSpacing.gap12,
          Text(l.planPastDay, style: AppTypography.caption),
        ],
        if (summary.priorities.isNotEmpty) ...[
          AppSpacing.gap24,
          Row(
            children: [
              const Icon(
                Symbols.flag,
                color: AppColors.primaryStrong,
                size: 20,
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(
                  l.planTopPriorities,
                  style: AppTypography.sectionTitle,
                ),
              ),
              if (summary.priorities.length > 1)
                AppTextButton(
                  label: reorderPriorities ? l.planDoneReorder : l.planReorder,
                  icon: reorderPriorities ? Symbols.check : Symbols.swap_vert,
                  onPressed: onToggleReorder,
                ),
            ],
          ),
          AppSpacing.gap8,
          if (reorderPriorities)
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              onReorderItem: (from, to) {
                final ids = summary.priorities.map((t) => t.id).toList();
                final id = ids.removeAt(from);
                ids.insert(to, id);
                repo.setPriorities(dayKey, ids);
              },
              children: [
                for (final (i, t) in summary.priorities.indexed)
                  _PriorityCard(
                    key: ValueKey('prio-${t.id}'),
                    task: t,
                    use24h: use24h,
                    dragIndex: i,
                    onToggle: () => repo.setDone(t, t.completedAt == null),
                    onTap: null,
                  ),
              ],
            )
          else
            for (final t in summary.priorities)
              _PriorityCard(
                task: t,
                use24h: use24h,
                onToggle: () => repo.setDone(t, t.completedAt == null),
                onTap: () => showTaskOptions(context, ref, t, dayTasks: tasks),
              ),
        ],
        for (final part in DayPart.values)
          if (groups[part]!.isNotEmpty) ...[
            AppSpacing.gap20,
            _PartHeader(part: part, tasks: groups[part]!),
            AppSpacing.gap8,
            if (part == DayPart.anytime && groups[part]!.length > 1)
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                onReorderItem: (from, to) {
                  final list = [...groups[part]!];
                  final t = list.removeAt(from);
                  list.insert(to, t);
                  repo.reorder(list);
                },
                children: [
                  for (final (i, t) in groups[part]!.indexed)
                    KeyedSubtree(
                      key: ValueKey('anytime-${t.id}'),
                      child: taskCard(
                        t,
                        trailing: ReorderableDragStartListener(
                          index: i,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Symbols.drag_indicator,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            else
              for (final t in groups[part]!) taskCard(t),
          ],
        AppSpacing.gap16,
        AddRowButton(
          key: const Key('plan-add-action'),
          label: l.planAddAction,
          icon: Symbols.add,
          onTap: () => showTaskSheet(context, dayKey: dayKey),
        ),
        AppSpacing.gap12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Symbols.verified, color: AppColors.success, size: 16),
            AppSpacing.gap8,
            Flexible(
              child: Text(
                summary.left == 0 ? l.planAllDone : l.planAllSet,
                style: AppTypography.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary, this.capacity});

  final TodaySummary summary;
  final Capacity? capacity;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final load = loadOf(summary.plannedMinutes, capacity);
    final loadText = switch (load) {
      DayLoad.light => l.planLoadLight,
      DayLoad.balanced => l.planLoadBalanced,
      DayLoad.heavy => l.planLoadHeavy,
    };
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: AppSpacing.sm,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          l.planCompleted(summary.done, summary.total),
                          style: AppTypography.cardTitle,
                        ),
                        if (summary.plannedMinutes > 0)
                          Text(
                            '· ${l.planPlanned(Fmt.minutes(summary.plannedMinutes))}',
                            style: AppTypography.caption,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(loadText, style: AppTypography.caption),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${summary.percent}%',
                    style: AppTypography.metric.copyWith(
                      color: AppColors.primaryStrong,
                    ),
                  ),
                  if (capacity != null)
                    Pill(
                      label: capacityLabel(context, capacity!),
                      foreground: AppColors.info,
                      background: AppColors.infoSoft,
                      dot: true,
                      dense: true,
                    ),
                ],
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(value: summary.ratio),
        ],
      ),
    );
  }
}

class _PriorityCard extends StatelessWidget {
  const _PriorityCard({
    super.key,
    required this.task,
    required this.use24h,
    required this.onToggle,
    required this.onTap,
    this.dragIndex,
  });

  final Task task;
  final bool use24h;
  final VoidCallback onToggle;
  final VoidCallback? onTap;
  final int? dragIndex;

  @override
  Widget build(BuildContext context) {
    final done = task.completedAt != null;
    final badge = taskBadge(task) ?? taskTimeLabel(task, use24h: use24h);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
        onTap: onTap,
        child: Row(
          children: [
            Text(
              task.priorityRank.toString().padLeft(2, '0'),
              style: AppTypography.headline
                  .copyWith(color: AppColors.primaryStrong, fontSize: 20)
                  .tabular,
            ),
            AppSpacing.gap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle.copyWith(
                      fontSize: 15,
                      color: done ? AppColors.textMuted : AppColors.textPrimary,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CategoryChip(area: task.area, dot: false),
                      if (badge != null) ...[
                        AppSpacing.gap8,
                        Flexible(
                          child: Text(
                            badge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (dragIndex != null)
              ReorderableDragStartListener(
                index: dragIndex!,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Symbols.drag_indicator,
                    color: AppColors.textMuted,
                  ),
                ),
              )
            else
              CircleCheck(
                checked: done,
                onTap: onToggle,
                color: task.area.color,
                semanticLabel: task.title,
              ),
          ],
        ),
      ),
    );
  }
}

class _PartHeader extends StatelessWidget {
  const _PartHeader({required this.part, required this.tasks});

  final DayPart part;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final done = tasks.where((t) => t.completedAt != null).length;
    return Row(
      children: [
        Icon(dayPartIcon(part), size: 18, color: AppColors.textSecondary),
        AppSpacing.gap8,
        Expanded(
          child: Text(
            l.planSectionCount(dayPartLabel(context, part), tasks.length),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(l.planDoneCount(done), style: AppTypography.caption),
      ],
    );
  }
}
