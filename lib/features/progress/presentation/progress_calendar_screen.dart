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
import '../../../core/utilities/async.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../history/data/activity_repository.dart';
import '../../settings/data/preferences.dart';
import '../../today/data/tasks_repository.dart';
import '../data/progress_providers.dart';
import '../domain/progress_calculator.dart';
import 'progress_screen.dart' show weekdayName;
import 'widgets/month_grid.dart';
import '../../history/presentation/activity_text.dart';
import '../../../core/utilities/bidi.dart';

const _overall = 'overall';

class ProgressCalendarScreen extends ConsumerStatefulWidget {
  const ProgressCalendarScreen({super.key});

  @override
  ConsumerState<ProgressCalendarScreen> createState() =>
      _ProgressCalendarScreenState();
}

class _ProgressCalendarScreenState
    extends ConsumerState<ProgressCalendarScreen> {
  DateTime? _month;
  DateTime? _selected;
  LifeArea? _area;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final month = _month ?? DateTime(today.year, today.month);
    final range = PeriodRange.month(month);
    final selected = _selected ?? (range.contains(today) ? today : null);
    final tasks = ref.watch(tasksInRangeProvider(range));
    final events = ref.watch(activityInRangeProvider(range));
    final summary = ref.watch(periodSummaryProvider(range));
    final isCurrentMonth = range.contains(today);

    return Scaffold(
      appBar: AppTopBar(
        title: l.calTitle,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: AppTextButton(
              key: const Key('calendar-today'),
              label: l.calToday,
              onPressed: isCurrentMonth && selected == today
                  ? null
                  : () => setState(() {
                      _month = DateTime(today.year, today.month);
                      _selected = today;
                    }),
            ),
          ),
        ],
      ),
      body: AsyncView<(List<Task>, List<ActivityEvent>)>(
        value: combineAsync([
          tasks,
          events,
        ], () => (tasks.requireValue, events.requireValue)),
        builder: (data) {
          final (allTasks, allEvents) = data;
          final area = _area;
          final monthTasks = area == null
              ? allTasks
              : allTasks.where((t) => t.area == area).toList();
          final monthEvents = area == null
              ? allEvents
              : allEvents.where((e) => e.area == area).toList();
          final scores = ProgressCalculator.dayScores(
            tasks: monthTasks,
            events: monthEvents,
          );
          DayStrength strength(DateTime d) => ProgressCalculator.strengthOf(
            scores[dayKeyOf(d)],
            isFuture: d.isAfter(today),
          );
          final s = summary.value;
          final elapsed = ProgressCalculator.countedDays(range, today);
          final active = elapsed
              .where((d) => scores[dayKeyOf(d)]?.active ?? false)
              .length;
          final avg = elapsed.isEmpty
              ? 0.0
              : elapsed.fold(
                      0.0,
                      (sum, d) => sum + (scores[dayKeyOf(d)]?.score ?? 0),
                    ) /
                    elapsed.length;
          final strongest = area == null ? s?.strongest : null;
          final areas = s?.areas.map((a) => a.area).toList() ?? const [];

          return ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.sm,
              AppSpacing.screen,
              AppSpacing.huge,
            ),
            children: [
              Row(
                children: [
                  CircleIconButton(
                    icon: Symbols.chevron_left,
                    tooltip: l.calPrevMonth,
                    bordered: true,
                    size: 40,
                    onPressed: () => setState(() {
                      _month = DateTime(month.year, month.month - 1);
                      _selected = null;
                    }),
                  ),
                  Expanded(
                    child: Text(
                      Fmt.monthYear(month),
                      textAlign: TextAlign.center,
                      style: AppTypography.headline,
                    ),
                  ),
                  CircleIconButton(
                    icon: Symbols.chevron_right,
                    tooltip: l.calNextMonth,
                    bordered: true,
                    size: 40,
                    onPressed: () => setState(() {
                      _month = DateTime(month.year, month.month + 1);
                      _selected = null;
                    }),
                  ),
                ],
              ),
              AppSpacing.gap16,
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: AppTypography.caption,
                        children: [
                          TextSpan(
                            text: l.calActiveDays(active, elapsed.length),
                            style: AppTypography.label,
                          ),
                          TextSpan(text: ' ${l.calActiveLabel} · '),
                          TextSpan(
                            text: Fmt.percent(avg),
                            style: AppTypography.label,
                          ),
                          TextSpan(text: ' ${l.calAvg}'),
                          if (strongest != null)
                            TextSpan(
                              text:
                                  ' · ${l.calStrongest(strongest.area.label(context))}',
                            ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.gap8,
                  _AreaFilter(
                    area: area,
                    areas: areas,
                    onChanged: (a) => setState(() => _area = a),
                  ),
                ],
              ),
              AppSpacing.gap16,
              AppCard(
                child: Column(
                  children: [
                    MonthGrid(
                      month: month,
                      weekStart: weekStart,
                      today: today,
                      strengthOf: strength,
                      selected: selected,
                      detailed: true,
                      onTap: (d) => setState(() => _selected = d),
                    ),
                    AppSpacing.gap8,
                    const StrengthLegend(includeRest: false),
                  ],
                ),
              ),
              if (selected != null) ...[
                AppSpacing.gap16,
                _SelectedDayCard(
                  day: selected,
                  isFuture: selected.isAfter(today),
                  strength: strength(selected),
                  score: scores[dayKeyOf(selected)],
                  tasks: monthTasks
                      .where((t) => t.dayKey == dayKeyOf(selected))
                      .toList(),
                  events: monthEvents
                      .where(
                        (e) => dayKeyOf(e.occurredAt) == dayKeyOf(selected),
                      )
                      .toList(),
                ),
              ],
              if (s != null && s.strongestWeekdays.length == 2) ...[
                AppSpacing.gap16,
                InsightCard(
                  icon: Symbols.lightbulb,
                  title: l.calInsight,
                  message: l.calInsightBody(
                    weekdayName(s.strongestWeekdays[0]),
                    weekdayName(s.strongestWeekdays[1]),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _AreaFilter extends StatelessWidget {
  const _AreaFilter({
    required this.area,
    required this.areas,
    required this.onChanged,
  });

  final LifeArea? area;
  final List<LifeArea> areas;
  final ValueChanged<LifeArea?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Material(
      color: AppColors.surface,
      shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
      child: InkWell(
        key: const Key('calendar-area-filter'),
        customBorder: const StadiumBorder(),
        onTap: () async {
          final choice = await showOptionSheet<String>(
            context,
            title: l.calOverall,
            selected: area?.name ?? _overall,
            options: [
              SheetOption(value: _overall, label: l.calOverall),
              for (final a in areas)
                SheetOption(value: a.name, label: a.label(context)),
            ],
          );
          if (choice == null) return;
          onChanged(choice == _overall ? null : LifeArea.values.byName(choice));
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouch),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (area != null) ...[
                  Icon(area!.icon, size: 16, color: area!.color),
                  const SizedBox(width: 6),
                ],
                Text(
                  area?.label(context) ?? l.calOverall,
                  style: AppTypography.label,
                ),
                const SizedBox(width: 4),
                const Icon(Symbols.expand_more, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedDayCard extends StatelessWidget {
  const _SelectedDayCard({
    required this.day,
    required this.isFuture,
    required this.strength,
    required this.score,
    required this.tasks,
    required this.events,
  });

  final DateTime day;
  final bool isFuture;
  final DayStrength strength;
  final DayScore? score;
  final List<Task> tasks;
  final List<ActivityEvent> events;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dayKey = dayKeyOf(day);
    final (label, tone) = switch (strength) {
      DayStrength.strong => (l.calStrongDay, StatusTone.brand),
      DayStrength.steady => (l.calSteadyDay, StatusTone.warning),
      DayStrength.light => (l.calLightDay, StatusTone.neutral),
      DayStrength.none => (l.calNoDay, StatusTone.neutral),
      DayStrength.future => (l.calFutureDay, StatusTone.info),
    };
    final done = tasks.where((t) => t.completedAt != null).length;
    final logs = events.where((e) => e.entityType != 'task').toList();

    final byArea = <LifeArea, List<String>>{};
    for (final t in tasks.where((t) => t.completedAt != null)) {
      (byArea[t.area] ??= []).add(bidiSafe(t.title));
    }
    for (final e in logs) {
      if (e.area != null) {
        (byArea[e.area!] ??= []).add(bidiSafe(ActivityText(l, e).title));
      }
    }
    final hasContent = tasks.isNotEmpty || logs.isNotEmpty;

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
                    OverlineLabel(l.calSelected),
                    const SizedBox(height: 2),
                    Text(
                      Fmt.weekdayMonthDay(day),
                      style: AppTypography.sectionTitle,
                    ),
                  ],
                ),
              ),
              StatusChip(label: label, tone: tone, dot: true),
            ],
          ),
          if (!hasContent) ...[
            AppSpacing.gap16,
            Text(
              isFuture ? l.calFutureNothing : l.calNothing,
              style: AppTypography.body,
            ),
            if (isFuture) ...[
              AppSpacing.gap12,
              SecondaryButton(
                label: l.calOpenPlan,
                leadingIcon: Symbols.event_note,
                onPressed: () => context.push(AppRoutes.planOn(dayKey)),
              ),
            ],
          ] else ...[
            AppSpacing.gap16,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    l.calTotalProgress(Fmt.percent(score?.score ?? 0)),
                    style: AppTypography.cardTitle,
                  ),
                ),
                if (tasks.isNotEmpty)
                  Text(
                    l.calActionsDone(done, tasks.length),
                    style: AppTypography.caption,
                  ),
              ],
            ),
            AppSpacing.gap8,
            AppProgressBar(value: score?.score ?? 0),
            if (byArea.isNotEmpty) ...[
              AppSpacing.gap20,
              SectionHeader(title: l.calContributions),
              for (final entry in byArea.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      IconTile(
                        icon: entry.key.icon,
                        color: entry.key.color,
                        background: entry.key.soft,
                        size: 32,
                        iconSize: 16,
                      ),
                      AppSpacing.gap12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key.label(context),
                              style: AppTypography.bodyMedium,
                            ),
                            Text(
                              entry.value.take(2).join(' · '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.captionSmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        l.calEntries(entry.value.length),
                        style: AppTypography.captionSmall,
                      ),
                    ],
                  ),
                ),
            ],
            if (tasks.isNotEmpty) ...[
              AppSpacing.gap12,
              SectionHeader(title: l.calActionsOn(Fmt.monthDay(day))),
              for (final t in tasks)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        t.completedAt != null
                            ? Symbols.check_circle
                            : Symbols.radio_button_unchecked,
                        size: 20,
                        fill: t.completedAt != null ? 1 : 0,
                        color: t.completedAt != null
                            ? AppColors.success
                            : AppColors.textMuted,
                      ),
                      AppSpacing.gap12,
                      Expanded(
                        child: Text(
                          bidiSafe(t.title),
                          style: AppTypography.body.copyWith(
                            color: t.completedAt != null
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        t.completedAt != null ? l.calDone : l.calPending,
                        style: AppTypography.captionSmall,
                      ),
                    ],
                  ),
                ),
            ],
            AppSpacing.gap12,
            SecondaryButton(
              key: const Key('calendar-view-day'),
              label: l.calViewFull,
              icon: Symbols.arrow_forward,
              onPressed: () => context.push(AppRoutes.activityOn(dayKey)),
            ),
          ],
        ],
      ),
    );
  }
}
