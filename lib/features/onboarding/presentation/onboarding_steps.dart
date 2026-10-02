import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/ids.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/pickers.dart';
import '../../settings/data/preferences.dart';
import '../domain/onboarding_draft.dart';

/// Adds a custom starter target for one of the selected areas.
Future<StarterTarget?> showCustomTargetSheet(
  BuildContext context,
  List<LifeArea> areas,
) => showAppSheet<StarterTarget>(
  context,
  builder: (_) => CustomTargetSheet(areas: areas),
);

String onboardingAreaTitle(BuildContext context, LifeArea area) {
  final l = context.l10n;
  return switch (area) {
    LifeArea.quran => l.onbAreaQuran,
    LifeArea.work => l.onbAreaWork,
    LifeArea.finance => l.onbAreaFinance,
    LifeArea.health => l.onbAreaHealth,
    LifeArea.learning => l.onbAreaLearning,
    LifeArea.personal => l.onbAreaPersonal,
  };
}

String _areaHint(BuildContext context, LifeArea area) {
  final l = context.l10n;
  return switch (area) {
    LifeArea.quran => l.onbAreaQuranHint,
    LifeArea.work => l.onbAreaWorkHint,
    LifeArea.finance => l.onbAreaFinanceHint,
    LifeArea.health => l.onbAreaHealthHint,
    LifeArea.learning => l.onbAreaLearningHint,
    LifeArea.personal => l.onbAreaPersonalHint,
  };
}

String paceLabel(BuildContext context, DayPace pace) {
  final l = context.l10n;
  return switch (pace) {
    DayPace.morningFocus => l.paceMorning,
    DayPace.balanced => l.paceBalanced,
    DayPace.adaptive => l.paceAdaptive,
  };
}

String _paceHint(BuildContext context, DayPace pace) {
  final l = context.l10n;
  return switch (pace) {
    DayPace.morningFocus => l.paceMorningHint,
    DayPace.balanced => l.paceBalancedHint,
    DayPace.adaptive => l.paceAdaptiveHint,
  };
}

class _StepScroll extends StatelessWidget {
  const _StepScroll({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Text(title, style: AppTypography.pageTitle),
        AppSpacing.gap8,
        Text(
          subtitle,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSpacing.gap24,
        ...children,
      ],
    );
  }
}

class AreasStep extends StatelessWidget {
  const AreasStep({super.key, required this.draft, required this.onChanged});

  final OnboardingDraft draft;
  final ValueChanged<OnboardingDraft> onChanged;

  void _toggle(LifeArea area) {
    final next = {...draft.areas};
    if (!next.remove(area)) next.add(area);
    onChanged(draft.copyWith(areas: next));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
    return _StepScroll(
      title: l.onbAreasTitle,
      subtitle: l.onbAreasSubtitle,
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.2 / textScale.clamp(1.0, 1.5),
          children: [
            for (final area in LifeArea.values)
              _AreaCard(
                area: area,
                selected: draft.areas.contains(area),
                onTap: () => _toggle(area),
              ),
          ],
        ),
      ],
    );
  }
}

class _AreaCard extends StatelessWidget {
  const _AreaCard({
    required this.area,
    required this.selected,
    required this.onTap,
  });

  final LifeArea area;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.of(context, AppMotion.small);
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: duration,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.heroAll,
          border: Border.all(
            color: selected ? AppColors.brand : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            key: Key('area-${area.name}'),
            borderRadius: AppRadius.heroAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconTile(
                        icon: area.icon,
                        color: selected ? area.color : AppColors.textBody,
                        background: selected
                            ? area.soft
                            : AppColors.surfaceMuted,
                        size: 44,
                        iconSize: 22,
                        fill: true,
                      ),
                      const Spacer(),
                      AnimatedOpacity(
                        duration: duration,
                        opacity: selected ? 1 : 0,
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.brand,
                          child: Icon(
                            Symbols.check,
                            size: 16,
                            color: Colors.white,
                            weight: 700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    onboardingAreaTitle(context, area),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _areaHint(context, area),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body,
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

class TargetsStep extends StatelessWidget {
  const TargetsStep({super.key, required this.draft, required this.onChanged});

  final OnboardingDraft draft;
  final ValueChanged<OnboardingDraft> onChanged;

  void _toggle(String id) {
    final next = {...draft.targetIds};
    if (!next.remove(id)) next.add(id);
    onChanged(draft.copyWith(targetIds: next));
  }

  Future<void> _addCustom(BuildContext context) async {
    final target = await showCustomTargetSheet(context, draft.orderedAreas);
    if (target == null) return;
    onChanged(
      draft.copyWith(
        customTargets: [...draft.customTargets, target],
        targetIds: {...draft.targetIds, target.id},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final all = [...starterTargetsFor(l), ...draft.customTargets];
    return _StepScroll(
      title: l.onbTargetsTitle,
      subtitle: l.onbTargetsSubtitle,
      children: [
        for (final area in draft.orderedAreas) ...[
          Row(
            children: [
              Icon(area.icon, size: 18, color: area.color, fill: 1),
              AppSpacing.gap8,
              Text(
                area.longLabel(context),
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          AppSpacing.gap8,
          for (final target in all.where((t) => t.area == area))
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _TargetRow(
                label: target.label,
                selected: draft.targetIds.contains(target.id),
                onTap: () => _toggle(target.id),
              ),
            ),
          AppSpacing.gap12,
        ],
        AddRowButton(label: l.onbAddCustom, onTap: () => _addCustom(context)),
      ],
    );
  }
}

class _TargetRow extends StatelessWidget {
  const _TargetRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.of(context, AppMotion.small),
      decoration: BoxDecoration(
        color: selected ? AppColors.brandSoft : AppColors.surface,
        borderRadius: AppRadius.cardAll,
        border: Border.all(
          color: selected
              ? AppColors.brand.withValues(alpha: 0.5)
              : AppColors.border,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: AppRadius.cardAll,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 52),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: AppMotion.of(context, AppMotion.small),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primaryStrong
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: selected
                            ? AppColors.primaryStrong
                            : AppColors.borderStrong,
                        width: 1.5,
                      ),
                    ),
                    child: selected
                        ? const Icon(
                            Symbols.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
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

class CustomTargetSheet extends StatefulWidget {
  const CustomTargetSheet({super.key, required this.areas});

  final List<LifeArea> areas;

  @override
  State<CustomTargetSheet> createState() => _CustomTargetSheetState();
}

class _CustomTargetSheetState extends State<CustomTargetSheet> {
  final _label = TextEditingController();
  late LifeArea _area = widget.areas.firstOrNull ?? LifeArea.personal;

  @override
  void initState() {
    super.initState();
    _label.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final areas = widget.areas.isEmpty ? LifeArea.values : widget.areas;
    return AppBottomSheet(
      title: l.onbCustomTitle,
      action: PrimaryButton(
        label: l.onbCustomAdd,
        onPressed: _label.text.trim().isEmpty
            ? null
            : () => Navigator.of(context).pop(
                StarterTarget(
                  'custom-${newId()}',
                  _area,
                  _label.text.trim(),
                  custom: true,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: l.onbCustomTitle,
            hint: l.onbCustomHint,
            controller: _label,
            autofocus: true,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.onbCustomArea),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final area in areas)
                ChoiceTag(
                  label: area.label(context),
                  selected: area == _area,
                  color: area.color,
                  soft: area.soft,
                  onTap: () => setState(() => _area = area),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaceStep extends ConsumerWidget {
  const PaceStep({super.key, required this.draft, required this.onChanged});

  final OnboardingDraft draft;
  final ValueChanged<OnboardingDraft> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    Future<void> pick(bool morning) async {
      final minute = await pickMinuteOfDay(
        context,
        initial: morning ? draft.morningMinute : draft.eveningMinute,
        use24h: use24h,
      );
      if (minute == null) return;
      onChanged(
        morning
            ? draft.copyWith(morningMinute: minute)
            : draft.copyWith(eveningMinute: minute),
      );
    }

    return _StepScroll(
      title: l.onbPaceTitle,
      subtitle: l.onbPaceSubtitle,
      children: [
        for (final pace in DayPace.values)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _PaceCard(
              title: paceLabel(context, pace),
              hint: _paceHint(context, pace),
              icon: switch (pace) {
                DayPace.morningFocus => Symbols.wb_twilight,
                DayPace.balanced => Symbols.balance,
                DayPace.adaptive => Symbols.autorenew,
              },
              selected: draft.pace == pace,
              onTap: () => onChanged(draft.copyWith(pace: pace)),
            ),
          ),
        AppSpacing.gap12,
        Text(l.onbCheckpoints, style: AppTypography.sectionTitle),
        AppSpacing.gap12,
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xs,
          ),
          child: Column(
            children: [
              _CheckpointRow(
                icon: Symbols.wb_twilight,
                label: l.onbMorningCheckpoint,
                time: Fmt.timeOfDay(draft.morningMinute, use24h: use24h),
                enabled: draft.morningOn,
                onTime: () => pick(true),
                onToggle: (v) => onChanged(draft.copyWith(morningOn: v)),
              ),
              const Divider(height: 1),
              _CheckpointRow(
                icon: Symbols.nightlight,
                label: l.onbEveningCheckpoint,
                time: Fmt.timeOfDay(draft.eveningMinute, use24h: use24h),
                enabled: draft.eveningOn,
                onTime: () => pick(false),
                onToggle: (v) => onChanged(draft.copyWith(eveningOn: v)),
              ),
            ],
          ),
        ),
        AppSpacing.gap8,
        Text(l.onbCheckpointHint, style: AppTypography.caption),
      ],
    );
  }
}

class _PaceCard extends StatelessWidget {
  const _PaceCard({
    required this.title,
    required this.hint,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String hint;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.small),
        decoration: BoxDecoration(
          color: selected ? AppColors.brandSoft : AppColors.surface,
          borderRadius: AppRadius.cardAll,
          border: Border.all(
            color: selected ? AppColors.brand : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.cardAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  IconTile(
                    icon: icon,
                    color: selected
                        ? AppColors.primaryStrong
                        : AppColors.textBody,
                    background: selected
                        ? AppColors.surface
                        : AppColors.surfaceMuted,
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTypography.cardTitle),
                        const SizedBox(height: 2),
                        Text(hint, style: AppTypography.body),
                      ],
                    ),
                  ),
                  AppSpacing.gap8,
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

class _CheckpointRow extends StatelessWidget {
  const _CheckpointRow({
    required this.icon,
    required this.label,
    required this.time,
    required this.enabled,
    required this.onTime,
    required this.onToggle,
  });

  final IconData icon;
  final String label;
  final String time;
  final bool enabled;
  final VoidCallback onTime;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryStrong, size: 22),
          AppSpacing.gap12,
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: onTime,
            child: Text(
              time,
              style: AppTypography.bodyMedium
                  .copyWith(
                    color: enabled
                        ? AppColors.primaryStrong
                        : AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  )
                  .tabular,
            ),
          ),
          Switch(value: enabled, onChanged: onToggle),
        ],
      ),
    );
  }
}

class ReadyStep extends StatelessWidget {
  const ReadyStep({super.key, required this.draft});

  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final targets = draft.selectedTargets(starterTargetsFor(l));
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.xl,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        const Center(
          child: IconTile(
            icon: Symbols.verified,
            color: AppColors.primaryStrong,
            background: AppColors.brandSoft,
            size: 72,
            iconSize: 36,
            radius: 36,
            fill: true,
          ),
        ),
        AppSpacing.gap20,
        Text(
          l.onbReadyTitle,
          textAlign: TextAlign.center,
          style: AppTypography.pageTitle,
        ),
        AppSpacing.gap8,
        Text(
          l.onbReadySubtitle,
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSpacing.gap24,
        AppCard.hero(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.onbFocusAreas.toUpperCase(),
                style: AppTypography.overline,
              ),
              AppSpacing.gap12,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final area in draft.orderedAreas)
                    CategoryChip(area: area, icon: true, dot: false),
                ],
              ),
              AppSpacing.gap20,
              const Divider(height: 1),
              AppSpacing.gap20,
              Text(
                l.onbFirstTargets.toUpperCase(),
                style: AppTypography.overline,
              ),
              AppSpacing.gap12,
              if (targets.isEmpty)
                Text(l.onbNoTargets, style: AppTypography.body)
              else
                for (final t in targets)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        const Icon(
                          Symbols.check_circle,
                          color: AppColors.success,
                          size: 20,
                          fill: 1,
                        ),
                        AppSpacing.gap8,
                        Expanded(
                          child: Text(
                            t.label,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              AppSpacing.gap12,
              const Divider(height: 1),
              AppSpacing.gap16,
              Row(
                children: [
                  Text(l.onbDailyPace, style: AppTypography.body),
                  AppSpacing.gap8,
                  Pill(
                    label: paceLabel(context, draft.pace),
                    foreground: AppColors.primaryStrong,
                    background: AppColors.brandSoft,
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.gap20,
        Text(
          l.onbReadyNote,
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
