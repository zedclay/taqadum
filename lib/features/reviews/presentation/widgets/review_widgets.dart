import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utilities/formatters.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/area_style.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/chips.dart';
import '../../../../core/widgets/progress.dart';
import '../../../goals/data/goals_repository.dart';
import '../../../goals/presentation/widgets/goal_mini_card.dart';
import '../../../goals/presentation/widgets/goal_widgets.dart';
import '../../../progress/domain/progress_calculator.dart';
import '../../../settings/data/preferences.dart';
import '../../data/reviews_repository.dart';
import '../../domain/review_insights.dart';

const weeklyWentWellTags = [
  'focused',
  'routine',
  'quran',
  'work',
  'family',
  'health',
];
const weeklyChangeTags = [
  'distraction',
  'sleep',
  'fewerTasks',
  'protectWorkout',
  'planAhead',
];
const monthlyProudTags = [
  'consistency',
  'workProgress',
  'quranMemo',
  'finance',
  'health',
];
const monthlyHeldBackTags = [
  'lateSleep',
  'overplanning',
  'distraction',
  'lowEnergy',
];
const monthlyDifferentTags = [
  'bedtime',
  'simplerTargets',
  'delegate',
  'fewerPriorities',
];

String reviewTagLabel(BuildContext context, String id) {
  final l = context.l10n;
  return switch (id) {
    'focused' => l.reviewTagFocused,
    'routine' => l.reviewTagRoutine,
    'quran' => l.reviewTagQuran,
    'work' => l.reviewTagWork,
    'family' => l.reviewTagFamily,
    'health' => l.reviewTagHealth,
    'distraction' => l.reviewTagDistraction,
    'sleep' => l.reviewTagSleep,
    'fewerTasks' => l.reviewTagFewerTasks,
    'protectWorkout' => l.reviewTagProtectWorkout,
    'planAhead' => l.reviewTagPlanAhead,
    'consistency' => l.reviewTagConsistency,
    'workProgress' => l.reviewTagWorkProgress,
    'quranMemo' => l.reviewTagQuranMemo,
    'finance' => l.reviewTagFinance,
    'lateSleep' => l.reviewTagLateSleep,
    'overplanning' => l.reviewTagOverplanning,
    'lowEnergy' => l.reviewTagLowEnergy,
    'bedtime' => l.reviewTagBedtime,
    'simplerTargets' => l.reviewTagSimplerTargets,
    'delegate' => l.reviewTagDelegate,
    'fewerPriorities' => l.reviewTagFewerPriorities,
    _ => id,
  };
}

/// Compact metric used in review summary cards.
class ReviewStat extends StatelessWidget {
  const ReviewStat({
    super.key,
    required this.label,
    required this.value,
    this.suffix,
  });

  final String label;
  final String value;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: value, style: AppTypography.cardTitle.tabular),
                if (suffix != null)
                  TextSpan(text: ' $suffix', style: AppTypography.captionSmall),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Life area row with consistency percentage, change, and bar.
class AreaConsistencyRow extends StatelessWidget {
  const AreaConsistencyRow({super.key, required this.stat});

  final AreaStat stat;

  @override
  Widget build(BuildContext context) {
    final area = stat.area;
    final delta = stat.delta;
    return Column(
      children: [
        Row(
          children: [
            Icon(area.icon, size: 18, color: area.color),
            AppSpacing.gap8,
            Expanded(
              child: Text(area.label(context), style: AppTypography.bodyMedium),
            ),
            Text(
              Fmt.percent(stat.consistency),
              style: AppTypography.label.tabular,
            ),
            if (delta != null) ...[
              AppSpacing.gap8,
              SizedBox(
                width: 36,
                child: Text(
                  Fmt.signedPercent(delta),
                  textAlign: TextAlign.end,
                  style: AppTypography.captionSmall.copyWith(
                    color: delta >= 0 ? AppColors.success : AppColors.danger,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        AppProgressBar(value: stat.consistency, color: area.color, height: 5),
      ],
    );
  }
}

/// Question with quick-select tags and a free-text note.
class ReflectionBlock extends StatelessWidget {
  const ReflectionBlock({
    super.key,
    required this.question,
    required this.tags,
    required this.selected,
    required this.onToggle,
    required this.controller,
    required this.hint,
    this.fieldKey,
  });

  final String question;
  final List<String> tags;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final TextEditingController controller;
  final String hint;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(question, style: AppTypography.label),
          AppSpacing.gap12,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final tag in {...tags, ...selected})
                ChoiceTag(
                  label: reviewTagLabel(context, tag),
                  selected: selected.contains(tag),
                  onTap: () => onToggle(tag),
                ),
            ],
          ),
          AppSpacing.gap12,
          AppTextField(
            fieldKey: fieldKey,
            controller: controller,
            hint: hint,
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}

/// Ordered list of up to three priorities with add, edit, remove, reorder.
class PrioritiesEditor extends ConsumerWidget {
  const PrioritiesEditor({
    super.key,
    required this.priorities,
    required this.onChanged,
    this.max = 3,
  });

  final List<ReviewPriority> priorities;
  final ValueChanged<List<ReviewPriority>> onChanged;
  final int max;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final goals = ref.watch(goalsProvider).value ?? const <Goal>[];
    String? goalTitle(String? id) =>
        id == null ? null : goals.where((g) => g.id == id).firstOrNull?.title;

    Future<void> edit(int? index) async {
      final result = await showPrioritySheet(
        context,
        initial: index == null ? null : priorities[index],
      );
      if (result == null) return;
      final next = [...priorities];
      if (index == null) {
        next.add(result);
      } else {
        next[index] = result;
      }
      onChanged(next);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (priorities.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(l.reviewPrioritiesEmpty, style: AppTypography.caption),
          ),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          onReorderItem: (from, to) {
            final next = [...priorities];
            final item = next.removeAt(from);
            next.insert(to, item);
            onChanged(next);
          },
          children: [
            for (final (i, p) in priorities.indexed)
              Padding(
                key: ValueKey('priority-$i-${p.title}'),
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
                  onTap: () => edit(i),
                  child: Row(
                    children: [
                      Text(
                        (i + 1).toString().padLeft(2, '0'),
                        style: AppTypography.cardTitle.copyWith(
                          color: AppColors.primaryStrong,
                        ),
                      ),
                      AppSpacing.gap12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.title, style: AppTypography.bodyMedium),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: p.area.label(context),
                                    style: AppTypography.captionSmall.copyWith(
                                      color: p.area.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (goalTitle(p.goal) case final title?)
                                    TextSpan(
                                      text: ' · $title',
                                      style: AppTypography.captionSmall,
                                    ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: l.reviewPriorityRemove,
                        icon: const Icon(
                          Symbols.close,
                          size: 18,
                          color: AppColors.textMuted,
                        ),
                        onPressed: () =>
                            onChanged([...priorities]..removeAt(i)),
                      ),
                      ReorderableDragStartListener(
                        index: i,
                        child: Semantics(
                          label: l.reviewPriorityReorder('${i + 1}'),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Symbols.drag_indicator,
                              size: 20,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        if (priorities.length < max)
          AddRowButton(
            key: const Key('review-add-priority'),
            label: l.reviewPrioritiesAdd,
            onTap: () => edit(null),
          )
        else
          Text(l.reviewPrioritiesMax, style: AppTypography.captionSmall),
      ],
    );
  }
}

Future<ReviewPriority?> showPrioritySheet(
  BuildContext context, {
  ReviewPriority? initial,
}) => showAppSheet<ReviewPriority>(
  context,
  builder: (_) => _PrioritySheet(initial: initial),
);

class _PrioritySheet extends ConsumerStatefulWidget {
  const _PrioritySheet({this.initial});

  final ReviewPriority? initial;

  @override
  ConsumerState<_PrioritySheet> createState() => _PrioritySheetState();
}

class _PrioritySheetState extends ConsumerState<_PrioritySheet> {
  late final _title = TextEditingController(text: widget.initial?.title);
  late LifeArea _area = widget.initial?.area ?? LifeArea.work;
  late String? _goal = widget.initial?.goal;

  @override
  void initState() {
    super.initState();
    _title.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final goals = (ref.watch(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    final actions = ref.watch(goalActionsProvider).value ?? const [];
    final areaGoals = goals.where((g) => g.area == _area).toList();
    return AppBottomSheet(
      title: widget.initial == null
          ? l.reviewPrioritiesAdd
          : l.reviewPriorityEdit,
      action: PrimaryButton(
        key: const Key('priority-save'),
        label: l.commonSave,
        icon: Symbols.check,
        onPressed: _title.text.trim().isEmpty
            ? null
            : () => Navigator.of(context).pop(
                ReviewPriority(
                  title: _title.text.trim(),
                  area: _area,
                  goal: _goal,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (goals.isNotEmpty && widget.initial == null) ...[
            FieldLabel(label: l.reviewPrioritySuggested),
            AppSpacing.gap8,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final g in goals.take(4))
                  ChoiceTag(
                    label: g.title,
                    selected: _goal == g.id,
                    color: g.area.color,
                    soft: g.area.soft,
                    onTap: () {
                      final next = nextActionOf(
                        actions.where((a) => a.goalId == g.id).toList(),
                        now,
                        weekStart: weekStart,
                      );
                      _title.text = next?.title ?? g.title;
                      setState(() {
                        _area = g.area;
                        _goal = g.id;
                      });
                    },
                  ),
              ],
            ),
            AppSpacing.gap20,
          ],
          AppTextField(
            fieldKey: const Key('priority-title'),
            label: l.reviewPriorityTitle,
            hint: l.reviewPriorityHint,
            controller: _title,
            autofocus: widget.initial != null || goals.isEmpty,
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.reviewPriorityArea),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final area in LifeArea.values)
                ChoiceTag(
                  label: area.label(context),
                  selected: _area == area,
                  color: area.color,
                  soft: area.soft,
                  onTap: () => setState(() {
                    if (_area != area) _goal = null;
                    _area = area;
                  }),
                ),
            ],
          ),
          if (areaGoals.isNotEmpty) ...[
            AppSpacing.gap20,
            FieldLabel(label: l.reviewPriorityGoal),
            AppSpacing.gap8,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                ChoiceTag(
                  label: l.reviewPriorityNoGoal,
                  selected: _goal == null,
                  onTap: () => setState(() => _goal = null),
                ),
                for (final g in areaGoals)
                  ChoiceTag(
                    label: g.title,
                    selected: _goal == g.id,
                    color: g.area.color,
                    soft: g.area.soft,
                    onTap: () => setState(() => _goal = g.id),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Formats a goal movement amount for display.
String movementLabel(Goal goal, double amount) =>
    goalValue(goal, amount, compact: true);

class WinRow extends StatelessWidget {
  const WinRow({super.key, required this.win, this.index, this.dense = false});

  final ReviewWin win;
  final int? index;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final area = win.area;
    final (title, detail) = switch (win.kind) {
      WinKind.goalCompleted => (win.title, l.reviewWinGoalCompleted),
      WinKind.milestone => (
        win.title,
        win.detail == null
            ? l.reviewWinMilestone
            : l.reviewWinMilestoneOf(win.detail!),
      ),
      WinKind.goalMoved => (
        win.title,
        l.reviewWinMoved(movementLabel(win.goal!, win.amount!)),
      ),
      WinKind.consistency => (
        l.reviewWinConsistency(area!.label(context), win.days!),
        l.reviewWinConsistencyBody,
      ),
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index != null)
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.successSoft,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: AppTypography.captionSmall.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          const Icon(
            Symbols.check_circle,
            fill: 1,
            size: 22,
            color: AppColors.success,
          ),
        AppSpacing.gap12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyMedium),
              const SizedBox(height: 2),
              Text.rich(
                TextSpan(
                  children: [
                    if (area != null && win.kind != WinKind.consistency)
                      TextSpan(
                        text: '${area.label(context)} · ',
                        style: AppTypography.captionSmall.copyWith(
                          color: area.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    TextSpan(text: detail, style: AppTypography.captionSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GapRow extends StatelessWidget {
  const GapRow({super.key, required this.gap, this.long = false});

  final ReviewGap gap;

  /// Long form spells out counts ("1 of 3 completed") instead of "1 / 3".
  final bool long;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final (icon, title, value) = switch (gap.kind) {
      GapKind.routineShort => (
        Symbols.schedule,
        gap.title,
        long
            ? l.reviewGapOf(Fmt.number(gap.done!), Fmt.number(gap.target!))
            : '${Fmt.number(gap.done!)} / ${Fmt.number(gap.target!)}',
      ),
      GapKind.noProgress => (
        Symbols.pause_circle,
        gap.title,
        long ? l.reviewGapNoProgress : l.reviewGapNoLog,
      ),
      GapKind.lowConsistency => (
        Symbols.trending_down,
        l.reviewGapLow(gap.area!.label(context)),
        Fmt.percent(gap.consistency!),
      ),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: gap.area?.color ?? AppColors.textMuted),
          AppSpacing.gap12,
          Expanded(child: Text(title, style: AppTypography.body)),
          AppSpacing.gap8,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.pillAll,
            ),
            child: Text(value, style: AppTypography.captionSmall),
          ),
        ],
      ),
    );
  }
}

/// Pinned footer with the primary review action.
class ReviewFooter extends StatelessWidget {
  const ReviewFooter({
    super.key,
    required this.primary,
    this.secondary,
    this.footnote,
  });

  final Widget primary;
  final Widget? secondary;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (footnote != null) ...[
                Text(
                  footnote!,
                  textAlign: TextAlign.center,
                  style: AppTypography.captionSmall,
                ),
                AppSpacing.gap8,
              ],
              primary,
              ?secondary,
            ],
          ),
        ),
      ),
    );
  }
}

Set<String> decodeTagSet(String raw) {
  try {
    return {...(jsonDecode(raw) as List).cast<String>()};
  } on FormatException {
    return {};
  }
}
