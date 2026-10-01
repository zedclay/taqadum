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
import '../../../core/utilities/relative_time.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
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
import '../../today/data/tasks_repository.dart';
import '../../today/presentation/widgets/task_sheets.dart';
import '../data/learning_repository.dart';
import 'learning_sheets.dart';

class LearningScreen extends ConsumerWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final sessions = ref.watch(
      learningSessionsProvider(PeriodRange.trailing(today, 60)),
    );
    return ModuleScaffold(
      title: l.learnTitle,
      subtitle: l.learnSubtitle,
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
            builder: (_) => const _LearningTargetsSheet(),
          ),
        ),
      ],
      children: [
        AsyncView<List<LearningSession>>(
          value: sessions,
          builder: (list) => _LearningBody(sessions: list),
        ),
      ],
    );
  }
}

class _LearningBody extends ConsumerWidget {
  const _LearningBody({required this.sessions});

  final List<LearningSession> sessions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final target = ref.watch(dailyTargetsProvider).studyMinutes;
    final day = PeriodRange.day(today);
    final week = PeriodRange.week(today, weekStart: weekStart);
    final todaySessions = sessions.where((s) => day.contains(s.occurredAt));
    final weekSessions = sessions
        .where((s) => week.contains(s.occurredAt))
        .toList();
    final minutesToday = todaySessions.fold<int>(0, (s, x) => s + x.minutes);

    final actionRange = PeriodRange.trailing(addDays(today, 14), 21);
    final actions =
        (ref.watch(tasksInRangeProvider(actionRange)).value ?? const <Task>[])
            .where((t) => t.area == LifeArea.learning)
            .toList();
    final appliedToday = actions
        .where((t) => t.completedAt != null && day.contains(t.completedAt!))
        .length;
    final appliedWeek = actions
        .where((t) => t.completedAt != null && week.contains(t.completedAt!))
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (minutesToday >= target) ...[
          InfoBanner(
            message: l.learnTargetBanner,
            icon: Symbols.auto_awesome,
            color: AppColors.learning,
            background: AppColors.learningSoft,
          ),
          AppSpacing.gap16,
        ],
        _TodayCard(minutes: minutesToday, applied: appliedToday),
        AppSpacing.gap16,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              QuickActionButton(
                key: const Key('learn-log-study'),
                icon: Symbols.add_circle,
                label: l.learnLogStudy,
                color: AppColors.learning,
                onTap: () => showStudySheet(context),
              ),
              AppSpacing.gap8,
              QuickActionButton(
                icon: Symbols.edit_note,
                label: l.learnAddTakeaway,
                color: AppColors.learning,
                onTap: () => showTakeawaySheet(context, ref),
              ),
              AppSpacing.gap8,
              QuickActionButton(
                icon: Symbols.bolt,
                label: l.learnNewAction,
                color: AppColors.learning,
                onTap: () => showTaskSheet(context, area: LifeArea.learning),
              ),
            ],
          ),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.learnCurrentFocus,
          badge: Pill(
            label: l.learnActiveSubject,
            foreground: AppColors.learning,
            background: AppColors.learningSoft,
            dense: true,
          ),
        ),
        _FocusCard(weekSessions: weekSessions),
        AppSpacing.gap28,
        _ApplySection(actions: actions),
        AppSpacing.gap28,
        SectionHeader(title: l.learnSessions, trailingText: l.learnRecent),
        _SessionsCard(sessions: sessions),
        AppSpacing.gap28,
        SectionHeader(title: l.learnGoals),
        const AreaGoalsSection(area: LifeArea.learning),
        AppSpacing.gap28,
        const _ResourcesSection(),
        AppSpacing.gap28,
        _WeekCard(sessions: weekSessions, applied: appliedWeek, week: week),
      ],
    );
  }
}

class _TodayCard extends ConsumerWidget {
  const _TodayCard({required this.minutes, required this.applied});

  final int minutes;
  final int applied;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final target = ref.watch(dailyTargetsProvider).studyMinutes;
    final focus = ref.watch(learningFocusProvider);
    final date = ref.watch(currentDayProvider);
    final ratio = (minutes / target).clamp(0.0, 1.0);
    final remaining = target - minutes;
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Pill(
                label: l.commonToday.toUpperCase(),
                foreground: AppColors.learning,
                background: AppColors.learningSoft,
                dense: true,
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(
                  Fmt.weekdayMonthDay(date),
                  style: AppTypography.caption,
                ),
              ),
              const Icon(Symbols.menu_book, color: AppColors.learning),
            ],
          ),
          AppSpacing.gap16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(l.learnStudyToday, style: AppTypography.cardTitle),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$minutes',
                      style: AppTypography.display
                          .copyWith(fontSize: 30)
                          .tabular,
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
          AppSpacing.gap8,
          AppProgressBar(value: ratio, color: AppColors.learning),
          AppSpacing.gap8,
          Row(
            children: [
              Expanded(
                child: Text(
                  l.healthPctCompleted(Fmt.percent(ratio)),
                  style: AppTypography.caption,
                ),
              ),
              Text(
                remaining > 0
                    ? l.healthMinRemaining(remaining)
                    : l.healthTargetMet,
                style: AppTypography.caption,
              ),
            ],
          ),
          AppSpacing.gap16,
          EvenRow(
            children: [
              StatTile(
                label: l.learnSkill,
                value: focus?.skill ?? '—',
                color: AppColors.surfaceMuted,
              ),
              StatTile(
                label: l.learnSession,
                value: minutes > 0
                    ? l.learnSessionDone(Fmt.minutes(minutes))
                    : l.healthNotYet,
                color: AppColors.surfaceMuted,
              ),
              StatTile(
                label: l.learnApplied,
                value: l.learnActions(applied),
                color: AppColors.surfaceMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FocusCard extends ConsumerWidget {
  const _FocusCard({required this.weekSessions});

  final List<LearningSession> weekSessions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final focus = ref.watch(learningFocusProvider);
    final today = ref.watch(currentDayProvider);
    if (focus == null) {
      return EmptyState(
        icon: Symbols.school,
        title: l.learnNoFocusTitle,
        message: l.learnNoFocusBody,
        actionLabel: l.learnSetFocus,
        onAction: () => showFocusSheet(context),
      );
    }
    final elapsed = daysBetween(focus.startedOn, today);
    final weekNo = (elapsed ~/ 7 + 1).clamp(1, focus.weeks);
    final weekRatio = weekNo / focus.weeks;
    final weekDays = PeriodRange.trailing(today, 7).dayKeys;
    final studied = {for (final s in weekSessions) dayKeyOf(s.occurredAt)};
    final cadence = weekDays.where(studied.contains).length / 7;
    return AppCard(
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
                    Text(focus.skill, style: AppTypography.sectionTitle),
                    if (focus.description != null) ...[
                      const SizedBox(height: 2),
                      Text(focus.description!, style: AppTypography.caption),
                    ],
                  ],
                ),
              ),
              CircleIconButton(
                icon: Symbols.edit,
                tooltip: l.learnEditFocus,
                background: AppColors.learningSoft,
                foreground: AppColors.learning,
                size: 40,
                iconSize: 18,
                onPressed: () => showFocusSheet(context),
              ),
            ],
          ),
          AppSpacing.gap16,
          Row(
            children: [
              Expanded(
                child: Text(
                  l.learnWeekOf(weekNo, focus.weeks),
                  style: AppTypography.caption,
                ),
              ),
              Text(
                l.learnCadence(Fmt.percent(cadence)),
                style: AppTypography.caption,
              ),
            ],
          ),
          AppSpacing.gap8,
          AppProgressBar(value: weekRatio, color: AppColors.learning),
          if (focus.nextStep != null) ...[
            AppSpacing.gap12,
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                children: [
                  const Icon(
                    Symbols.arrow_forward,
                    size: 16,
                    color: AppColors.learning,
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: Text(
                      l.learnNext(focus.nextStep!),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          AppSpacing.gap16,
          PrimaryButton(
            key: const Key('learn-continue'),
            label: l.learnContinue,
            leadingIcon: Symbols.play_arrow,
            onPressed: () => showStudySheet(context, topic: focus.nextStep),
          ),
        ],
      ),
    );
  }
}

class _ApplySection extends ConsumerWidget {
  const _ApplySection({required this.actions});

  final List<Task> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final todayKey = dayKeyOf(today);
    final day = PeriodRange.day(today);
    // Open actions plus anything finished today; older completions drop off.
    final visible =
        actions
            .where((t) => t.completedAt == null || day.contains(t.completedAt!))
            .toList()
          ..sort((a, b) => a.dayKey.compareTo(b.dayKey));
    final done = visible.where((t) => t.completedAt != null).length;
    String meta(Task t) {
      final when = t.completedAt != null
          ? l.learnCompletedToday
          : t.dayKey == todayKey
          ? l.commonToday
          : t.dayKey == dayKeyOf(addDays(today, 1))
          ? l.commonTomorrow
          : t.dayKey.compareTo(todayKey) < 0
          ? Fmt.monthDay(dateOfKey(t.dayKey))
          : l.learnUpcoming;
      return [?t.badge, when].join(' · ');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.learnApplyTitle,
          subtitle: l.learnApplyHint,
          badge: visible.isEmpty
              ? null
              : Pill(
                  label: l.learnApplyCount(done, visible.length),
                  foreground: AppColors.learning,
                  background: AppColors.learningSoft,
                  dense: true,
                ),
        ),
        if (visible.isEmpty)
          AppCard(
            onTap: () => showTaskSheet(context, area: LifeArea.learning),
            child: Row(
              children: [
                const IconTile(
                  icon: Symbols.bolt,
                  color: AppColors.learning,
                  background: AppColors.learningSoft,
                ),
                AppSpacing.gap12,
                Expanded(
                  child: Text(l.learnApplyEmpty, style: AppTypography.caption),
                ),
              ],
            ),
          )
        else
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              children: [
                for (final t in visible.take(5))
                  TaskRow(
                    title: t.title,
                    subtitle: meta(t),
                    done: t.completedAt != null,
                    onToggle: () => ref
                        .read(tasksRepositoryProvider)
                        .setDone(t, t.completedAt == null),
                    onTap: () => showTaskOptions(context, ref, t),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SessionsCard extends ConsumerWidget {
  const _SessionsCard({required this.sessions});

  final List<LearningSession> sessions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final resources = {
      for (final r
          in ref.watch(learningResourcesProvider).value ??
              const <LearningResource>[])
        r.id: r,
    };
    if (sessions.isEmpty) {
      return AppCard(
        onTap: () => showStudySheet(context),
        child: Row(
          children: [
            const IconTile(
              icon: Symbols.menu_book,
              color: AppColors.learning,
              background: AppColors.learningSoft,
            ),
            AppSpacing.gap12,
            Expanded(
              child: Text(l.learnNoSessions, style: AppTypography.caption),
            ),
          ],
        ),
      );
    }
    final sorted = [...sessions]
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        children: [
          for (final s in sorted.take(5))
            ActivityRow(
              icon: s.resourceId != null && resources[s.resourceId] != null
                  ? resourceIcon(resources[s.resourceId]!.kind)
                  : Symbols.notes,
              color: AppColors.learning,
              background: AppColors.learningSoft,
              title: s.topic,
              subtitle: [
                whenLabel(context, s.occurredAt, use24h: use24h),
                if (resources[s.resourceId] != null)
                  resources[s.resourceId]!.title
                else
                  ?s.skill,
              ].join(' · '),
              trailing: Fmt.minutes(s.minutes),
            ),
        ],
      ),
    );
  }
}

class _ResourcesSection extends ConsumerWidget {
  const _ResourcesSection();

  Future<void> _manage(
    BuildContext context,
    WidgetRef ref,
    LearningResource r,
  ) async {
    final l = context.l10n;
    final action = await showOptionSheet<String>(
      context,
      title: r.title,
      options: [
        SheetOption(value: 'progress', label: l.learnUpdateProgress),
        SheetOption(value: 'archive', label: l.learnArchiveResource),
      ],
    );
    if (!context.mounted || action == null) return;
    final repo = ref.read(learningRepositoryProvider);
    if (action == 'progress') {
      final value = await showNumberSheet(
        context,
        title: l.learnUpdateProgress,
        initial: r.completedUnits.toDouble(),
        suffix: resourceUnit(context, r.kind),
        allowZero: true,
      );
      if (value != null) await repo.setResourceProgress(r, value.round());
    } else {
      final ok = await showConfirmDialog(
        context,
        title: l.learnArchiveResource,
        message: l.learnArchiveBody,
        confirmLabel: l.learnArchiveResource,
        destructive: true,
      );
      if (ok) await repo.archiveResource(r);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final resources =
        ref.watch(learningResourcesProvider).value ??
        const <LearningResource>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.learnResources,
          trailingText: resources.isEmpty
              ? null
              : l.learnActiveCount(resources.length),
        ),
        if (resources.isEmpty)
          AppCard(child: Text(l.learnNoResources, style: AppTypography.caption))
        else
          for (final r in resources) ...[
            AppCard(
              onTap: () => _manage(context, ref, r),
              child: Row(
                children: [
                  IconTile(
                    icon: resourceIcon(r.kind),
                    color: AppColors.learning,
                    background: AppColors.learningSoft,
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                r.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.bodyMedium,
                              ),
                            ),
                            Text(
                              Fmt.percent(r.completedUnits / r.totalUnits),
                              style: AppTypography.label.copyWith(
                                color: AppColors.learning,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.gap8,
                        AppProgressBar(
                          value: r.completedUnits / r.totalUnits,
                          color: AppColors.learning,
                          height: 4,
                        ),
                        AppSpacing.gap4,
                        Text(
                          l.learnUnitsOf(
                            r.completedUnits,
                            r.totalUnits,
                            resourceUnit(context, r.kind),
                          ),
                          style: AppTypography.captionSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gap8,
          ],
        AppSpacing.gap4,
        AddRowButton(
          label: l.learnAddResource,
          color: AppColors.learning,
          onTap: () => showResourceSheet(context),
        ),
      ],
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({
    required this.sessions,
    required this.applied,
    required this.week,
  });

  final List<LearningSession> sessions;
  final int applied;
  final PeriodRange week;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final minutes = sessions.fold<int>(0, (s, x) => s + x.minutes);
    final days = {for (final s in sessions) dayKeyOf(s.occurredAt)}.length;
    Widget stat(String label, String value) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.captionSmall),
          Text(value, style: AppTypography.cardTitle.tabular),
        ],
      ),
    );
    return AppCard(
      color: AppColors.learningSoft,
      borderColor: null,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l.learnThisWeek, style: AppTypography.cardTitle),
              ),
              const Icon(Symbols.insights, color: AppColors.learning),
            ],
          ),
          AppSpacing.gap16,
          Row(
            children: [
              stat(l.learnStudyTime, Fmt.minutes(minutes)),
              stat(l.learnSessionsCount, '${sessions.length}'),
              stat(l.learnAppliedCount, '$applied'),
            ],
          ),
          AppSpacing.gap16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Symbols.verified, size: 16, color: AppColors.learning),
              AppSpacing.gap8,
              Expanded(
                child: Text(
                  '${l.learnDaysStudied(days)} ${l.learnDaysNote}',
                  style: AppTypography.caption,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LearningTargetsSheet extends ConsumerStatefulWidget {
  const _LearningTargetsSheet();

  @override
  ConsumerState<_LearningTargetsSheet> createState() =>
      _LearningTargetsSheetState();
}

class _LearningTargetsSheetState extends ConsumerState<_LearningTargetsSheet> {
  late double _study = ref.read(dailyTargetsProvider).studyMinutes.toDouble();

  Future<void> _save() async {
    await ref
        .read(settingsStoreProvider)
        .setInt(SettingKeys.studyMinutes, _study.round());
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
          FieldLabel(label: l.learnTargetStudy),
          AppSpacing.gap8,
          NumberStepper(
            value: _study,
            step: 5,
            min: 5,
            max: 480,
            format: (v) => Fmt.minutes(v.round()),
            onChanged: (v) => setState(() => _study = v),
          ),
        ],
      ),
    );
  }
}
