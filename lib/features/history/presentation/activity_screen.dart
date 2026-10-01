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
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../settings/data/preferences.dart';
import '../data/activity_repository.dart';

enum _RangeChoice { day, all, week, month, lastMonth, year }

IconData activityIcon(ActivityEvent e) => switch (e.entityType) {
  'checkin' => Symbols.wb_sunny,
  'nightReview' || 'sleep' => Symbols.bedtime,
  'weeklyReview' || 'monthlyReview' => Symbols.verified,
  'goal' =>
    e.type == ActivityType.completed ? Symbols.emoji_events : Symbols.adjust,
  'goalAction' || 'task' => Symbols.task_alt,
  'goalProgress' => Symbols.trending_up,
  'milestone' => Symbols.flag,
  'habit' || 'habitLog' => Symbols.check_circle,
  'learning' => Symbols.psychology,
  'note' => Symbols.sticky_note_2,
  'quran' => Symbols.menu_book,
  'walk' => Symbols.directions_walk,
  'workout' => Symbols.fitness_center,
  'work' => Symbols.work,
  'finance' =>
    (e.amountMinor ?? 0) >= 0 ? Symbols.payments : Symbols.receipt_long,
  _ => e.area?.icon ?? Symbols.history,
};

Color activityColor(ActivityEvent e) => e.area?.color ?? AppColors.warning;
Color activitySoft(ActivityEvent e) => e.area?.soft ?? AppColors.warningSoft;

String activityTypeLabel(BuildContext context, ActivityType t) {
  final l = context.l10n;
  return switch (t) {
    ActivityType.created => l.activityTypeCreated,
    ActivityType.completed => l.activityTypeCompleted,
    ActivityType.logged => l.activityTypeLogged,
    ActivityType.reviewed => l.activityTypeReviewed,
    ActivityType.updated => l.activityTypeUpdated,
    ActivityType.milestone => l.activityTypeMilestone,
  };
}

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key, this.initialDayKey});

  final String? initialDayKey;

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  final _search = TextEditingController();
  LifeArea? _area;
  bool _reviews = false;
  late _RangeChoice _choice = widget.initialDayKey == null
      ? _RangeChoice.all
      : _RangeChoice.day;

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  PeriodRange? _rangeFor(_RangeChoice c, DateTime today, int weekStart) =>
      switch (c) {
        _RangeChoice.day => PeriodRange.day(
          widget.initialDayKey == null
              ? today
              : dateOfKey(widget.initialDayKey!),
        ),
        _RangeChoice.all => null,
        _RangeChoice.week => PeriodRange.week(today, weekStart: weekStart),
        _RangeChoice.month => PeriodRange.month(today),
        _RangeChoice.lastMonth => PeriodRange.month(today).previous,
        _RangeChoice.year => PeriodRange.year(today),
      };

  String _rangeLabel(BuildContext context, _RangeChoice c, DateTime today) {
    final l = context.l10n;
    return switch (c) {
      _RangeChoice.day => Fmt.monthDay(
        widget.initialDayKey == null ? today : dateOfKey(widget.initialDayKey!),
      ),
      _RangeChoice.all => l.activityRangeAll,
      _RangeChoice.week => l.activityRangeWeek,
      _RangeChoice.month => Fmt.monthYear(today),
      _RangeChoice.lastMonth => Fmt.monthYear(
        DateTime(today.year, today.month - 1),
      ),
      _RangeChoice.year => '${today.year}',
    };
  }

  Future<void> _pickRange(DateTime today) async {
    final l = context.l10n;
    final choice = await showOptionSheet<_RangeChoice>(
      context,
      title: l.activityRangeTitle,
      selected: _choice,
      options: [
        if (widget.initialDayKey != null)
          SheetOption(
            value: _RangeChoice.day,
            label: Fmt.weekdayMonthDay(dateOfKey(widget.initialDayKey!)),
          ),
        SheetOption(value: _RangeChoice.all, label: l.activityRangeAll),
        SheetOption(value: _RangeChoice.week, label: l.activityRangeWeek),
        SheetOption(value: _RangeChoice.month, label: l.activityRangeMonth),
        SheetOption(
          value: _RangeChoice.lastMonth,
          label: l.activityRangeLastMonth,
        ),
        SheetOption(value: _RangeChoice.year, label: l.activityRangeYear),
      ],
    );
    if (choice != null) setState(() => _choice = choice);
  }

  void _reset() => setState(() {
    _search.clear();
    _area = null;
    _reviews = false;
    _choice = _RangeChoice.all;
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final filter = ActivityFilter(
      query: _search.text,
      area: _area,
      reviewsOnly: _reviews,
      range: _rangeFor(_choice, today, weekStart),
    );
    final events = ref.watch(filteredActivityProvider(filter));
    final filtered = !filter.isDefault;

    return Scaffold(
      appBar: AppTopBar(
        title: l.activityTitle,
        actions: [
          CircleIconButton(
            key: const Key('activity-range'),
            icon: Symbols.calendar_today,
            tooltip: l.activityFilterDate,
            onPressed: () => _pickRange(today),
          ),
          AppSpacing.gap8,
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.sm,
              AppSpacing.screen,
              0,
            ),
            child: AppTextField(
              fieldKey: const Key('activity-search'),
              controller: _search,
              hint: l.activitySearchHint,
              prefixIcon: const Icon(Symbols.search, size: 20),
              textInputAction: TextInputAction.search,
              suffixIcon: _search.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: l.activityClearSearch,
                      icon: const Icon(Symbols.close, size: 18),
                      onPressed: _search.clear,
                    ),
            ),
          ),
          AppSpacing.gap12,
          SizedBox(
            height: AppSpacing.minTouch,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screen,
              ),
              children: [
                FilterPill(
                  label: l.activityAll,
                  selected: _area == null && !_reviews,
                  onTap: () => setState(() {
                    _area = null;
                    _reviews = false;
                  }),
                ),
                for (final area in LifeArea.values) ...[
                  AppSpacing.gap8,
                  FilterPill(
                    label: area.label(context),
                    dotColor: area.color,
                    selected: _area == area && !_reviews,
                    onTap: () => setState(() {
                      _area = area;
                      _reviews = false;
                    }),
                  ),
                ],
                AppSpacing.gap8,
                FilterPill(
                  label: l.activityReviews,
                  dotColor: AppColors.warning,
                  selected: _reviews,
                  onTap: () => setState(() {
                    _reviews = true;
                    _area = null;
                  }),
                ),
              ],
            ),
          ),
          AppSpacing.gap12,
          Expanded(
            child: AsyncView<List<ActivityEvent>>(
              value: events,
              onRetry: () => ref.invalidate(filteredActivityProvider(filter)),
              builder: (items) {
                final areas = items.map((e) => e.area).nonNulls.toSet().length;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screen,
                    0,
                    AppSpacing.screen,
                    AppSpacing.huge,
                  ),
                  children: [
                    _SummaryBanner(
                      text: l.activityShowing(
                        l.activityEntries(items.length),
                        l.activityAreas(areas),
                      ),
                      rangeLabel: _rangeLabel(context, _choice, today),
                      onRange: () => _pickRange(today),
                    ),
                    AppSpacing.gap16,
                    if (items.isEmpty)
                      filtered
                          ? EmptyState(
                              icon: Symbols.search_off,
                              title: l.activityEmptyTitle,
                              message: l.activityEmptyBody,
                              actionLabel: l.activityReset,
                              onAction: _reset,
                            )
                          : EmptyState(
                              icon: Symbols.history,
                              title: l.activityNothingTitle,
                              message: l.activityNothingBody,
                            )
                    else
                      ..._groups(context, items, today),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _groups(
    BuildContext context,
    List<ActivityEvent> items,
    DateTime today,
  ) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final groups = <String, List<ActivityEvent>>{};
    for (final e in items) {
      (groups[dayKeyOf(e.occurredAt)] ??= []).add(e);
    }
    final todayKey = dayKeyOf(today);
    final yesterdayKey = dayKeyOf(addDays(today, -1));
    return [
      for (final MapEntry(key: key, value: list) in groups.entries) ...[
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm, top: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                key == todayKey
                    ? l.activityToday
                    : key == yesterdayKey
                    ? l.activityYesterday
                    : DateFormat('EEEE').format(dateOfKey(key)),
                style: AppTypography.sectionTitle,
              ),
              AppSpacing.gap8,
              Text(
                Fmt.monthDayYear(dateOfKey(key)),
                style: AppTypography.caption,
              ),
              const Spacer(),
              StatusChip(
                label: l.activityLogs(list.length),
                tone: key == todayKey ? StatusTone.brand : StatusTone.info,
              ),
            ],
          ),
        ),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              for (final (i, e) in list.indexed) ...[
                if (i > 0)
                  const Divider(
                    height: 1,
                    indent: AppSpacing.md,
                    endIndent: AppSpacing.md,
                  ),
                _EventRow(event: e, use24h: use24h),
              ],
            ],
          ),
        ),
        AppSpacing.gap20,
      ],
    ];
  }
}

class _SummaryBanner extends StatelessWidget {
  const _SummaryBanner({
    required this.text,
    required this.rangeLabel,
    required this.onRange,
  });

  final String text;
  final String rangeLabel;
  final VoidCallback onRange;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
      decoration: BoxDecoration(
        color: AppColors.infoSoft,
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        children: [
          const Icon(
            Symbols.timeline,
            size: 18,
            color: AppColors.primaryStrong,
          ),
          AppSpacing.gap8,
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(color: AppColors.textBody),
            ),
          ),
          Semantics(
            button: true,
            label: l.activityFilterDate,
            child: InkWell(
              key: const Key('activity-range-pill'),
              onTap: onRange,
              borderRadius: AppRadius.pillAll,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: AppSpacing.minTouch,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(rangeLabel, style: AppTypography.label),
                      const Icon(Symbols.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventRow extends ConsumerWidget {
  const _EventRow({required this.event, required this.use24h});

  final ActivityEvent event;
  final bool use24h;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final e = event;
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final areaLabel = e.area?.label(context) ?? l.activityReview;
    final time = Fmt.time(e.occurredAt.toLocal(), use24h: use24h);
    final amount = e.amountMinor;
    return ActivityRow(
      icon: activityIcon(e),
      color: activityColor(e),
      background: activitySoft(e),
      dotColor: activityColor(e),
      title: e.title,
      subtitle: [areaLabel, ?e.subtitle].join(' · '),
      trailingTop: amount == null
          ? null
          : Fmt.money(amount, currency, signed: true),
      trailingTopColor: amount == null
          ? null
          : amount >= 0
          ? AppColors.info
          : AppColors.textPrimary,
      trailing: time,
      showChevron: true,
      onTap: () => showAppSheet<void>(
        context,
        builder: (_) => _EventDetail(event: e, use24h: use24h),
      ),
    );
  }
}

class _EventDetail extends ConsumerWidget {
  const _EventDetail({required this.event, required this.use24h});

  final ActivityEvent event;
  final bool use24h;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final e = event;
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final local = e.occurredAt.toLocal();
    final (String? label, String? route) = switch (e.entityType) {
      'goal' when e.entityId != null => (
        l.activityOpenGoal,
        AppRoutes.goal(e.entityId!),
      ),
      'task' ||
      'checkin' ||
      'nightReview' => (l.activityOpenPlan, AppRoutes.planOn(dayKeyOf(local))),
      _ when e.area?.route != null => (
        '${l.activityOpen} ${e.area!.label(context)}',
        e.area!.route,
      ),
      _ => (null, null),
    };
    final rows = <(String, String)>[
      (l.activityLoggedTime, whenText(local)),
      (l.activityType, activityTypeLabel(context, e.type)),
      if (e.amountMinor != null)
        (l.activityAmount, Fmt.money(e.amountMinor!, currency, signed: true)),
    ];
    return AppBottomSheet(
      title: e.title,
      subtitle: [
        e.area?.label(context) ?? l.activityReview,
        ?e.subtitle,
      ].join(' · '),
      leading: IconTile(
        icon: activityIcon(e),
        color: activityColor(e),
        background: activitySoft(e),
      ),
      action: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              label: l.activityDismiss,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          if (route != null) ...[
            AppSpacing.gap12,
            Expanded(
              child: PrimaryButton(
                key: const Key('activity-open'),
                label: label!,
                onPressed: () {
                  final router = GoRouter.of(context);
                  Navigator.of(context).pop();
                  router.push(route);
                },
              ),
            ),
          ],
        ],
      ),
      child: Column(
        children: [
          for (final (i, (k, v)) in rows.indexed) ...[
            if (i > 0) const Divider(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(child: Text(k, style: AppTypography.caption)),
                Text(v, style: AppTypography.label.tabular),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String whenText(DateTime local) =>
      '${Fmt.monthDayYear(local)} · ${Fmt.time(local, use24h: use24h)}';
}
