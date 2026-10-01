import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../profile/data/profile_repository.dart';
import '../data/daily_repository.dart';
import '../data/tasks_repository.dart';
import 'widgets/day_labels.dart';

class _Candidate {
  const _Candidate({this.task, required this.title, required this.area});

  final Task? task;
  final String title;
  final LifeArea area;

  String get key => task?.id ?? 'new:$title:${area.name}';
}

class MorningCheckInScreen extends ConsumerStatefulWidget {
  const MorningCheckInScreen({super.key});

  @override
  ConsumerState<MorningCheckInScreen> createState() =>
      _MorningCheckInScreenState();
}

class _MorningCheckInScreenState extends ConsumerState<MorningCheckInScreen> {
  final _intention = TextEditingController();
  Energy _energy = Energy.steady;
  Capacity _capacity = Capacity.balanced;
  final List<String> _selected = [];
  final List<_Candidate> _custom = [];
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _intention.dispose();
    super.dispose();
  }

  void _init(List<Task> tasks, MorningCheckIn? existing) {
    if (_initialized) return;
    _initialized = true;
    final priorities = tasks.where((t) => t.priorityRank != null).toList()
      ..sort((a, b) => a.priorityRank!.compareTo(b.priorityRank!));
    _selected.addAll(priorities.map((t) => t.id));
    if (existing != null) {
      _energy = existing.energy;
      _capacity = existing.capacity;
      _intention.text = existing.intention ?? '';
    }
  }

  void _toggle(_Candidate c) {
    setState(() {
      if (_selected.remove(c.key)) return;
      if (_selected.length >= 3) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(context.l10n.checkInMax)));
        return;
      }
      _selected.add(c.key);
    });
  }

  Future<void> _addCustom() async {
    final result = await showAppSheet<_Candidate>(
      context,
      builder: (_) => const _CustomPrioritySheet(),
    );
    if (result == null) return;
    setState(() {
      _custom.add(result);
      if (_selected.length < 3) _selected.add(result.key);
    });
  }

  Future<void> _save(List<Task> tasks) async {
    setState(() => _saving = true);
    final dayKey = ref.read(todayKeyProvider);
    final taskIds = tasks.map((t) => t.id).toSet();
    final customByKey = {for (final c in _custom) c.key: c};
    final existingIds = <String>[];
    final newOnes = <(String, LifeArea)>[];
    for (final key in _selected) {
      if (taskIds.contains(key)) {
        existingIds.add(key);
      } else if (customByKey[key] != null) {
        newOnes.add((customByKey[key]!.title, customByKey[key]!.area));
      }
    }
    await ref
        .read(dailyRepositoryProvider)
        .saveCheckIn(
          dayKey: dayKey,
          energy: _energy,
          capacity: _capacity,
          intention: _intention.text,
          priorityTaskIds: existingIds,
          newPriorities: newOnes,
        );
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dayKey = ref.watch(todayKeyProvider);
    final tasks = ref.watch(tasksForDayProvider(dayKey));
    final existing = ref.watch(checkInProvider(dayKey));
    final name = ref.watch(profileProvider).value?.name ?? '';
    final first = name.trim().split(RegExp(r'\s+')).first;

    return Scaffold(
      appBar: AppTopBar(
        title: l.checkInTitle,
        subtitle: l.checkInHint,
        closeIcon: true,
      ),
      body: AsyncView<List<Task>>(
        value: tasks,
        builder: (list) {
          if (!existing.hasValue) return const LoadingState();
          _init(list, existing.value);
          final candidates = [
            for (final t in list.where((t) => t.completedAt == null))
              _Candidate(task: t, title: t.title, area: t.area),
            ..._custom,
          ];
          final selected = [
            for (final key in _selected)
              ?candidates.where((c) => c.key == key).firstOrNull,
          ];
          final others = candidates.where((c) => !_selected.contains(c.key));
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.sm,
              AppSpacing.screen,
              AppSpacing.xxl,
            ),
            children: [
              Text(
                l.checkInHeadline(first),
                style: AppTypography.pageTitle.copyWith(fontSize: 26),
              ),
              AppSpacing.gap4,
              Text(
                l.checkInSub,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              AppSpacing.gap28,
              _SectionTitle(
                title: l.checkInEnergy,
                trailing: l.checkInEnergyHint,
              ),
              AppSpacing.gap12,
              Row(
                children: [
                  for (final (i, e) in Energy.values.indexed) ...[
                    if (i > 0) AppSpacing.gap8,
                    Expanded(
                      child: _EnergyTile(
                        energy: e,
                        selected: _energy == e,
                        onTap: () => setState(() => _energy = e),
                      ),
                    ),
                  ],
                ],
              ),
              AppSpacing.gap28,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.checkInPriorities,
                          style: AppTypography.sectionTitle,
                        ),
                        Text(
                          l.checkInPrioritiesHint,
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  StatusChip(
                    label: l.checkInSelected(selected.length),
                    tone: selected.length == 3
                        ? StatusTone.brand
                        : StatusTone.neutral,
                  ),
                ],
              ),
              AppSpacing.gap12,
              if (candidates.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text(l.checkInNoTasks, style: AppTypography.body),
                ),
              for (final (i, c) in selected.indexed)
                _PriorityOption(
                  candidate: c,
                  rank: i + 1,
                  onTap: () => _toggle(c),
                ),
              for (final c in others)
                _PriorityOption(candidate: c, onTap: () => _toggle(c)),
              AppTextButton(
                key: const Key('checkin-add-custom'),
                label: l.checkInAddCustom,
                icon: Symbols.add_circle,
                color: AppColors.primaryStrong,
                onPressed: _addCustom,
              ),
              AppSpacing.gap20,
              Text(l.checkInCapacity, style: AppTypography.sectionTitle),
              Text(l.checkInCapacityHint, style: AppTypography.caption),
              AppSpacing.gap12,
              for (final c in Capacity.values)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _CapacityOption(
                    capacity: c,
                    selected: _capacity == c,
                    onTap: () => setState(() => _capacity = c),
                  ),
                ),
              AppSpacing.gap20,
              AppTextField(
                label: l.checkInIntention,
                trailingLabel: l.commonOptional,
                hint: l.checkInIntentionHint,
                controller: _intention,
                maxLines: 3,
                minLines: 2,
              ),
              AppSpacing.gap28,
              PrimaryButton(
                key: const Key('checkin-start'),
                label: l.checkInStart,
                icon: Symbols.arrow_forward,
                loading: _saving,
                onPressed: _saving ? null : () => _save(list),
              ),
              AppSpacing.gap8,
              Center(
                child: AppTextButton(
                  label: l.checkInSkip,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTypography.sectionTitle)),
        if (trailing != null) Text(trailing!, style: AppTypography.caption),
      ],
    );
  }
}

class _EnergyTile extends StatelessWidget {
  const _EnergyTile({
    required this.energy,
    required this.selected,
    required this.onTap,
  });

  final Energy energy;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryStrong : AppColors.textBody;
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.small),
        height: 84,
        decoration: BoxDecoration(
          color: selected ? AppColors.brandSoft : AppColors.surface,
          borderRadius: AppRadius.cardAll,
          border: Border.all(
            color: selected
                ? AppColors.brand.withValues(alpha: 0.6)
                : AppColors.border,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.cardAll,
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(energyIcon(energy), color: color, size: 24),
                AppSpacing.gap8,
                Text(
                  energyLabel(context, energy),
                  style: AppTypography.bodyMedium.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriorityOption extends StatelessWidget {
  const _PriorityOption({
    required this.candidate,
    this.rank,
    required this.onTap,
  });

  final _Candidate candidate;
  final int? rank;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selected = rank != null;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 14,
        ),
        color: selected
            ? AppColors.surface
            : AppColors.surface.withValues(alpha: 0.7),
        shadow: selected,
        onTap: onTap,
        child: Row(
          children: [
            AnimatedContainer(
              duration: AppMotion.of(context, AppMotion.small),
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? AppColors.primaryStrong
                    : AppColors.surfaceMuted,
              ),
              child: selected
                  ? Text(
                      rank!.toString().padLeft(2, '0'),
                      style: AppTypography.captionSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : const Icon(
                      Symbols.add,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
            ),
            AppSpacing.gap12,
            Expanded(
              child: Text(
                candidate.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: selected ? AppColors.textPrimary : AppColors.textBody,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            CategoryChip(area: candidate.area, dot: false),
          ],
        ),
      ),
    );
  }
}

class _CapacityOption extends StatelessWidget {
  const _CapacityOption({
    required this.capacity,
    required this.selected,
    required this.onTap,
  });

  final Capacity capacity;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final hint = switch (capacity) {
      Capacity.light => l.capacityLightHint,
      Capacity.balanced => l.capacityBalancedHint,
      Capacity.focused => l.capacityFocusedHint,
    };
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.small),
        decoration: BoxDecoration(
          color: selected ? AppColors.brandSoft : AppColors.surface,
          borderRadius: AppRadius.cardAll,
          border: Border.all(
            color: selected
                ? AppColors.brand.withValues(alpha: 0.6)
                : AppColors.border,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.cardAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capacityLabel(context, capacity),
                          style: AppTypography.cardTitle.copyWith(
                            fontSize: selected ? 17 : 15,
                          ),
                        ),
                        Text(hint, style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Symbols.radio_button_checked
                        : Symbols.radio_button_unchecked,
                    color: selected
                        ? AppColors.primaryStrong
                        : AppColors.borderStrong,
                    fill: selected ? 1 : 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomPrioritySheet extends StatefulWidget {
  const _CustomPrioritySheet();

  @override
  State<_CustomPrioritySheet> createState() => _CustomPrioritySheetState();
}

class _CustomPrioritySheetState extends State<_CustomPrioritySheet> {
  final _title = TextEditingController();
  LifeArea _area = LifeArea.work;

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
    return AppBottomSheet(
      title: l.checkInCustomTitle,
      action: PrimaryButton(
        label: l.commonAdd,
        onPressed: _title.text.trim().isEmpty
            ? null
            : () =>
                  Navigator.of(context)
                      .pop(_Candidate(title: _title.text.trim(), area: _area)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('checkin-custom-title'),
            hint: l.checkInCustomHint,
            controller: _title,
            autofocus: true,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.taskArea),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final a in LifeArea.values)
                ChoiceTag(
                  label: a.label(context),
                  selected: a == _area,
                  color: a.color,
                  soft: a.soft,
                  onTap: () => setState(() => _area = a),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
