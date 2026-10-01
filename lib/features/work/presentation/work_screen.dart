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
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/module_scaffold.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/segmented.dart';
import '../../../core/widgets/states.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../settings/data/preferences.dart';
import '../../settings/data/settings_store.dart';
import '../data/work_repository.dart';
import '../domain/work_stats.dart';
import 'work_log_form.dart';

final _workYearProvider = Provider<AsyncValue<List<WorkActivity>>>((ref) {
  final today = ref.watch(currentDayProvider);
  // Includes the coming month so scheduled meetings and follow-ups show up.
  final range = PeriodRange.trailing(addDays(today, 31), 396);
  return ref.watch(workInRangeProvider(range));
});

String workStageLabel(BuildContext context, WorkKind stage) {
  final l = context.l10n;
  return switch (stage) {
    WorkKind.lead => l.workStageLead,
    WorkKind.followUp => l.workStageFollowUp,
    WorkKind.meeting => l.workStageMeeting,
    WorkKind.proposal => l.workStageProposal,
    _ => workKindLabel(context, stage),
  };
}

class WorkScreen extends ConsumerWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final items = ref.watch(_workYearProvider);
    final today = ref.watch(currentDayProvider);
    final target = ref.watch(dailyTargetsProvider).deepWorkMinutes;
    final achieved =
        WorkStats.totals(
          items.value ?? const [],
          PeriodRange.day(today),
        ).deepMinutes >=
        target;
    return ModuleScaffold(
      title: l.workScreenTitle,
      subtitle: l.workScreenSubtitle,
      badge: achieved
          ? Pill(
              label: l.workTargetAchieved,
              dot: true,
              foreground: AppColors.primaryStrong,
              background: AppColors.brandSoft,
            )
          : null,
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
            builder: (_) => const _WorkTargetsSheet(),
          ),
        ),
      ],
      children: [
        AsyncView<List<WorkActivity>>(
          value: items,
          builder: (list) => _WorkBody(items: list, achieved: achieved),
        ),
      ],
    );
  }
}

class _WorkBody extends ConsumerWidget {
  const _WorkBody({required this.items, required this.achieved});

  final List<WorkActivity> items;
  final bool achieved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final day = PeriodRange.day(today);
    final week = WorkStats.totals(
      items,
      PeriodRange.week(today, weekStart: weekStart),
    );
    final insight = week.isEmpty
        ? null
        : week.meetings > 0 && week.followUps >= week.leads
        ? l.workInsightFollowUps
        : week.leads > 0
        ? l.workInsightLeads
        : week.deepMinutes > 0
        ? l.workInsightDeep
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (achieved) ...[
          InfoBanner(message: l.workTargetBanner),
          AppSpacing.gap16,
        ],
        _MomentumCard(
          today: WorkStats.totals(items, day),
          planned: WorkStats.plannedMeetings(items, now),
        ),
        AppSpacing.gap28,
        OverlineLabel(l.workQuickActions),
        AppSpacing.gap12,
        EvenRow(
          children: [
            QuickActionButton(
              icon: Symbols.target,
              label: l.workLogDeep,
              color: AppColors.work,
              onTap: () => showWorkLogSheet(context),
            ),
            QuickActionButton(
              icon: Symbols.person_add,
              label: l.workAddLead,
              color: AppColors.work,
              onTap: () => showWorkLogSheet(context, kind: WorkKind.lead),
            ),
          ],
        ),
        AppSpacing.gap8,
        EvenRow(
          children: [
            QuickActionButton(
              icon: Symbols.forward_to_inbox,
              label: l.workAddFollowUp,
              color: AppColors.work,
              onTap: () => showWorkLogSheet(context, kind: WorkKind.followUp),
            ),
            QuickActionButton(
              icon: Symbols.groups,
              label: l.workAddMeeting,
              color: AppColors.work,
              onTap: () => showWorkLogSheet(context, kind: WorkKind.meeting),
            ),
          ],
        ),
        AppSpacing.gap28,
        _FocusSection(sessions: WorkStats.deepWorkOn(items, day)),
        AppSpacing.gap28,
        _SalesSection(items: items),
        AppSpacing.gap28,
        _LeadsSection(leads: WorkStats.pipeline(items, now)),
        AppSpacing.gap28,
        _MeetingsSection(meetings: WorkStats.upcomingMeetings(items, now)),
        AppSpacing.gap28,
        SectionHeader(title: l.workBusinessGoals),
        const AreaGoalsSection(area: LifeArea.work),
        if (insight != null) ...[
          AppSpacing.gap20,
          InsightCard(
            title: l.workInsightTitle,
            message: insight,
            color: AppColors.work,
            background: AppColors.workSoft,
          ),
        ],
      ],
    );
  }
}

class _MomentumCard extends ConsumerWidget {
  const _MomentumCard({required this.today, required this.planned});

  final WorkTotals today;
  final int planned;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final targets = ref.watch(dailyTargetsProvider);
    final date = ref.watch(currentDayProvider);
    final deepRatio = today.deepMinutes / targets.deepWorkMinutes;
    String pct(int done, int target) =>
        target <= 0 ? '' : Fmt.percent(done / target);
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: OverlineLabel(
                  l.workMomentum,
                  color: AppColors.primaryStrong,
                ),
              ),
              Pill(
                label: Fmt.monthDay(date),
                icon: Symbols.calendar_today,
                foreground: AppColors.textBody,
                background: AppColors.surfaceMuted,
                dense: true,
              ),
            ],
          ),
          AppSpacing.gap12,
          Row(
            children: [
              Expanded(
                child: Text(l.workDeepFocus, style: AppTypography.caption),
              ),
              Text(
                Fmt.percent(deepRatio),
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryStrong,
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: Fmt.minutes(today.deepMinutes),
                  style: AppTypography.display.copyWith(fontSize: 30),
                ),
                TextSpan(
                  text: ' / ${Fmt.minutes(targets.deepWorkMinutes)}',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
          AppSpacing.gap8,
          AppProgressBar(value: deepRatio.clamp(0.0, 1.0)),
          AppSpacing.gap16,
          EvenRow(
            children: [
              StatTile(
                label: l.workLeads,
                value: '${today.leads} / ${targets.leads}',
                caption: pct(today.leads, targets.leads),
                captionColor: AppColors.primaryStrong,
                color: AppColors.surfaceMuted,
              ),
              StatTile(
                label: l.workFollowUps,
                value: '${today.followUps} / ${targets.followUps}',
                caption: pct(today.followUps, targets.followUps),
                captionColor: AppColors.primaryStrong,
                color: AppColors.surfaceMuted,
              ),
              StatTile(
                label: l.workMeetings,
                value: '${today.meetings}',
                caption: l.workPlanned(planned),
                color: AppColors.surfaceMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FocusSection extends ConsumerWidget {
  const _FocusSection({required this.sessions});

  final List<WorkActivity> sessions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final total = sessions.fold<int>(0, (s, a) => s + (a.minutes ?? 0));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.workFocus,
          badge: total > 0
              ? Pill(
                  label: l.workLogged(Fmt.minutes(total)),
                  foreground: AppColors.textBody,
                  background: AppColors.surfaceMuted,
                  dense: true,
                )
              : null,
          trailingText: l.workAllLogs,
          onTrailingTap: () => context.push(AppRoutes.activity),
        ),
        if (sessions.isEmpty)
          AppCard(
            onTap: () => showWorkLogSheet(context),
            child: Row(
              children: [
                const IconTile(
                  icon: Symbols.target,
                  color: AppColors.work,
                  background: AppColors.workSoft,
                ),
                AppSpacing.gap12,
                Expanded(
                  child: Text(l.workNoFocus, style: AppTypography.caption),
                ),
              ],
            ),
          )
        else
          for (final s in sessions) ...[
            _SessionCard(session: s, use24h: use24h),
            AppSpacing.gap8,
          ],
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session, required this.use24h});

  final WorkActivity session;
  final bool use24h;

  @override
  Widget build(BuildContext context) {
    final minutes = session.minutes ?? 0;
    final end = WorkStats.momentOf(session);
    final start = end.subtract(Duration(minutes: minutes));
    final range =
        '${Fmt.time(start, use24h: use24h)}–${Fmt.time(end, use24h: use24h)}';
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.workSoft,
              borderRadius: AppRadius.mdAll,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Symbols.target, size: 18, color: AppColors.work),
                Text(
                  Fmt.minutes(minutes),
                  style: AppTypography.captionSmall.copyWith(
                    color: AppColors.work,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.gap12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        session.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodyMedium,
                      ),
                    ),
                    AppSpacing.gap8,
                    Text(range, style: AppTypography.captionSmall.tabular),
                  ],
                ),
                if (session.detail != null || session.counterpart != null)
                  Text(
                    [?session.counterpart, ?session.detail].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption,
                  ),
              ],
            ),
          ),
          const Icon(Symbols.check_circle, color: AppColors.success, fill: 1),
        ],
      ),
    );
  }
}

class _SalesSection extends ConsumerStatefulWidget {
  const _SalesSection({required this.items});

  final List<WorkActivity> items;

  @override
  ConsumerState<_SalesSection> createState() => _SalesSectionState();
}

class _SalesSectionState extends ConsumerState<_SalesSection> {
  PeriodKind _period = PeriodKind.week;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final range = PeriodRange.of(_period, today, weekStart: weekStart);
    final t = WorkStats.totals(widget.items, range);
    final stats = [
      (l.workLeads, t.leads, l.workOutreach),
      (l.workFollowUps, t.followUps, l.workCadence),
      (l.workMeetings, t.meetings, l.workBooked),
      (l.workProposals, t.proposals, l.workSent),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.workSales,
          trailing: SizedBox(
            width: 180,
            child: SegmentedPills<PeriodKind>(
              values: const [PeriodKind.week, PeriodKind.month],
              selected: _period,
              compact: true,
              labelOf: (k) =>
                  k == PeriodKind.week ? l.commonThisWeek : l.commonThisMonth,
              onChanged: (k) => setState(() => _period = k),
            ),
          ),
        ),
        AppCard(
          child: Column(
            children: [
              Row(
                children: [
                  for (final (label, value, caption) in stats)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '$value',
                            style: AppTypography.headline
                                .copyWith(
                                  color: label == l.workProposals && value > 0
                                      ? AppColors.primaryStrong
                                      : null,
                                )
                                .tabular,
                          ),
                          Text(label, style: AppTypography.caption),
                          Text(caption, style: AppTypography.captionSmall),
                        ],
                      ),
                    ),
                ],
              ),
              if (t.wins > 0) ...[
                AppSpacing.gap16,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.brandSoft,
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Symbols.handshake,
                        size: 16,
                        color: AppColors.primaryStrong,
                      ),
                      AppSpacing.gap8,
                      Expanded(
                        child: Text(
                          _period == PeriodKind.week
                              ? l.workWonWeek(l.workWon(t.wins))
                              : l.workWonMonth(l.workWon(t.wins)),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textBody,
                          ),
                        ),
                      ),
                      if (t.wonValueMinor > 0)
                        Text(
                          Fmt.money(t.wonValueMinor, currency, signed: true),
                          style: AppTypography.label.tabular,
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

class _LeadsSection extends ConsumerStatefulWidget {
  const _LeadsSection({required this.leads});

  final List<PipelineLead> leads;

  @override
  ConsumerState<_LeadsSection> createState() => _LeadsSectionState();
}

class _LeadsSectionState extends ConsumerState<_LeadsSection> {
  static const _collapsed = 3;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final leads = widget.leads;
    final visible = _expanded ? leads : leads.take(_collapsed).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.workActiveLeads,
          badge: leads.isEmpty
              ? null
              : Pill(
                  label: '${leads.length}',
                  foreground: AppColors.textBody,
                  background: AppColors.surfaceMuted,
                  dense: true,
                ),
          trailingText: leads.length > _collapsed
              ? (_expanded ? l.commonShowLess : l.commonViewAll)
              : null,
          onTrailingTap: leads.length > _collapsed
              ? () => setState(() => _expanded = !_expanded)
              : null,
        ),
        if (leads.isEmpty)
          AppCard(child: Text(l.workNoLeads, style: AppTypography.caption))
        else
          for (final lead in visible) ...[
            _LeadCard(lead: lead),
            AppSpacing.gap8,
          ],
      ],
    );
  }
}

class _LeadCard extends ConsumerWidget {
  const _LeadCard({required this.lead});

  final PipelineLead lead;

  String _next(BuildContext context, bool use24h) {
    final l = context.l10n;
    final next = lead.next;
    if (next == null) return l.workNextNone;
    final at = next.scheduledAt!.toLocal();
    final kind = workKindLabel(context, next.kind);
    final when = daysBetween(DateTime.now(), at) == 0
        ? '${l.commonToday.toLowerCase()} · ${Fmt.time(at, use24h: use24h)}'
        : '${Fmt.monthDay(at)} · ${Fmt.time(at, use24h: use24h)}';
    return l.workNext('$kind $when');
  }

  Future<void> _actions(BuildContext context) async {
    final l = context.l10n;
    final kind = await showOptionSheet<WorkKind>(
      context,
      title: lead.name,
      options: [
        SheetOption(value: WorkKind.followUp, label: l.workAddFollowUp),
        SheetOption(value: WorkKind.meeting, label: l.workAddMeeting),
        SheetOption(value: WorkKind.proposal, label: l.workProposal),
        SheetOption(value: WorkKind.clientWon, label: l.workMarkWon),
      ],
    );
    if (kind == null || !context.mounted) return;
    await showWorkLogSheet(
      context,
      kind: kind,
      title: lead.title,
      counterpart: lead.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final tone = switch (lead.stage) {
      WorkKind.proposal => StatusTone.brand,
      WorkKind.meeting => StatusTone.info,
      _ => StatusTone.neutral,
    };
    return AppCard(
      onTap: () => _actions(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  lead.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
              ),
              StatusChip(
                label: workStageLabel(context, lead.stage),
                tone: tone,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(lead.title, style: AppTypography.caption),
          AppSpacing.gap12,
          Row(
            children: [
              Icon(
                Symbols.arrow_forward,
                size: 14,
                color: lead.next == null
                    ? AppColors.textMuted
                    : AppColors.primaryStrong,
              ),
              AppSpacing.gap4,
              Expanded(
                child: Text(
                  _next(context, use24h),
                  style: AppTypography.captionSmall.copyWith(
                    color: lead.next == null
                        ? AppColors.textSecondary
                        : AppColors.primaryStrong,
                  ),
                ),
              ),
              if (lead.valueMinor != null)
                Text(
                  Fmt.money(lead.valueMinor!, currency, compact: true),
                  style: AppTypography.captionSmall.tabular,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MeetingsSection extends ConsumerWidget {
  const _MeetingsSection({required this.meetings});

  final List<WorkActivity> meetings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.workNextMeetings,
          trailingText: meetings.isEmpty
              ? null
              : l.workUpcoming(meetings.length),
        ),
        if (meetings.isEmpty)
          AppCard(child: Text(l.workNoMeetings, style: AppTypography.caption))
        else
          for (final m in meetings.take(3)) ...[
            _MeetingRow(meeting: m, use24h: use24h),
            AppSpacing.gap8,
          ],
      ],
    );
  }
}

class _MeetingRow extends StatelessWidget {
  const _MeetingRow({required this.meeting, required this.use24h});

  final WorkActivity meeting;
  final bool use24h;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final at = meeting.scheduledAt!.toLocal();
    final isToday = daysBetween(DateTime.now(), at) == 0;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 52,
            decoration: BoxDecoration(
              color: isToday ? AppColors.brandSoft : AppColors.surfaceMuted,
              borderRadius: AppRadius.mdAll,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (isToday ? l.commonToday : Fmt.weekdayShort(at))
                      .toUpperCase(),
                  style: AppTypography.captionSmall.copyWith(
                    fontSize: 9,
                    color: isToday
                        ? AppColors.primaryStrong
                        : AppColors.textSecondary,
                  ),
                ),
                Text('${at.day}', style: AppTypography.cardTitle.tabular),
              ],
            ),
          ),
          AppSpacing.gap12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meeting.counterpart ?? meeting.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  [
                    if (meeting.counterpart != null) meeting.title,
                    Fmt.time(at, use24h: use24h),
                    if (meeting.minutes != null) Fmt.minutes(meeting.minutes!),
                  ].join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          const Icon(Symbols.groups, color: AppColors.work),
        ],
      ),
    );
  }
}

class _WorkTargetsSheet extends ConsumerStatefulWidget {
  const _WorkTargetsSheet();

  @override
  ConsumerState<_WorkTargetsSheet> createState() => _WorkTargetsSheetState();
}

class _WorkTargetsSheetState extends ConsumerState<_WorkTargetsSheet> {
  late final DailyTargets _initial = ref.read(dailyTargetsProvider);
  late double _deep = _initial.deepWorkMinutes.toDouble();
  late double _leads = _initial.leads.toDouble();
  late double _follow = _initial.followUps.toDouble();

  Future<void> _save() async {
    final store = ref.read(settingsStoreProvider);
    await store.setInt(SettingKeys.deepWorkMinutes, _deep.round());
    await store.setInt(SettingKeys.leadsPerDay, _leads.round());
    await store.setInt(SettingKeys.followUpsPerDay, _follow.round());
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
          FieldLabel(label: l.workTargetDeep),
          AppSpacing.gap8,
          NumberStepper(
            value: _deep,
            step: 15,
            min: 15,
            max: 600,
            format: (v) => Fmt.minutes(v.round()),
            onChanged: (v) => setState(() => _deep = v),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.workTargetLeads),
          AppSpacing.gap8,
          NumberStepper(
            value: _leads,
            min: 1,
            max: 50,
            onChanged: (v) => setState(() => _leads = v),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.workTargetFollowUps),
          AppSpacing.gap8,
          NumberStepper(
            value: _follow,
            min: 1,
            max: 50,
            onChanged: (v) => setState(() => _follow = v),
          ),
        ],
      ),
    );
  }
}
