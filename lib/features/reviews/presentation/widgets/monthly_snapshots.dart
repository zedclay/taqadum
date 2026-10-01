import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utilities/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/area_style.dart';
import '../../../finance/data/finance_repository.dart';
import '../../../finance/domain/finance_stats.dart';
import '../../../health/data/health_repository.dart';
import '../../../learning/data/learning_repository.dart';
import '../../../quran/data/quran_repository.dart';
import '../../../quran/domain/quran_stats.dart';
import '../../../settings/data/preferences.dart';
import '../../../today/data/tasks_repository.dart';
import '../../../work/data/work_repository.dart';
import '../../../work/domain/work_stats.dart';

class _Snapshot {
  const _Snapshot({
    required this.area,
    required this.summary,
    this.stats = const [],
  });

  final LifeArea area;
  final String summary;
  final List<(String, String)> stats;
}

/// Expandable per-area summaries of what was logged in [range].
class MonthlySnapshots extends ConsumerWidget {
  const MonthlySnapshots({super.key, required this.range, required this.areas});

  final PeriodRange range;
  final List<LifeArea> areas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final elapsed = range.elapsedDays(today).length;

    _Snapshot? build(LifeArea area) {
      switch (area) {
        case LifeArea.work:
          final items = ref.watch(workInRangeProvider(range)).value;
          if (items == null) return null;
          final t = WorkStats.totals(items, range);
          if (t.isEmpty) return _Snapshot(area: area, summary: l.monthlyNoData);
          return _Snapshot(
            area: area,
            summary:
                '${l.monthlyDeepWork(Fmt.minutes(t.deepMinutes))} · ${l.monthlyClientsWon(t.wins)}',
            stats: [
              (l.monthlyLeads, '${t.leads}'),
              (l.monthlyFollowUps, '${t.followUps}'),
              (l.monthlyProposals, '${t.proposals}'),
              (
                l.monthlyRevenue,
                Fmt.money(t.wonValueMinor, currency, compact: true),
              ),
            ],
          );
        case LifeArea.finance:
          final items = ref.watch(transactionsInRangeProvider(range)).value;
          if (items == null) return null;
          final t = FinanceStats.totals(items);
          if (t.isEmpty) return _Snapshot(area: area, summary: l.monthlyNoData);
          return _Snapshot(
            area: area,
            summary: l.monthlyNet(
              Fmt.money(t.netMinor, currency, signed: true),
            ),
            stats: [
              (
                l.monthlyIncome,
                Fmt.money(t.incomeMinor, currency, compact: true),
              ),
              (
                l.monthlyExpenses,
                Fmt.money(t.expenseMinor, currency, compact: true),
              ),
              (
                l.monthlySaved,
                Fmt.money(t.savingMinor, currency, compact: true),
              ),
            ],
          );
        case LifeArea.quran:
          final logs = ref.watch(quranLogsInRangeProvider(range)).value;
          if (logs == null) return null;
          if (logs.isEmpty) {
            return _Snapshot(area: area, summary: l.monthlyNoData);
          }
          final t = QuranStats.totals(logs);
          final days = QuranStats.activeDays(logs).length;
          final revisions = logs
              .where((q) => q.kind == QuranKind.revision)
              .length;
          return _Snapshot(
            area: area,
            summary:
                '${l.monthlyPagesRead(Fmt.number(t.readPages))} · ${l.monthlyActiveDaysShort(days)}',
            stats: [
              (l.monthlyMemorized, Fmt.number(t.memorizedPages)),
              (l.monthlyRevision, '$revisions'),
              (l.monthlyActive, l.monthlyDays(days)),
            ],
          );
        case LifeArea.health:
          final workouts = ref.watch(workoutsProvider(range)).value;
          final walks = ref.watch(walksProvider(range)).value;
          final sleep = ref.watch(sleepProvider(range)).value;
          final habitLogs = ref.watch(habitLogsProvider(range)).value;
          final habits = ref.watch(habitsProvider).value;
          if (workouts == null ||
              walks == null ||
              sleep == null ||
              habitLogs == null ||
              habits == null) {
            return null;
          }
          if (workouts.isEmpty &&
              walks.isEmpty &&
              sleep.isEmpty &&
              habitLogs.isEmpty) {
            return _Snapshot(area: area, summary: l.monthlyNoData);
          }
          final avgSleep = sleep.isEmpty
              ? null
              : sleep.fold(
                      0,
                      (s, e) => s + e.wakeTime.difference(e.bedTime).inMinutes,
                    ) ~/
                    sleep.length;
          final walkDays = walks.map((w) => dayKeyOf(w.occurredAt)).toSet();
          final active = habits.where((h) => !h.archived).length;
          final habitRate = active == 0 || elapsed == 0
              ? null
              : (habitLogs.length / (active * elapsed)).clamp(0.0, 1.0);
          return _Snapshot(
            area: area,
            summary: [
              l.monthlyWorkouts(workouts.length),
              if (avgSleep != null)
                l.monthlyAvgSleepValue(Fmt.minutes(avgSleep)),
            ].join(' · '),
            stats: [
              (l.monthlyWalkDays, '${walkDays.length}'),
              (
                l.monthlyAvgSleep,
                avgSleep == null ? '—' : Fmt.minutes(avgSleep),
              ),
              (
                l.monthlyHabits,
                habitRate == null ? '—' : Fmt.percent(habitRate),
              ),
            ],
          );
        case LifeArea.learning:
          final sessions = ref.watch(learningSessionsProvider(range)).value;
          if (sessions == null) return null;
          if (sessions.isEmpty) {
            return _Snapshot(area: area, summary: l.monthlyNoData);
          }
          final minutes = sessions.fold(0, (s, e) => s + e.minutes);
          return _Snapshot(
            area: area,
            summary: l.monthlyStudy(Fmt.minutes(minutes)),
            stats: [
              (l.monthlySessions, '${sessions.length}'),
              (
                l.monthlyTakeaways,
                '${sessions.where((s) => (s.takeaway ?? '').isNotEmpty).length}',
              ),
            ],
          );
        case LifeArea.personal:
          final tasks = ref.watch(tasksInRangeProvider(range)).value;
          if (tasks == null) return null;
          final done = tasks
              .where((t) => t.area == area && t.completedAt != null)
              .length;
          if (done == 0) return _Snapshot(area: area, summary: l.monthlyNoData);
          return _Snapshot(
            area: area,
            summary: '$done ${l.monthlyPersonalTasks.toLowerCase()}',
          );
      }
    }

    final snapshots = [for (final a in areas) ?build(a)];
    return Column(
      children: [
        for (final (i, s) in snapshots.indexed) ...[
          if (i > 0) AppSpacing.gap8,
          _SnapshotTile(snapshot: s),
        ],
      ],
    );
  }
}

class _SnapshotTile extends StatefulWidget {
  const _SnapshotTile({required this.snapshot});

  final _Snapshot snapshot;

  @override
  State<_SnapshotTile> createState() => _SnapshotTileState();
}

class _SnapshotTileState extends State<_SnapshotTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.snapshot;
    final area = s.area;
    final expandable = s.stats.isNotEmpty;
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: expandable ? () => setState(() => _open = !_open) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                IconTile(
                  icon: area.icon,
                  color: area.color,
                  background: area.soft,
                  size: 36,
                  iconSize: 18,
                ),
                AppSpacing.gap12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        area.longLabel(context),
                        style: AppTypography.bodyMedium,
                      ),
                      Text(s.summary, style: AppTypography.captionSmall),
                    ],
                  ),
                ),
                if (expandable)
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: AppMotion.of(context, AppMotion.small),
                    child: const Icon(
                      Symbols.expand_more,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          AnimatedSize(
            duration: AppMotion.of(context, AppMotion.small),
            curve: AppMotion.curve,
            child: _open
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Row(
                      children: [
                        for (final (i, (label, value)) in s.stats.indexed) ...[
                          if (i > 0) AppSpacing.gap8,
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: AppRadius.mdAll,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.captionSmall,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.label.tabular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
