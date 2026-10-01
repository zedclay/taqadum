import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../settings/data/preferences.dart';
import '../data/daily_repository.dart';
import '../data/tasks_repository.dart';
import '../domain/today_summary.dart';
import 'widgets/task_labels.dart';
import 'widgets/task_sheets.dart';

class NightReviewScreen extends ConsumerStatefulWidget {
  const NightReviewScreen({super.key});

  @override
  ConsumerState<NightReviewScreen> createState() => _NightReviewScreenState();
}

class _NightReviewScreenState extends ConsumerState<NightReviewScreen> {
  final _wentWellNote = TextEditingController();
  final _betterNote = TextEditingController();
  int? _rating;
  final Set<String> _wentWell = {};
  final Set<String> _better = {};
  Set<String>? _moveIds;
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _wentWellNote.dispose();
    _betterNote.dispose();
    super.dispose();
  }

  void _init(NightReview? existing, List<Task> tasks) {
    if (_initialized) return;
    _initialized = true;
    _moveIds = tasks
        .where((t) => t.completedAt == null)
        .map((t) => t.id)
        .toSet();
    if (existing == null) return;
    _rating = existing.rating;
    _wentWell.addAll(decodeTags(existing.wentWellTags));
    _better.addAll(decodeTags(existing.betterTags));
    _wentWellNote.text = existing.wentWellNote ?? '';
    _betterNote.text = existing.betterNote ?? '';
  }

  Future<void> _complete(String dayKey, List<Task> tasks) async {
    setState(() => _saving = true);
    final move = tasks
        .where((t) => t.completedAt == null && (_moveIds ?? {}).contains(t.id))
        .toList();
    await ref
        .read(dailyRepositoryProvider)
        .saveNightReview(
          NightReviewDraft(
            dayKey: dayKey,
            rating: _rating ?? 3,
            wentWellTags: _wentWell.toList(),
            wentWellNote: _wentWellNote.text,
            betterTags: _better.toList(),
            betterNote: _betterNote.text,
            moveToTomorrow: move,
          ),
        );
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final message = context.l10n.nightSaved;
    context.pop();
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final dayKey = dayKeyOf(today);
    final tomorrowKey = dayKeyOf(addDays(today, 1));
    final tasks = ref.watch(tasksForDayProvider(dayKey));
    final tomorrow = ref.watch(tasksForDayProvider(tomorrowKey));
    final existing = ref.watch(nightReviewProvider(dayKey));

    return Scaffold(
      appBar: AppTopBar(
        title: l.nightTitle,
        subtitle: Fmt.weekdayDayMonth(today),
        closeIcon: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: Pill(
              label: l.nightBadge,
              icon: Symbols.bedtime,
              dense: true,
            ),
          ),
        ],
      ),
      body: AsyncView<List<Task>>(
        value: tasks,
        builder: (list) {
          if (!existing.hasValue) return const LoadingState();
          _init(existing.value, list);
          final unfinished = list.where((t) => t.completedAt == null).toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.sm,
              AppSpacing.screen,
              AppSpacing.xxl,
            ),
            children: [
              Text(
                l.nightHeadline,
                style: AppTypography.pageTitle.copyWith(fontSize: 26),
              ),
              AppSpacing.gap4,
              Text(
                l.nightSub,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (existing.value != null) ...[
                AppSpacing.gap12,
                Text(l.nightAlreadyDone, style: AppTypography.caption),
              ],
              AppSpacing.gap24,
              _RatingCard(
                rating: _rating,
                onChanged: (r) => setState(() => _rating = r),
              ),
              AppSpacing.gap16,
              _SummaryCard(tasks: list),
              AppSpacing.gap16,
              _ReflectionCard(
                icon: Symbols.sentiment_satisfied,
                iconColor: AppColors.success,
                title: l.nightWentWell,
                tags: [
                  l.tagFocused,
                  l.tagGoodEnergy,
                  l.tagQuranDone,
                  l.tagProgressWork,
                  l.tagMoved,
                  l.tagFamily,
                ],
                selected: _wentWell,
                onToggle: (t) => setState(() {
                  if (!_wentWell.remove(t)) _wentWell.add(t);
                }),
                controller: _wentWellNote,
                hint: l.nightWentWellHint,
              ),
              AppSpacing.gap16,
              _ReflectionCard(
                icon: Symbols.trending_up,
                iconColor: AppColors.primaryStrong,
                title: l.nightBetter,
                tags: [
                  l.tagDistracted,
                  l.tagOverplanned,
                  l.tagLateStart,
                  l.tagMissedWorkout,
                  l.tagTired,
                  l.tagTooManyMeetings,
                ],
                selected: _better,
                onToggle: (t) => setState(() {
                  if (!_better.remove(t)) _better.add(t);
                }),
                controller: _betterNote,
                hint: l.nightBetterHint,
              ),
              AppSpacing.gap28,
              _UnfinishedSection(
                tasks: unfinished,
                allTasks: list,
                moveIds: _moveIds ?? {},
                onToggle: (id) => setState(() {
                  final ids = {...?_moveIds};
                  if (!ids.remove(id)) ids.add(id);
                  _moveIds = ids;
                }),
              ),
              AppSpacing.gap28,
              _TomorrowCard(
                date: addDays(today, 1),
                tasks: tomorrow.value ?? const [],
                incoming: unfinished
                    .where((t) => (_moveIds ?? {}).contains(t.id))
                    .length,
              ),
              AppSpacing.gap28,
              PrimaryButton(
                key: const Key('night-complete'),
                label: l.nightComplete,
                icon: Symbols.arrow_forward,
                loading: _saving,
                onPressed: _saving ? null : () => _complete(dayKey, list),
              ),
              AppSpacing.gap8,
              Center(
                child: AppTextButton(
                  label: l.nightSkip,
                  onPressed: () => context.pop(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RatingCard extends StatelessWidget {
  const _RatingCard({required this.rating, required this.onChanged});

  final int? rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.nightRating,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          AppSpacing.gap12,
          Row(
            children: [
              for (var i = 1; i <= 5; i++) ...[
                if (i > 1) AppSpacing.gap8,
                Expanded(
                  child: _RatingButton(
                    value: i,
                    selected: rating == i,
                    onTap: () => onChanged(i),
                  ),
                ),
              ],
            ],
          ),
          AppSpacing.gap8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l.nightHard, style: AppTypography.captionSmall),
              Text(l.nightOkay, style: AppTypography.captionSmall),
              Text(l.nightGreat, style: AppTypography.captionSmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingButton extends StatelessWidget {
  const _RatingButton({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final int value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.small),
        height: 48,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryStrong : AppColors.surfaceMuted,
          borderRadius: AppRadius.mdAll,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            key: Key('night-rating-$value'),
            borderRadius: AppRadius.mdAll,
            onTap: onTap,
            child: Center(
              child: Text(
                '$value',
                style: AppTypography.sectionTitle.copyWith(
                  color: selected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final summary = TodaySummary.of(tasks);
    final byArea = <LifeArea, (int, int)>{};
    for (final t in tasks) {
      final (done, total) = byArea[t.area] ?? (0, 0);
      byArea[t.area] = (done + (t.completedAt != null ? 1 : 0), total + 1);
    }
    final tone = summary.ratio >= 0.75
        ? l.nightToneStrong
        : summary.ratio >= 0.4
        ? l.nightToneSteady
        : l.nightToneLight;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.nightSummary.toUpperCase(),
                  style: AppTypography.overline,
                ),
              ),
              if (!summary.isEmpty)
                Text(
                  l.nightPercent(summary.percent),
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryStrong,
                  ),
                ),
            ],
          ),
          AppSpacing.gap8,
          if (summary.isEmpty)
            Text(l.nightNoPlan, style: AppTypography.body)
          else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    l.nightActions(summary.done, summary.total),
                    style: AppTypography.headline,
                  ),
                ),
                Text(
                  l.nightRemaining(summary.left),
                  style: AppTypography.caption,
                ),
              ],
            ),
            AppSpacing.gap8,
            AppProgressBar(value: summary.ratio),
            AppSpacing.gap12,
            Text(
              tone,
              style: AppTypography.body.copyWith(color: AppColors.textBody),
            ),
            AppSpacing.gap12,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final e in byArea.entries)
                  Pill(
                    label:
                        '${e.key.label(context)} ${Fmt.percent(e.value.$1 / e.value.$2)}',
                    foreground: e.key.color,
                    background: e.key.soft,
                    dot: true,
                    dense: true,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  const _ReflectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.tags,
    required this.selected,
    required this.onToggle,
    required this.controller,
    required this.hint,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final List<String> tags;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              AppSpacing.gap8,
              Expanded(child: Text(title, style: AppTypography.sectionTitle)),
            ],
          ),
          AppSpacing.gap12,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final t in tags)
                ChoiceTag(
                  label: t,
                  selected: selected.contains(t),
                  onTap: () => onToggle(t),
                ),
            ],
          ),
          AppSpacing.gap12,
          AppTextField(
            controller: controller,
            hint: hint,
            maxLines: 4,
            minLines: 2,
          ),
        ],
      ),
    );
  }
}

class _UnfinishedSection extends ConsumerWidget {
  const _UnfinishedSection({
    required this.tasks,
    required this.allTasks,
    required this.moveIds,
    required this.onToggle,
  });

  final List<Task> tasks;
  final List<Task> allTasks;
  final Set<String> moveIds;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(l.nightUnfinished, style: AppTypography.sectionTitle),
            AppSpacing.gap8,
            if (tasks.isNotEmpty)
              StatusChip(
                label: l.nightRemaining(tasks.length),
                tone: StatusTone.brand,
              ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          tasks.isEmpty ? l.nightAllDone : l.nightUnfinishedHint,
          style: AppTypography.caption,
        ),
        AppSpacing.gap12,
        for (final t in tasks)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: AppCard(
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: t.area.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          taskMeta(context, t, use24h: use24h),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  _MoveToggle(
                    selected: moveIds.contains(t.id),
                    onTap: () => onToggle(t.id),
                  ),
                  IconButton(
                    tooltip: l.commonMore,
                    icon: const Icon(
                      Symbols.more_vert,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        showTaskOptions(context, ref, t, dayTasks: allTasks),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _MoveToggle extends StatelessWidget {
  const _MoveToggle({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Semantics(
      toggled: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.small),
        height: 34,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryStrong : AppColors.surfaceMuted,
          borderRadius: AppRadius.pillAll,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.pillAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Center(
                child: Text(
                  l.nightMoveTomorrow,
                  style: AppTypography.label.copyWith(
                    color: selected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TomorrowCard extends ConsumerWidget {
  const _TomorrowCard({
    required this.date,
    required this.tasks,
    required this.incoming,
  });

  final DateTime date;
  final List<Task> tasks;
  final int incoming;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final ordered = [...tasks]
      ..sort(
        (a, b) =>
            (a.scheduledMinute ?? 9999).compareTo(b.scheduledMinute ?? 9999),
      );
    final total = tasks.length + incoming;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.wb_twilight,
                color: AppColors.primaryStrong,
                size: 22,
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(l.nightTomorrow, style: AppTypography.sectionTitle),
              ),
              Text(
                Fmt.shortWeekdayDayMonth(date),
                style: AppTypography.caption,
              ),
            ],
          ),
          AppSpacing.gap12,
          if (ordered.isEmpty && incoming == 0)
            Text(l.nightTomorrowEmpty, style: AppTypography.body)
          else
            for (final t in ordered.take(5))
              Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 52,
                      child: Text(
                        t.scheduledMinute == null
                            ? '—'
                            : Fmt.timeOfDay(t.scheduledMinute!, use24h: use24h),
                        style: AppTypography.caption
                            .copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            )
                            .tabular,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        t.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    CategoryChip(area: t.area, dot: false),
                  ],
                ),
              ),
          if (total > 0) ...[
            AppSpacing.gap4,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Symbols.check_circle,
                  color: AppColors.success,
                  size: 16,
                ),
                AppSpacing.gap8,
                Text(l.nightTomorrowReady(total), style: AppTypography.caption),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
