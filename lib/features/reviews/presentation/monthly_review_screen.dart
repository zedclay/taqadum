import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../history/data/activity_repository.dart';
import '../../progress/data/progress_providers.dart';
import '../../progress/domain/progress_calculator.dart';
import '../../settings/data/preferences.dart';
import '../data/reviews_repository.dart';
import '../domain/review_insights.dart';
import 'widgets/monthly_snapshots.dart';
import 'widgets/review_widgets.dart';
import '../../../core/utilities/bidi.dart';

class MonthlyReviewScreen extends ConsumerStatefulWidget {
  const MonthlyReviewScreen({super.key});

  @override
  ConsumerState<MonthlyReviewScreen> createState() =>
      _MonthlyReviewScreenState();
}

class _MonthlyReviewScreenState extends ConsumerState<MonthlyReviewScreen> {
  late final PeriodRange _range;
  late final String _monthKey;
  final _proudNote = TextEditingController();
  final _heldBackNote = TextEditingController();
  final _differentNote = TextEditingController();
  final _lesson = TextEditingController();
  Set<String> _proud = {};
  Set<String> _heldBack = {};
  Set<String> _different = {};
  List<ReviewPriority> _priorities = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _range = reviewMonth(ref.read(currentDayProvider));
    _monthKey = monthKeyOf(_range.start);
    var loaded = false;
    ref.listenManual(monthlyReviewProvider(_monthKey), (_, next) {
      if (loaded || !next.hasValue) return;
      loaded = true;
      final r = next.value;
      if (r == null) return;
      void apply() {
        _proud = decodeTagSet(r.proudTags);
        _heldBack = decodeTagSet(r.heldBackTags);
        _different = decodeTagSet(r.differentTags);
        _proudNote.text = r.proudNote ?? '';
        _heldBackNote.text = r.heldBackNote ?? '';
        _differentNote.text = r.differentNote ?? '';
        _lesson.text = r.lesson ?? '';
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
    _proudNote.dispose();
    _heldBackNote.dispose();
    _differentNote.dispose();
    _lesson.dispose();
    super.dispose();
  }

  Future<void> _save({required bool complete}) async {
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    setState(() => _saving = true);
    await ref
        .read(reviewsRepositoryProvider)
        .saveMonthly(
          monthKey: _monthKey,
          proudTags: _proud.toList(),
          proudNote: _proudNote.text,
          heldBackTags: _heldBack.toList(),
          heldBackNote: _heldBackNote.text,
          differentTags: _different.toList(),
          differentNote: _differentNote.text,
          lesson: _lesson.text,
          priorities: _priorities,
          complete: complete,
          monthLabel: Fmt.monthYear(_range.start),
        );
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(content: Text(complete ? l.reviewCompleted : l.reviewSaved)),
    );
    router.pop();
  }

  void _toggle(
    Set<String> Function() get,
    void Function(Set<String>) set,
    String t,
  ) {
    final next = {...get()};
    if (!next.remove(t)) next.add(t);
    setState(() => set(next));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final summary = ref.watch(periodSummaryProvider(_range));
    final review = ref.watch(monthlyReviewProvider(_monthKey));
    final views = ref.watch(goalViewsProvider);
    final goalEvents = ref.watch(goalEventsProvider);
    final milestones = ref.watch(goalMilestonesProvider);
    final events = ref.watch(activityInRangeProvider(_range));
    final weekly = ref.watch(allWeeklyReviewsProvider);

    final all = [
      summary,
      review,
      views,
      goalEvents,
      milestones,
      events,
      weekly,
    ];
    final error = all.where((a) => a.hasError).firstOrNull;
    final loading = all.any((a) => !a.hasValue);
    final completed = review.value?.completedAt != null;

    Widget body;
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
      final weekStarts = _range.days
          .where((d) => d.weekday == weekStart)
          .map(dayKeyOf)
          .toSet();
      final reviewsDone = weekly.requireValue
          .where(
            (w) => weekStarts.contains(w.weekStart) && w.completedAt != null,
          )
          .length;
      body = _content(
        context,
        summary: s,
        review: review.value,
        movements: movements,
        wins: reviewWins(
          events: events.requireValue,
          movements: movements,
          summary: s,
        ),
        gaps: reviewGaps(movements: movements, summary: s, range: _range),
        reviewsDone: reviewsDone,
        weeks: weekStarts.length,
      );
    }

    return Scaffold(
      appBar: AppTopBar(
        title: l.monthlyTitle,
        subtitle: Fmt.monthYear(_range.start),
      ),
      body: body,
      bottomNavigationBar: loading || error != null
          ? null
          : ReviewFooter(
              primary: PrimaryButton(
                key: const Key('monthly-complete'),
                label: completed ? l.monthlyUpdate : l.monthlyComplete,
                icon: Symbols.arrow_forward,
                loading: _saving,
                onPressed: _saving ? null : () => _save(complete: true),
              ),
              secondary: completed
                  ? null
                  : AppTextButton(
                      key: const Key('monthly-save-draft'),
                      label: l.reviewSaveDraft,
                      onPressed: _saving ? null : () => _save(complete: false),
                    ),
            ),
    );
  }

  Widget _content(
    BuildContext context, {
    required PeriodSummary summary,
    required MonthlyReview? review,
    required List<GoalMovement> movements,
    required List<ReviewWin> wins,
    required List<ReviewGap> gaps,
    required int reviewsDone,
    required int weeks,
  }) {
    final l = context.l10n;
    final s = summary;
    final delta = s.overallDelta;
    final strongest = s.strongest;
    final weakest = s.weakest;
    final active = movements
        .where((m) => m.view.goal.status == GoalStatus.active)
        .toList();
    final nextMonth = _range.next.start;
    final priorityAreas = _priorities.map((p) => p.area).toSet();

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.sm,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Row(
          children: [
            const Icon(
              Symbols.calendar_today,
              size: 14,
              color: AppColors.primaryStrong,
            ),
            const SizedBox(width: 6),
            OverlineLabel(l.monthlyCadence, color: AppColors.primaryStrong),
          ],
        ),
        AppSpacing.gap8,
        Text(l.monthlyHero, style: AppTypography.pageTitle),
        AppSpacing.gap4,
        Text(l.monthlyHeroBody, style: AppTypography.body),
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
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: Fmt.percent(s.overall),
                                style: AppTypography.display.copyWith(
                                  color: AppColors.primaryStrong,
                                ),
                              ),
                              TextSpan(
                                text: ' ${l.monthlyCompletion}',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (delta != null)
                    Pill(
                      label: l.monthlyVs(
                        Fmt.signedPercent(delta),
                        DateFormat.MMM().format(_range.previous.start),
                      ),
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
                    ),
                  ),
                ],
              ),
              AppSpacing.gap8,
              Row(
                children: [
                  Expanded(
                    child: ReviewStat(
                      label: l.weeklyGoalsMoved,
                      value: '${movements.where((m) => m.hasMoved).length}',
                    ),
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: ReviewStat(
                      label: l.monthlyReviewsDone,
                      value: '$reviewsDone',
                      suffix: '/$weeks',
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
          trailingText: l.monthlyActiveDomains(
            s.areas.where((a) => a.activeDays > 0).length,
          ),
        ),
        _AreaGrid(areas: s.areas),
        if (strongest != null || weakest != null) ...[
          AppSpacing.gap28,
          SectionHeader(title: l.monthlyInsights),
          if (strongest != null)
            _InsightTile(
              icon: Symbols.verified,
              color: AppColors.success,
              overline: l.weeklyStrongest,
              title: l.monthlyStrongestTitle(
                strongest.area.label(context),
                strongest.activeDays,
              ),
              body: l.monthlyStrongestBody,
            ),
          if (strongest != null && weakest != null) AppSpacing.gap12,
          if (weakest != null)
            _InsightTile(
              icon: Symbols.adjust,
              color: AppColors.primaryStrong,
              overline: l.monthlyRefocus,
              title: l.monthlyRefocusTitle(
                weakest.area.label(context),
                Fmt.percent(weakest.consistency),
              ),
              body: l.monthlyRefocusBody,
            ),
        ],
        if (active.isNotEmpty) ...[
          AppSpacing.gap28,
          SectionHeader(
            title: l.monthlyGoals,
            trailingText: l.monthlyGoalsActive(active.length),
          ),
          AppCard(
            child: Column(
              children: [
                for (final (i, m) in active.indexed) ...[
                  if (i > 0) const Divider(height: AppSpacing.xl),
                  _GoalMovementRow(movement: m),
                ],
              ],
            ),
          ),
        ],
        AppSpacing.gap20,
        const _QuoteCard(),
        AppSpacing.gap28,
        SectionHeader(
          title: l.monthlySnapshots,
          trailingText: l.monthlySnapshotsSub,
        ),
        MonthlySnapshots(
          range: _range,
          areas: s.areas.map((a) => a.area).toList(),
        ),
        AppSpacing.gap28,
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(
                title: l.monthlyWins,
                icon: Symbols.check_circle,
                iconColor: AppColors.success,
              ),
              if (wins.isEmpty)
                Text(l.monthlyNothingYet, style: AppTypography.caption)
              else
                for (final (i, w) in wins.indexed) ...[
                  if (i > 0) AppSpacing.gap12,
                  WinRow(win: w, index: i + 1),
                ],
            ],
          ),
        ),
        if (gaps.isNotEmpty) ...[
          AppSpacing.gap12,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  title: l.monthlyNotPlanned,
                  icon: Symbols.tune,
                  iconColor: AppColors.textSecondary,
                ),
                for (final g in gaps) GapRow(gap: g, long: true),
              ],
            ),
          ),
        ],
        AppSpacing.gap28,
        SectionHeader(
          title: l.monthlyReflection,
          trailingText: l.monthlyReflectionSub,
        ),
        ReflectionBlock(
          fieldKey: const Key('monthly-proud'),
          question: l.monthlyProud,
          tags: monthlyProudTags,
          selected: _proud,
          onToggle: (t) => _toggle(() => _proud, (v) => _proud = v, t),
          controller: _proudNote,
          hint: l.monthlyNoteHint,
        ),
        AppSpacing.gap12,
        ReflectionBlock(
          fieldKey: const Key('monthly-held-back'),
          question: l.monthlyHeldBack,
          tags: monthlyHeldBackTags,
          selected: _heldBack,
          onToggle: (t) => _toggle(() => _heldBack, (v) => _heldBack = v, t),
          controller: _heldBackNote,
          hint: l.monthlyNoteHint,
        ),
        AppSpacing.gap12,
        ReflectionBlock(
          fieldKey: const Key('monthly-different'),
          question: l.monthlyDifferent,
          tags: monthlyDifferentTags,
          selected: _different,
          onToggle: (t) => _toggle(() => _different, (v) => _different = v, t),
          controller: _differentNote,
          hint: l.monthlyNoteHint,
        ),
        AppSpacing.gap12,
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.brandSoft,
            borderRadius: AppRadius.cardAll,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(
                    Symbols.lightbulb,
                    size: 18,
                    color: AppColors.primaryStrong,
                  ),
                  AppSpacing.gap8,
                  Text(l.monthlyLesson, style: AppTypography.label),
                ],
              ),
              AppSpacing.gap8,
              AppTextField(
                fieldKey: const Key('monthly-lesson'),
                controller: _lesson,
                hint: l.monthlyLessonHint,
                minLines: 1,
                maxLines: 3,
              ),
            ],
          ),
        ),
        AppSpacing.gap28,
        SectionHeader(
          title: l.monthlyNextFocus(Fmt.monthName(nextMonth)),
          subtitle: l.monthlyNextFocusSub,
          badge: StatusChip(
            label: '${_priorities.length}/3',
            tone: StatusTone.brand,
          ),
        ),
        PrioritiesEditor(
          priorities: _priorities,
          onChanged: (p) => setState(() => _priorities = p),
        ),
        if (_priorities.length >= 2) ...[
          AppSpacing.gap12,
          priorityAreas.length >= 2
              ? InfoBanner(message: l.monthlyBalanced(priorityAreas.length))
              : InfoBanner(
                  message: l.monthlyNarrow,
                  icon: Symbols.info,
                  color: AppColors.textSecondary,
                  background: AppColors.surfaceMuted,
                ),
        ],
      ],
    );
  }
}

class _AreaGrid extends StatelessWidget {
  const _AreaGrid({required this.areas});

  final List<AreaStat> areas;

  @override
  Widget build(BuildContext context) {
    final rows = <List<AreaStat>>[
      for (var i = 0; i < areas.length; i += 2)
        areas.sublist(i, (i + 2).clamp(0, areas.length)),
    ];
    return Column(
      children: [
        for (final (r, row) in rows.indexed) ...[
          if (r > 0) AppSpacing.gap8,
          Row(
            children: [
              for (final (i, a) in row.indexed) ...[
                if (i > 0) AppSpacing.gap8,
                Expanded(child: _AreaTile(stat: a)),
              ],
              if (row.length == 1) ...[
                AppSpacing.gap8,
                const Expanded(child: SizedBox.shrink()),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _AreaTile extends StatelessWidget {
  const _AreaTile({required this.stat});

  final AreaStat stat;

  @override
  Widget build(BuildContext context) {
    final area = stat.area;
    final delta = stat.delta;
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(area.icon, size: 16, color: area.color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  area.label(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label,
                ),
              ),
              if (delta != null)
                Text(
                  Fmt.signedPercent(delta),
                  style: AppTypography.captionSmall.copyWith(
                    color: delta >= 0 ? AppColors.success : AppColors.danger,
                  ),
                ),
            ],
          ),
          AppSpacing.gap8,
          Text(
            Fmt.percent(stat.consistency),
            style: AppTypography.cardTitle.tabular,
          ),
          const SizedBox(height: 6),
          AppProgressBar(value: stat.consistency, color: area.color, height: 4),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.icon,
    required this.color,
    required this.overline,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String overline;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              OverlineLabel(overline, color: color),
            ],
          ),
          AppSpacing.gap8,
          Text(title, style: AppTypography.cardTitle),
          AppSpacing.gap4,
          Text(body, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _GoalMovementRow extends StatelessWidget {
  const _GoalMovementRow({required this.movement});

  final GoalMovement movement;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final m = movement;
    final g = m.view.goal;
    final p = m.view.progress;
    final (icon, line) = m.milestones > 0
        ? (Symbols.flag, l.monthlyGoalMilestones(m.milestones))
        : m.moved > 0
        ? (
            Symbols.arrow_upward,
            l.monthlyGoalMoved(movementLabel(l, g, m.moved)),
          )
        : (Symbols.remove, l.monthlyGoalNoMove);
    return InkWell(
      onTap: () => context.push(AppRoutes.goal(g.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(bidiSafe(g.title), style: AppTypography.bodyMedium),
              ),
              Text(
                '${p.percent}%',
                style: AppTypography.label.copyWith(color: g.area.color),
              ),
            ],
          ),
          AppSpacing.gap8,
          AppProgressBar(value: p.ratio, color: g.area.color, height: 5),
          AppSpacing.gap8,
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: m.hasMoved ? AppColors.success : AppColors.textMuted,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  line,
                  style: AppTypography.captionSmall.copyWith(
                    color: m.hasMoved
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  g.type == GoalType.target
                      ? l.monthlyTarget(
                          goalValue(l, g, g.targetValue, compact: true),
                        )
                      : goalProgressLine(context, m.view),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

class _QuoteCard extends StatelessWidget {
  const _QuoteCard();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: AppRadius.cardAll,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.textPrimary, Color(0xFF3A2A24)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverlineLabel(l.monthlyCadence.toUpperCase(), color: AppColors.brand),
          AppSpacing.gap8,
          Text(
            '"${l.monthlyQuote}"',
            style: AppTypography.cardTitle.copyWith(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
