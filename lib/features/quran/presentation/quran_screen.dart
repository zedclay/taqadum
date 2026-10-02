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
import '../../../core/widgets/module_scaffold.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../settings/data/preferences.dart';
import '../../settings/data/settings_store.dart';
import '../data/quran_repository.dart';
import '../domain/quran_stats.dart';
import '../domain/surahs.dart';
import 'quran_log_form.dart';

final _quranYearProvider = Provider<AsyncValue<List<QuranLog>>>((ref) {
  final today = ref.watch(currentDayProvider);
  return ref.watch(quranLogsInRangeProvider(PeriodRange.trailing(today, 365)));
});

IconData quranKindIcon(QuranKind kind) => switch (kind) {
  QuranKind.reading => Symbols.menu_book,
  QuranKind.memorization => Symbols.psychology,
  QuranKind.revision => Symbols.replay,
};

class QuranScreen extends ConsumerWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final logs = ref.watch(_quranYearProvider);
    return ModuleScaffold(
      title: l.quranTitle,
      subtitle: l.quranSubtitle,
      actions: [
        CircleIconButton(
          icon: Symbols.calendar_month,
          tooltip: l.commonHistory,
          background: Colors.transparent,
          onPressed: () => context.push(AppRoutes.activity),
        ),
        PopupMenuButton<String>(
          tooltip: l.commonMore,
          icon: const Icon(Symbols.more_vert),
          onSelected: (_) => showAppSheet<void>(
            context,
            builder: (_) => const _QuranTargetsSheet(),
          ),
          itemBuilder: (_) => [
            PopupMenuItem(value: 'targets', child: Text(l.commonTargets)),
          ],
        ),
      ],
      children: [
        AsyncView<List<QuranLog>>(
          value: logs,
          builder: (list) => _QuranBody(logs: list),
        ),
      ],
    );
  }
}

class _QuranBody extends ConsumerWidget {
  const _QuranBody({required this.logs});

  final List<QuranLog> logs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final todayLogs = logs.where(
      (q) => PeriodRange.day(today).contains(q.occurredAt),
    );
    final week = PeriodRange.week(today, weekStart: weekStart);
    final weekTotals = QuranStats.totals(
      logs.where((q) => week.contains(q.occurredAt)),
    );
    final memo = QuranStats.currentMemorization(logs);
    final revisions = QuranStats.revisionSchedule(logs, now);
    final goals =
        (ref.watch(goalViewsProvider).value ?? const <GoalView>[])
            .where(
              (v) =>
                  v.goal.area == LifeArea.quran &&
                  v.goal.status == GoalStatus.active,
            )
            .toList()
          ..sort(
            (a, b) =>
                (b.goal.isPrimary ? 1 : 0).compareTo(a.goal.isPrimary ? 1 : 0),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RoutineCard(totals: QuranStats.totals(todayLogs)),
        AppSpacing.gap20,
        if (memo != null)
          _MemorizationCard(memo: memo)
        else
          EmptyState(
            icon: Symbols.psychology,
            title: l.quranNoMemoTitle,
            message: l.quranNoMemoBody,
            actionLabel: l.quranStartMemo,
            onAction: () =>
                showQuranLogSheet(context, kind: QuranKind.memorization),
          ),
        AppSpacing.gap12,
        if (goals.isNotEmpty)
          GoalMiniCard(view: goals.first, overline: l.quranGoal)
        else
          const AreaGoalsSection(area: LifeArea.quran),
        AppSpacing.gap28,
        SectionHeader(
          title: l.quranRevisionTitle,
          trailingText: l.quranActiveSchedule,
        ),
        _RevisionCard(items: revisions.take(4).toList()),
        AppSpacing.gap20,
        _ConsistencyCard(logs: logs),
        AppSpacing.gap28,
        SectionHeader(title: l.quranThisWeek),
        EvenRow(
          children: [
            _WeekStat(
              label: l.quranRead,
              value: QuranRepository.pagesLabel(weekTotals.readPages),
              unit: l.quranUnitPages,
            ),
            _WeekStat(
              label: l.quranMemorized,
              value: QuranRepository.pagesLabel(weekTotals.memorizedPages),
              unit: l.quranUnitPages,
            ),
            _WeekStat(
              label: l.quranRevised,
              value: '${weekTotals.revisionMinutes}',
              unit: l.quranUnitMinutes,
            ),
          ],
        ),
        AppSpacing.gap28,
        SectionHeader(title: l.quranRecent),
        _RecentCard(logs: logs),
      ],
    );
  }
}

class _RoutineCard extends ConsumerWidget {
  const _RoutineCard({required this.totals});

  final QuranTotals totals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final targets = ref.watch(dailyTargetsProvider);
    final rows = [
      (
        QuranKind.reading,
        l.quranReading,
        l.quranPagesOf(
          QuranRepository.pagesLabel(totals.readPages),
          '${targets.quranPages}',
        ),
        totals.readPages / targets.quranPages,
      ),
      (
        QuranKind.memorization,
        l.quranMemorization,
        l.quranPageOf(
          QuranRepository.pagesLabel(totals.memorizedPages),
          QuranRepository.pagesLabel(targets.memorizationPages),
        ),
        totals.memorizedPages / targets.memorizationPages,
      ),
      (
        QuranKind.revision,
        l.quranRevision,
        l.quranMinutesOf(
          '${totals.revisionMinutes}',
          '${targets.revisionMinutes}',
        ),
        totals.revisionMinutes / targets.revisionMinutes,
      ),
    ];
    final done = rows.where((r) => r.$4 >= 1).length;
    return AppCard.hero(
      color: AppColors.surfaceMuted,
      borderColor: null,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverlineLabel(l.quranDailyRoutine),
                    const SizedBox(height: 2),
                    Text(l.commonToday, style: AppTypography.headline),
                  ],
                ),
              ),
              Pill(
                label: l.quranRoutineDone(done, rows.length),
                dot: true,
                foreground: done == rows.length
                    ? AppColors.primaryStrong
                    : AppColors.textBody,
                background: AppColors.surface,
              ),
            ],
          ),
          AppSpacing.gap16,
          for (final r in rows) ...[
            Material(
              color: AppColors.surface,
              borderRadius: AppRadius.mdAll,
              child: InkWell(
                key: Key('quran-routine-${r.$1.name}'),
                borderRadius: AppRadius.mdAll,
                onTap: () => showQuranLogSheet(context, kind: r.$1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 16, 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleCheck(
                            checked: r.$4 >= 1,
                            color: AppColors.primaryStrong,
                          ),
                          AppSpacing.gap12,
                          Expanded(
                            child: Text(r.$2, style: AppTypography.bodyMedium),
                          ),
                          Text(r.$3, style: AppTypography.caption.tabular),
                        ],
                      ),
                      AppSpacing.gap8,
                      AppProgressBar(value: r.$4.clamp(0.0, 1.0), height: 4),
                    ],
                  ),
                ),
              ),
            ),
            AppSpacing.gap8,
          ],
          AppSpacing.gap4,
          SecondaryButton(
            key: const Key('quran-log-progress'),
            label: l.quranLogProgress,
            leadingIcon: Symbols.add,
            foreground: AppColors.primaryStrong,
            onPressed: () => showQuranLogSheet(context),
          ),
        ],
      ),
    );
  }
}

class _MemorizationCard extends ConsumerWidget {
  const _MemorizationCard({required this.memo});

  final CurrentMemorization memo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final step = ref.watch(dailyTargetsProvider).memorizationPages;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: OverlineLabel(l.quranCurrentMemo)),
              Pill(
                label: l.quranSurahBadge(memo.surah),
                foreground: AppColors.textBody,
                background: AppColors.surfaceMuted,
                dense: true,
              ),
            ],
          ),
          AppSpacing.gap8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  surahName(memo.surah, arabic: context.isArabic),
                  style: AppTypography.headline,
                ),
              ),
              Text(
                l.quranPagesOfSurah(
                  QuranRepository.pagesLabel(memo.memorizedPages),
                  memo.totalPages,
                ),
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(value: memo.ratio),
          AppSpacing.gap12,
          Row(
            children: [
              const Icon(
                Symbols.flag,
                size: 16,
                color: AppColors.textSecondary,
              ),
              AppSpacing.gap4,
              Expanded(
                child: Text(
                  l.quranNextStep(QuranRepository.pagesLabel(step)),
                  style: AppTypography.caption,
                ),
              ),
              SecondaryButton(
                label: l.quranContinue,
                height: 40,
                expand: false,
                onPressed: () => showQuranLogSheet(
                  context,
                  kind: QuranKind.memorization,
                  pages: step,
                  surah: surahLabel(memo.surah),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RevisionCard extends ConsumerWidget {
  const _RevisionCard({required this.items});

  final List<RevisionItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    if (items.isEmpty) {
      return AppCard(child: Text(l.quranNoRevision, style: AppTypography.body));
    }
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (final (i, item) in items.indexed) ...[
            if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
            InkWell(
              onTap: () => showQuranLogSheet(
                context,
                kind: QuranKind.revision,
                surah: item.surah == null ? null : surahLabel(item.surah!),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizeSurahLabel(
                              item.title,
                              arabic: context.isArabic,
                            ),
                            style: AppTypography.bodyMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l.quranLastReviewed(
                              daysAgoLabel(
                                context,
                                item.lastReviewed,
                                now: ref.watch(currentDayProvider),
                              ),
                            ),
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    item.due
                        ? StatusChip(
                            label: l.quranReviewToday,
                            tone: StatusTone.brand,
                          )
                        : StatusChip(
                            label: l.quranStrong,
                            tone: StatusTone.info,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ConsistencyCard extends ConsumerWidget {
  const _ConsistencyCard({required this.logs});

  final List<QuranLog> logs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final active = QuranStats.activeDays(logs);
    final last30 = PeriodRange.trailing(
      today,
      30,
    ).dayKeys.where(active.contains).length;
    final week = PeriodRange.week(today, weekStart: weekStart);
    final todayKey = dayKeyOf(today);
    final note = switch (QuranStats.note(active, today)) {
      ConsistencyNote.start => l.quranNoteStart,
      ConsistencyNote.returned => l.quranNoteReturned,
      ConsistencyNote.streak => l.quranNoteStreak(
        QuranStats.streak(active, today),
      ),
      ConsistencyNote.steady => l.quranNoteSteady,
    };
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.quranConsistency,
                  style: AppTypography.sectionTitle,
                ),
              ),
              Text(
                l.quranConsistencyCount(last30, 30),
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(l.quranConsistencyHint, style: AppTypography.caption),
          AppSpacing.gap16,
          WeekDots(
            labels: [for (final d in week.days) Fmt.weekdayNarrow(d)],
            states: [
              for (final d in week.days)
                if (active.contains(dayKeyOf(d)))
                  DotState.done
                else if (dayKeyOf(d) == todayKey)
                  DotState.today
                else if (d.isAfter(today))
                  DotState.future
                else
                  DotState.missed,
            ],
          ),
          AppSpacing.gap16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Symbols.spa, size: 16, color: AppColors.primaryStrong),
              AppSpacing.gap8,
              Expanded(child: Text(note, style: AppTypography.caption)),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeekStat extends StatelessWidget {
  const _WeekStat({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.headline.tabular),
          Text(unit, style: AppTypography.captionSmall),
        ],
      ),
    );
  }
}

class _RecentCard extends ConsumerWidget {
  const _RecentCard({required this.logs});

  final List<QuranLog> logs;

  String _title(BuildContext context, QuranLog log) {
    final l = context.l10n;
    return switch (log.kind) {
      QuranKind.reading => l.quranReadN(
        log.pages,
        QuranRepository.pagesLabel(log.pages),
      ),
      QuranKind.memorization => l.quranMemorizedN(
        log.pages,
        QuranRepository.pagesLabel(log.pages),
      ),
      QuranKind.revision => l.quranRevisedN(log.minutes),
    };
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    QuranLog log,
  ) async {
    final l = context.l10n;
    final ok = await showConfirmDialog(
      context,
      title: l.commonDeleteEntry,
      message: l.commonDeleteEntryBody,
      confirmLabel: l.commonDelete,
      destructive: true,
    );
    if (ok) await ref.read(quranRepositoryProvider).delete(log);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final recent = [...logs]
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    if (recent.isEmpty) {
      return EmptyState(
        icon: Symbols.menu_book,
        title: l.quranEmptyTitle,
        message: l.quranEmptyBody,
        actionLabel: l.quranLogProgress,
        onAction: () => showQuranLogSheet(context),
      );
    }
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        children: [
          for (final log in recent.take(5))
            ActivityRow(
              icon: quranKindIcon(log.kind),
              color: AppColors.primaryStrong,
              background: AppColors.brandSoft,
              title: _title(context, log),
              subtitle: [
                whenLabel(
                  context,
                  log.occurredAt,
                  use24h: use24h,
                  now: ref.watch(currentDayProvider),
                ),
                if (log.surah != null)
                  localizeSurahLabel(
                    QuranStats.displayTitle(log.surah!),
                    arabic: context.isArabic,
                  ),
              ].join(' · '),
              trailing: quranKindLabel(context, log.kind),
              onTap: () => _delete(context, ref, log),
            ),
        ],
      ),
    );
  }
}

class _QuranTargetsSheet extends ConsumerStatefulWidget {
  const _QuranTargetsSheet();

  @override
  ConsumerState<_QuranTargetsSheet> createState() => _QuranTargetsSheetState();
}

class _QuranTargetsSheetState extends ConsumerState<_QuranTargetsSheet> {
  late final DailyTargets _initial = ref.read(dailyTargetsProvider);
  late double _reading = _initial.quranPages.toDouble();
  late double _memo = _initial.memorizationPages;
  late double _revision = _initial.revisionMinutes.toDouble();

  Future<void> _save() async {
    final store = ref.read(settingsStoreProvider);
    await store.setInt(SettingKeys.quranDailyPages, _reading.round());
    await store.setInt(SettingKeys.memorizationQuarters, (_memo * 4).round());
    await store.setInt(SettingKeys.revisionMinutes, _revision.round());
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
          FieldLabel(label: l.quranTargetReading),
          AppSpacing.gap8,
          NumberStepper(
            value: _reading,
            min: 1,
            max: 60,
            onChanged: (v) => setState(() => _reading = v),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.quranTargetMemo),
          AppSpacing.gap8,
          NumberStepper(
            value: _memo,
            step: 0.25,
            min: 0.25,
            max: 10,
            format: QuranRepository.pagesLabel,
            onChanged: (v) => setState(() => _memo = v),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.quranTargetRevision),
          AppSpacing.gap8,
          NumberStepper(
            value: _revision,
            step: 5,
            min: 5,
            max: 240,
            onChanged: (v) => setState(() => _revision = v),
          ),
        ],
      ),
    );
  }
}
