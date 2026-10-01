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
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/input_sheets.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/module_scaffold.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../settings/data/preferences.dart';
import '../../settings/data/settings_store.dart';
import '../../today/presentation/widgets/day_labels.dart';
import '../data/health_repository.dart';
import 'habit_form.dart';
import 'health_log_sheets.dart';

class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final habits = ref.watch(habitsProvider);
    return ModuleScaffold(
      title: l.healthTitle,
      subtitle: l.healthSubtitle,
      actions: [
        CircleIconButton(
          icon: Symbols.calendar_month,
          tooltip: l.commonHistory,
          background: Colors.transparent,
          onPressed: () => context.push(AppRoutes.activity),
        ),
        CircleIconButton(
          icon: Symbols.tune,
          tooltip: l.commonTargets,
          background: Colors.transparent,
          onPressed: () => showAppSheet<void>(
            context,
            builder: (_) => const _HealthTargetsSheet(),
          ),
        ),
      ],
      children: [
        AsyncView<List<Habit>>(
          value: habits,
          builder: (list) => _HealthBody(habits: list),
        ),
      ],
    );
  }
}

class _HealthBody extends ConsumerWidget {
  const _HealthBody({required this.habits});

  final List<Habit> habits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final targets = ref.watch(dailyTargetsProvider);
    final day = PeriodRange.day(today);
    final week = PeriodRange.week(today, weekStart: weekStart);
    final last7 = PeriodRange.trailing(today, 7);

    final walks = ref.watch(walksProvider(week)).value ?? const <WalkingLog>[];
    final workouts =
        ref.watch(workoutsProvider(week)).value ?? const <WorkoutLog>[];
    final sleeps =
        ref.watch(sleepProvider(PeriodRange.trailing(today, 14))).value ??
        const <SleepLog>[];
    final weekLogs =
        ref.watch(habitLogsProvider(week)).value ?? const <HabitLog>[];
    final recentLogs =
        ref.watch(habitLogsProvider(last7)).value ?? const <HabitLog>[];

    final todayKey = dayKeyOf(today);
    final walkToday = walks.where((w) => day.contains(w.occurredAt)).toList();
    final workoutToday = workouts.where((w) => day.contains(w.occurredAt));
    final walkMinutes = walkToday.fold<int>(0, (s, w) => s + w.minutes);
    final movement =
        walkMinutes + workoutToday.fold<int>(0, (s, w) => s + w.minutes);
    final lastNight = sleeps.where((s) => s.dayKey == todayKey).firstOrNull;
    final doneToday = {
      for (final log in weekLogs)
        if (log.dayKey == todayKey) log.habitId,
    };
    final habitsDone = habits.where((h) => doneToday.contains(h.id)).length;

    final activeDays = {
      for (final w in walks) dayKeyOf(w.occurredAt),
      for (final w in workouts) dayKeyOf(w.occurredAt),
      for (final log in weekLogs) log.dayKey,
    };

    final recentSleeps = sleeps
        .where((s) => last7.containsKey(s.dayKey))
        .toList();
    final sleepAvg = recentSleeps.isEmpty
        ? 0
        : recentSleeps
                  .map((s) => s.wakeTime.difference(s.bedTime).inMinutes)
                  .reduce((a, b) => a + b) ~/
              recentSleeps.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (recentSleeps.length >= 3) ...[
          InfoBanner(
            message: l.healthSleepInsight(
              Fmt.minutes(sleepAvg),
              recentSleeps.length,
            ),
            icon: Symbols.bedtime,
            color: AppColors.health,
            background: AppColors.healthSoft,
          ),
          AppSpacing.gap16,
        ],
        _TodayCard(
          movement: movement,
          workoutDone: workoutToday.isNotEmpty,
          sleepMinutes: lastNight?.wakeTime
              .difference(lastNight.bedTime)
              .inMinutes,
          habitsDone: habitsDone,
          habitsTotal: habits.length,
        ),
        AppSpacing.gap16,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              QuickActionButton(
                icon: Symbols.fitness_center,
                label: l.healthLogWorkout,
                color: AppColors.health,
                onTap: () => showWorkoutSheet(context),
              ),
              AppSpacing.gap8,
              QuickActionButton(
                icon: Symbols.directions_walk,
                label: l.healthLogWalk,
                color: AppColors.health,
                onTap: () => showWalkSheet(context),
              ),
              AppSpacing.gap8,
              QuickActionButton(
                icon: Symbols.bedtime,
                label: l.healthLogSleep,
                color: AppColors.health,
                onTap: () => showSleepSheet(context),
              ),
            ],
          ),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.healthWorkout,
          trailingText: l.healthScheduledLogged,
        ),
        _WorkoutCard(workouts: workouts),
        AppSpacing.gap28,
        SectionHeader(
          title: l.healthWalking,
          trailingText: l.healthTargetMin(targets.walkMinutes),
        ),
        _WalkCard(minutes: walkMinutes, walks: walkToday.length),
        AppSpacing.gap28,
        SectionHeader(title: l.healthSleep, trailingText: l.healthSleepRhythm),
        _SleepCard(sleep: lastNight),
        AppSpacing.gap28,
        _HabitsSection(habits: habits, logs: recentLogs, today: today),
        AppSpacing.gap28,
        SectionHeader(
          title: l.healthGoals,
          trailingText: l.healthWeeklyProgress,
        ),
        const AreaGoalsSection(area: LifeArea.health),
        AppSpacing.gap20,
        _WeekCard(week: week, activeDays: activeDays, today: today),
      ],
    );
  }
}

class _TodayCard extends ConsumerWidget {
  const _TodayCard({
    required this.movement,
    required this.workoutDone,
    required this.sleepMinutes,
    required this.habitsDone,
    required this.habitsTotal,
  });

  final int movement;
  final bool workoutDone;
  final int? sleepMinutes;
  final int habitsDone;
  final int habitsTotal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final target = ref.watch(dailyTargetsProvider).walkMinutes;
    final date = ref.watch(currentDayProvider);
    final ratio = movement / target;
    final remaining = target - movement;
    Widget chip(IconData icon, String value, String label, bool good) =>
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: good ? AppColors.healthSoft : AppColors.surfaceMuted,
            borderRadius: AppRadius.mdAll,
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 14,
                    color: good ? AppColors.health : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(value, style: AppTypography.label),
                ],
              ),
              Text(label, style: AppTypography.captionSmall),
            ],
          ),
        );
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: OverlineLabel(
                  l.commonToday,
                  color: AppColors.primaryStrong,
                ),
              ),
              Text(Fmt.weekdayMonthDay(date), style: AppTypography.caption),
            ],
          ),
          AppSpacing.gap12,
          Row(
            children: [
              const Icon(
                Symbols.directions_run,
                color: AppColors.health,
                size: 22,
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(
                  l.healthMovementToday,
                  style: AppTypography.sectionTitle,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$movement',
                      style: AppTypography.headline.tabular,
                    ),
                    TextSpan(
                      text: ' / $target min',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(
            value: ratio.clamp(0.0, 1.0),
            color: AppColors.primaryStrong,
          ),
          AppSpacing.gap8,
          Row(
            children: [
              Expanded(
                child: Text(
                  l.healthPctCompleted(Fmt.percent(ratio.clamp(0.0, 1.0))),
                  style: AppTypography.caption,
                ),
              ),
              Text(
                remaining > 0
                    ? l.healthMinRemaining(remaining)
                    : l.healthTargetMet,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          AppSpacing.gap16,
          EvenRow(
            children: [
              chip(
                Symbols.fitness_center,
                workoutDone ? l.healthDone : l.healthNotYet,
                l.healthWorkout,
                workoutDone,
              ),
              chip(
                Symbols.bedtime,
                sleepMinutes == null ? '—' : Fmt.minutes(sleepMinutes!),
                l.healthSleep,
                sleepMinutes != null,
              ),
              chip(
                Symbols.checklist,
                l.healthHabitsOf(habitsDone, habitsTotal),
                l.healthHabits,
                habitsTotal > 0 && habitsDone == habitsTotal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.workouts});

  final List<WorkoutLog> workouts;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    if (workouts.isEmpty) {
      return AppCard(
        onTap: () => showWorkoutSheet(context),
        child: Row(
          children: [
            const IconTile(
              icon: Symbols.fitness_center,
              color: AppColors.health,
              background: AppColors.healthSoft,
            ),
            AppSpacing.gap12,
            Expanded(
              child: Text(l.healthNoWorkout, style: AppTypography.caption),
            ),
          ],
        ),
      );
    }
    final sorted = [...workouts]
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        children: [
          for (final w in sorted.take(3))
            ActivityRow(
              icon: Symbols.fitness_center,
              color: AppColors.health,
              background: AppColors.healthSoft,
              title: w.title,
              subtitle: [
                Fmt.minutes(w.minutes),
                ?w.detail,
                Fmt.weekdayShort(w.occurredAt.toLocal()),
              ].join(' · '),
              trailing: l.healthCompleted,
            ),
        ],
      ),
    );
  }
}

class _WalkCard extends ConsumerWidget {
  const _WalkCard({required this.minutes, required this.walks});

  final int minutes;
  final int walks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final target = ref.watch(dailyTargetsProvider).walkMinutes;
    final ratio = (minutes / target).clamp(0.0, 1.0);
    final remaining = target - minutes;
    return AppCard(
      onTap: () => showWalkSheet(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const IconTile(
                icon: Symbols.directions_walk,
                color: AppColors.health,
                background: AppColors.healthSoft,
              ),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$minutes / $target min',
                      style: AppTypography.cardTitle.tabular,
                    ),
                    Text(
                      l.healthWalksToday(walks),
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              Text(
                Fmt.percent(ratio),
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(value: ratio, height: 6),
          AppSpacing.gap8,
          Row(
            children: [
              Icon(
                remaining > 0 ? Symbols.schedule : Symbols.check_circle,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  remaining > 0
                      ? l.healthWalkRemaining(remaining)
                      : l.healthWalkDone,
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

class _SleepCard extends ConsumerWidget {
  const _SleepCard({required this.sleep});

  final SleepLog? sleep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final target = ref.watch(dailyTargetsProvider).sleepMinutes;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final s = sleep;
    if (s == null) {
      return AppCard(
        onTap: () => showSleepSheet(context),
        child: Row(
          children: [
            const IconTile(
              icon: Symbols.bedtime,
              color: AppColors.health,
              background: AppColors.healthSoft,
            ),
            AppSpacing.gap12,
            Expanded(
              child: Text(l.healthNoSleep, style: AppTypography.caption),
            ),
          ],
        ),
      );
    }
    final minutes = s.wakeTime.difference(s.bedTime).inMinutes;
    final gap = target - minutes;
    return AppCard(
      onTap: () => showSleepSheet(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const IconTile(
                icon: Symbols.bedtime,
                color: AppColors.health,
                background: AppColors.healthSoft,
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
                            text: Fmt.minutes(minutes),
                            style: AppTypography.headline.tabular,
                          ),
                          TextSpan(
                            text:
                                ' ${l.healthSleepTarget(Fmt.minutes(target))}',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      l.healthBedWake(
                        Fmt.time(s.bedTime.toLocal(), use24h: use24h),
                        Fmt.time(s.wakeTime.toLocal(), use24h: use24h),
                      ),
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              gap > 15
                  ? StatusChip(
                      label: l.healthBelowTarget(Fmt.minutes(gap)),
                      tone: StatusTone.info,
                    )
                  : StatusChip(
                      label: l.healthOnTarget,
                      tone: StatusTone.success,
                    ),
            ],
          ),
          if (s.energy != null) ...[
            AppSpacing.gap12,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                children: [
                  Icon(
                    energyIcon(s.energy!),
                    size: 16,
                    color: AppColors.health,
                  ),
                  AppSpacing.gap8,
                  Text(
                    l.healthEnergyToday(energyLabel(context, s.energy!)),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textBody,
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

class _HabitsSection extends ConsumerStatefulWidget {
  const _HabitsSection({
    required this.habits,
    required this.logs,
    required this.today,
  });

  final List<Habit> habits;
  final List<HabitLog> logs;
  final DateTime today;

  @override
  ConsumerState<_HabitsSection> createState() => _HabitsSectionState();
}

class _HabitsSectionState extends ConsumerState<_HabitsSection> {
  bool _editing = false;

  Future<void> _edit(Habit habit) async {
    final l = context.l10n;
    final action = await showOptionSheet<String>(
      context,
      title: habit.name,
      options: [
        SheetOption(value: 'rename', label: l.healthRenameHabit),
        SheetOption(value: 'archive', label: l.healthArchiveHabit),
      ],
    );
    if (!mounted || action == null) return;
    final repo = ref.read(healthRepositoryProvider);
    if (action == 'rename') {
      final name = await showTextSheet(
        context,
        title: l.healthRenameHabit,
        initial: habit.name,
        actionLabel: l.commonSave,
      );
      if (name != null) await repo.updateHabit(habit.copyWith(name: name));
    } else {
      final ok = await showConfirmDialog(
        context,
        title: l.healthArchiveHabit,
        message: l.healthArchiveBody,
        confirmLabel: l.healthArchiveHabit,
        destructive: true,
      );
      if (ok) await repo.archiveHabit(habit);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final habits = widget.habits;
    final days = PeriodRange.trailing(widget.today, 7).dayKeys;
    final todayKey = dayKeyOf(widget.today);
    final done = {
      for (final log in widget.logs) '${log.habitId}|${log.dayKey}',
    };
    final doneToday = habits
        .where((h) => done.contains('${h.id}|$todayKey'))
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.healthDailyHabits,
          badge: habits.isEmpty
              ? null
              : Pill(
                  label: l.healthHabitsCompleted(doneToday, habits.length),
                  foreground: AppColors.textBody,
                  background: AppColors.surfaceMuted,
                  dense: true,
                ),
          trailingText: habits.isEmpty
              ? null
              : (_editing ? l.healthDoneEditing : l.healthEditHabits),
          onTrailingTap: habits.isEmpty
              ? null
              : () => setState(() => _editing = !_editing),
        ),
        if (habits.isEmpty)
          EmptyState(
            icon: Symbols.autorenew,
            title: l.habitNew,
            message: l.habitEmpty,
            actionLabel: l.habitAdd,
            onAction: () => showHabitSheet(context, startWithNew: true),
          )
        else ...[
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              children: [
                for (final (i, h) in habits.indexed) ...[
                  if (i > 0)
                    const Divider(height: 1, indent: 16, endIndent: 16),
                  _HabitLine(
                    habit: h,
                    doneToday: done.contains('${h.id}|$todayKey'),
                    history: [
                      for (final d in days) done.contains('${h.id}|$d'),
                    ],
                    editing: _editing,
                    onToggle: (v) => ref
                        .read(healthRepositoryProvider)
                        .setHabitDone(h, todayKey, v),
                    onEdit: () => _edit(h),
                  ),
                ],
              ],
            ),
          ),
          AppSpacing.gap8,
          AddRowButton(
            label: l.habitNew,
            color: AppColors.health,
            onTap: () => showHabitSheet(context, startWithNew: true),
          ),
        ],
      ],
    );
  }
}

class _HabitLine extends StatelessWidget {
  const _HabitLine({
    required this.habit,
    required this.doneToday,
    required this.history,
    required this.editing,
    required this.onToggle,
    required this.onEdit,
  });

  final Habit habit;
  final bool doneToday;
  final List<bool> history;
  final bool editing;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: editing ? onEdit : () => onToggle(!doneToday),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            if (editing)
              const Icon(Symbols.edit, size: 20, color: AppColors.textSecondary)
            else
              CircleCheck(
                checked: doneToday,
                square: true,
                onTap: () => onToggle(!doneToday),
                semanticLabel: habit.name,
              ),
            AppSpacing.gap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(habit.name, style: AppTypography.bodyMedium),
                  Text(
                    habit.label ?? habit.area.label(context),
                    style: AppTypography.captionSmall,
                  ),
                ],
              ),
            ),
            if (editing)
              const Icon(Symbols.more_horiz, color: AppColors.textMuted)
            else
              Row(
                children: [
                  for (final d in history)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: d ? AppColors.primaryStrong : AppColors.border,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({
    required this.week,
    required this.activeDays,
    required this.today,
  });

  final PeriodRange week;
  final Set<String> activeDays;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final todayKey = dayKeyOf(today);
    final count = week.dayKeys.where(activeDays.contains).length;
    return AppCard(
      color: AppColors.brandSoft,
      borderColor: null,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.check_circle,
                color: AppColors.primaryStrong,
                size: 20,
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(
                  l.healthActiveDays(count),
                  style: AppTypography.cardTitle,
                ),
              ),
            ],
          ),
          AppSpacing.gap4,
          Text(l.healthWeekNote, style: AppTypography.caption),
          AppSpacing.gap16,
          WeekDots(
            large: true,
            labels: [for (final d in week.days) Fmt.weekdayNarrow(d)],
            states: [
              for (final d in week.days)
                if (activeDays.contains(dayKeyOf(d)))
                  DotState.done
                else if (dayKeyOf(d) == todayKey)
                  DotState.today
                else if (d.isAfter(today))
                  DotState.future
                else
                  DotState.missed,
            ],
          ),
        ],
      ),
    );
  }
}

class _HealthTargetsSheet extends ConsumerStatefulWidget {
  const _HealthTargetsSheet();

  @override
  ConsumerState<_HealthTargetsSheet> createState() =>
      _HealthTargetsSheetState();
}

class _HealthTargetsSheetState extends ConsumerState<_HealthTargetsSheet> {
  late final DailyTargets _initial = ref.read(dailyTargetsProvider);
  late double _walk = _initial.walkMinutes.toDouble();
  late double _sleep = _initial.sleepMinutes / 60;
  late double _workouts = _initial.workoutsPerWeek.toDouble();

  Future<void> _save() async {
    final store = ref.read(settingsStoreProvider);
    await store.setInt(SettingKeys.walkMinutes, _walk.round());
    await store.setInt(SettingKeys.sleepMinutes, (_sleep * 60).round());
    await store.setInt(SettingKeys.workoutsPerWeek, _workouts.round());
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.commonTargets,
      action: PrimaryButton(label: l.commonSave, onPressed: _save),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(label: l.healthTargetWalk),
          AppSpacing.gap8,
          NumberStepper(
            value: _walk,
            step: 5,
            min: 5,
            max: 240,
            onChanged: (v) => setState(() => _walk = v),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.healthTargetSleep),
          AppSpacing.gap8,
          NumberStepper(
            value: _sleep,
            step: 0.25,
            min: 4,
            max: 12,
            format: (v) => Fmt.minutes((v * 60).round()),
            onChanged: (v) => setState(() => _sleep = v),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.healthTargetWorkouts),
          AppSpacing.gap8,
          NumberStepper(
            value: _workouts,
            min: 1,
            max: 14,
            onChanged: (v) => setState(() => _workouts = v),
          ),
        ],
      ),
    );
  }
}
