import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/input_sheets.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../goals/data/goals_repository.dart';
import '../../history/data/activity_repository.dart';
import '../../progress/data/progress_providers.dart';
import '../../progress/domain/progress_calculator.dart';
import '../../progress/presentation/progress_screen.dart' show weekdayName;
import '../../settings/data/preferences.dart';
import '../../today/data/daily_repository.dart';
import '../../today/data/tasks_repository.dart';
import '../data/reviews_repository.dart';
import '../domain/review_insights.dart';
import 'widgets/review_widgets.dart';

String weekRangeLabel(PeriodRange r) =>
    '${Fmt.monthDay(r.start)} – ${Fmt.monthDay(addDays(r.end, -1))}';

class WeeklyReviewScreen extends ConsumerStatefulWidget {
  const WeeklyReviewScreen({super.key});

  @override
  ConsumerState<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends ConsumerState<WeeklyReviewScreen> {
  late final PeriodRange _range;
  final _wentWellNote = TextEditingController();
  final _changeNote = TextEditingController();
  Set<String> _wentWell = {};
  Set<String> _change = {};
  String? _biggestWin;
  List<ReviewPriority> _priorities = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _range = reviewWeek(
      ref.read(currentDayProvider),
      weekStart: ref.read(preferencesProvider).weekStart,
    );
    var loaded = false;
    ref.listenManual(weeklyReviewProvider(_range.startKey), (_, next) {
      if (loaded || !next.hasValue) return;
      loaded = true;
      final r = next.value;
      if (r == null) return;
      void apply() {
        _wentWell = decodeTagSet(r.wentWellTags);
        _change = decodeTagSet(r.changeTags);
        _wentWellNote.text = r.wentWellNote ?? '';
        _changeNote.text = r.changeNote ?? '';
        _biggestWin = r.biggestWin;
        _priorities = decodePriorities(r.priorities);
      }

      if (mounted) {
        setState(apply);
      } else {
        apply();
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _wentWellNote.dispose();
    _changeNote.dispose();
    super.dispose();
  }

  Future<void> _save({required bool complete, String? derivedWin}) async {
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    setState(() => _saving = true);
    final existing = ref.read(weeklyReviewProvider(_range.startKey)).value;
    final firstCompletion = complete && existing?.completedAt == null;
    await ref
        .read(reviewsRepositoryProvider)
        .saveWeekly(
          weekStart: _range.startKey,
          wentWellTags: _wentWell.toList(),
          wentWellNote: _wentWellNote.text,
          changeTags: _change.toList(),
          changeNote: _changeNote.text,
          biggestWin: _biggestWin ?? derivedWin,
          priorities: _priorities,
          complete: complete,
          rangeLabel: weekRangeLabel(_range),
        );
    var message = complete ? l.reviewCompleted : l.reviewSaved;
    if (firstCompletion && _priorities.isNotEmpty) {
      final today = ref.read(currentDayProvider);
      final start = _range.next.start;
      final day = start.isBefore(today) ? today : start;
      final tasks = ref.read(tasksRepositoryProvider);
      for (final p in _priorities) {
        await tasks.add(
          TaskDraft(
            title: p.title,
            area: p.area,
            dayKey: dayKeyOf(day),
            goalId: p.goal,
            badge: l.weeklyFocusBadge,
          ),
        );
      }
      message = l.weeklyFocusAdded(Fmt.weekdayMonthDay(day));
    }
    if (!mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(message)));
    router.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final summary = ref.watch(periodSummaryProvider(_range));
    final review = ref.watch(weeklyReviewProvider(_range.startKey));
    final views = ref.watch(goalViewsProvider);
    final goalEvents = ref.watch(goalEventsProvider);
    final milestones = ref.watch(goalMilestonesProvider);
    final events = ref.watch(activityInRangeProvider(_range));
    final checkIns = ref.watch(checkInsInRangeProvider(_range));

    final ready = [
      summary,
      review,
      views,
      goalEvents,
      milestones,
      events,
      checkIns,
    ];
    final error = ready.where((a) => a.hasError).firstOrNull;
    final loading = ready.any((a) => !a.hasValue);

    Widget body;
    String? derivedWin;
    if (error != null) {
      body = ErrorState(
        onRetry: () => ref.invalidate(activityInRangeProvider(_range)),
      );
    } else if (loading) {
      body = const LoadingState();
    } else {
      final s = summary.requireValue;
      final movements = goalMovements(
        views: views.requireValue
            .where((v) => v.goal.status != GoalStatus.archived)
            .toList(),
        events: goalEvents.requireValue,
        milestones: milestones.requireValue,
        range: _range,
      );
      final wins = reviewWins(
        events: events.requireValue,
        movements: movements,
        summary: s,
        limit: 1,
      );
      final win = wins.firstOrNull;
      if (win != null) {
        derivedWin = switch (win.kind) {
          WinKind.consistency => l.reviewWinConsistency(
            win.area!.label(context),
            win.days!,
          ),
          _ => win.title,
        };
      }
      final gaps = reviewGaps(movements: movements, summary: s, range: _range);
      final lift = checkInLift(
        summary: s,
        checkInDays: checkIns.requireValue.map((c) => c.dayKey).toSet(),
        today: today,
      );
      body = _content(
        context,
        summary: s,
        review: review.value,
        movements: movements,
        win: win,
        gaps: gaps,
        lift: lift,
      );
    }

    final completed = review.value?.completedAt != null;
    return Scaffold(
      appBar: AppTopBar(title: l.weeklyTitle, subtitle: weekRangeLabel(_range)),
      body: body,
      bottomNavigationBar: loading || error != null
          ? null
          : ReviewFooter(
              footnote: completed ? null : l.weeklyFootnote,
              primary: PrimaryButton(
                key: const Key('weekly-complete'),
                label: completed ? l.weeklyUpdate : l.weeklyComplete,
                icon: Symbols.arrow_forward,
                loading: _saving,
                onPressed: _saving
                    ? null
                    : () => _save(complete: true, derivedWin: derivedWin),
              ),
              secondary: completed
                  ? null
                  : AppTextButton(
                      key: const Key('weekly-save-draft'),
                      label: l.reviewSaveDraft,
                      onPressed: _saving
                          ? null
                          : () =>
                                _save(complete: false, derivedWin: derivedWin),
                    ),
            ),
    );
  }

  Widget _content(
    BuildContext context, {
    required PeriodSummary summary,
    required WeeklyReview? review,
    required List<GoalMovement> movements,
    required ReviewWin? win,
    required List<ReviewGap> gaps,
    required double? lift,
  }) {
    final l = context.l10n;
    final s = summary;
    final strongest = s.strongest;
    final weakest = s.weakest;
    final moved = movements.where((m) => m.hasMoved).length;
    final delta = s.overallDelta;
    final best = s.strongestWeekdays;
    final insight = lift != null && lift >= 0.1
        ? l.weeklyInsightCheckIn(Fmt.percent(lift))
        : best.length == 2
        ? l.weeklyInsightDays(weekdayName(best[0]), weekdayName(best[1]))
        : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.sm,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Text(l.weeklyGlance, style: AppTypography.pageTitle),
        AppSpacing.gap4,
        Text(l.weeklyGlanceBody, style: AppTypography.body),
        if (review?.completedAt case final done?) ...[
          AppSpacing.gap16,
          InfoBanner(
            message: l.reviewCompletedOn(Fmt.monthDay(done.toLocal())),
          ),
        ],
        AppSpacing.gap20,
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.weeklyOverall, style: AppTypography.caption),
                        Text(
                          Fmt.percent(s.overall),
                          style: AppTypography.display,
                        ),
                      ],
                    ),
                  ),
                  if (delta != null)
                    Pill(
                      label: l.progressVsLastWeek(Fmt.signedPercent(delta)),
                      icon: delta >= 0
                          ? Symbols.trending_up
                          : Symbols.trending_down,
                      foreground: delta >= 0
                          ? AppColors.success
                          : AppColors.textSecondary,
                      background: delta >= 0
                          ? AppColors.successSoft
                          : AppColors.surfaceMuted,
                      dense: true,
                    ),
                ],
              ),
              AppSpacing.gap12,
              AppProgressBar(value: s.overall),
              AppSpacing.gap16,
              Row(
                children: [
                  Expanded(
                    child: ReviewStat(
                      label: l.weeklyActiveDays,
                      value: '${s.activeDays}',
                      suffix: '/${s.elapsedDays}',
                    ),
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: ReviewStat(
                      label: l.weeklyActions,
                      value: '${s.completedActions}',
                      suffix: s.plannedActions > 0
                          ? '/${s.plannedActions}'
                          : null,
                    ),
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: ReviewStat(
                      label: l.weeklyGoalsMoved,
                      value: '$moved',
                      suffix: l.weeklyGoalsUnit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.progressLifeAreas,
          trailingText: l.progressTracked(s.areas.length),
        ),
        AppCard(
          child: Column(
            children: [
              for (final (i, a) in s.areas.indexed) ...[
                if (i > 0) AppSpacing.gap16,
                AreaConsistencyRow(stat: a),
              ],
            ],
          ),
        ),
        if (strongest != null) ...[
          AppSpacing.gap16,
          _CalloutCard(
            overline: l.weeklyStrongest,
            meta: l.weeklyStrongestDays(strongest.activeDays, s.elapsedDays),
            area: strongest.area,
            body: l.weeklyStrongestBody,
            color: AppColors.success,
          ),
        ],
        if (weakest != null) ...[
          AppSpacing.gap12,
          _CalloutCard(
            overline: l.weeklyAttention,
            meta: Fmt.percent(weakest.consistency),
            area: weakest.area,
            body: l.weeklyAttentionBody,
            color: AppColors.primaryStrong,
          ),
        ],
        AppSpacing.gap28,
        SectionHeader(title: l.weeklyBiggestWin),
        _BiggestWin(
          custom: _biggestWin,
          derived: win,
          onEdit: (text) => setState(() => _biggestWin = text),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.weeklyDidntMove,
          trailingText: gaps.isEmpty ? null : l.weeklyCarriedOver,
        ),
        AppCard(
          child: gaps.isEmpty
              ? Row(
                  children: [
                    const Icon(
                      Symbols.check_circle,
                      size: 20,
                      color: AppColors.success,
                    ),
                    AppSpacing.gap12,
                    Expanded(
                      child: Text(l.weeklyAllMoved, style: AppTypography.body),
                    ),
                  ],
                )
              : Column(children: [for (final g in gaps) GapRow(gap: g)]),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.weeklyReflection,
          subtitle: l.weeklyReflectionSub,
        ),
        ReflectionBlock(
          fieldKey: const Key('weekly-went-well'),
          question: l.weeklyWentWell,
          tags: weeklyWentWellTags,
          selected: _wentWell,
          onToggle: (t) =>
              setState(() => _wentWell = {..._wentWell}..toggle(t)),
          controller: _wentWellNote,
          hint: l.weeklyWentWellHint,
        ),
        AppSpacing.gap12,
        ReflectionBlock(
          fieldKey: const Key('weekly-change'),
          question: l.weeklyChange,
          tags: weeklyChangeTags,
          selected: _change,
          onToggle: (t) => setState(() => _change = {..._change}..toggle(t)),
          controller: _changeNote,
          hint: l.weeklyChangeHint,
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.weeklyNextFocus,
          subtitle: l.weeklyNextFocusSub(weekRangeLabel(_range.next)),
          badge: _priorities.isEmpty
              ? null
              : StatusChip(
                  label: l.reviewSelected(_priorities.length),
                  tone: StatusTone.brand,
                ),
        ),
        PrioritiesEditor(
          priorities: _priorities,
          onChanged: (p) => setState(() => _priorities = p),
        ),
        if (insight != null) ...[
          AppSpacing.gap20,
          InsightCard(title: l.progressConsistency, message: insight),
        ],
      ],
    );
  }
}

extension on Set<String> {
  void toggle(String value) {
    if (!remove(value)) add(value);
  }
}

class _CalloutCard extends StatelessWidget {
  const _CalloutCard({
    required this.overline,
    required this.meta,
    required this.area,
    required this.body,
    required this.color,
  });

  final String overline;
  final String meta;
  final LifeArea area;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            AppSpacing.gap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: OverlineLabel(overline, color: color)),
                      Text(meta, style: AppTypography.captionSmall),
                    ],
                  ),
                  AppSpacing.gap8,
                  Row(
                    children: [
                      Icon(area.icon, size: 16, color: area.color),
                      const SizedBox(width: 6),
                      Text(area.label(context), style: AppTypography.cardTitle),
                    ],
                  ),
                  AppSpacing.gap4,
                  Text(body, style: AppTypography.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BiggestWin extends StatelessWidget {
  const _BiggestWin({
    required this.custom,
    required this.derived,
    required this.onEdit,
  });

  final String? custom;
  final ReviewWin? derived;
  final ValueChanged<String?> onEdit;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    Future<void> edit(String? initial) async {
      final text = await showTextSheet(
        context,
        title: l.weeklyBiggestWin,
        hint: l.weeklyWinHint,
        initial: initial,
      );
      if (text != null) onEdit(text.trim().isEmpty ? null : text.trim());
    }

    if (custom == null && derived == null) {
      return AddRowButton(
        key: const Key('weekly-add-win'),
        label: l.weeklyAddWin,
        onTap: () => edit(null),
      );
    }
    return AppCard(
      padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
      child: Row(
        children: [
          Expanded(
            child: custom != null
                ? Row(
                    children: [
                      const Icon(
                        Symbols.check_circle,
                        fill: 1,
                        size: 22,
                        color: AppColors.success,
                      ),
                      AppSpacing.gap12,
                      Expanded(
                        child: Text(custom!, style: AppTypography.bodyMedium),
                      ),
                    ],
                  )
                : WinRow(win: derived!),
          ),
          IconButton(
            key: const Key('weekly-edit-win'),
            tooltip: l.weeklyEditWin,
            icon: const Icon(Symbols.edit, size: 18),
            onPressed: () => edit(
              custom ??
                  (derived!.kind == WinKind.consistency
                      ? l.reviewWinConsistency(
                          derived!.area!.label(context),
                          derived!.days!,
                        )
                      : derived!.title),
            ),
          ),
        ],
      ),
    );
  }
}
