import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/number_input.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/pickers.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_link_field.dart';
import '../../settings/data/preferences.dart';
import '../../today/presentation/widgets/day_labels.dart';
import '../data/health_repository.dart';

Future<void> showWorkoutSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _WorkoutForm());

Future<void> showWalkSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _WalkForm());

Future<void> showSleepSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _SleepForm());

class _WorkoutForm extends ConsumerStatefulWidget {
  const _WorkoutForm();

  @override
  ConsumerState<_WorkoutForm> createState() => _WorkoutFormState();
}

class _WorkoutFormState extends ConsumerState<_WorkoutForm> {
  final _title = TextEditingController();
  final _detail = TextEditingController();
  int _minutes = 45;
  String? _goalChoice;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _title.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _title.dispose();
    _detail.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final goals = (ref.read(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    final detail = _detail.text.trim();
    await ref
        .read(healthRepositoryProvider)
        .logWorkout(
          title: _title.text,
          minutes: _minutes,
          detail: detail.isEmpty ? null : detail,
          goal: resolveLinkedGoal(goals, LifeArea.health, _goalChoice),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.workoutTitle,
      action: PrimaryButton(
        key: const Key('workout-save'),
        label: l.commonSave,
        icon: Symbols.check,
        color: AppColors.health,
        loading: _saving,
        onPressed: _title.text.trim().isEmpty || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('workout-title'),
            label: l.workoutName,
            hint: l.workoutNameHint,
            controller: _title,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.workoutDetail,
            trailingLabel: l.commonOptional,
            hint: l.workoutDetailHint,
            controller: _detail,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.workoutDuration),
          AppSpacing.gap8,
          NumberStepper(
            value: _minutes.toDouble(),
            step: 5,
            min: 5,
            max: 300,
            format: (v) => Fmt.minutes(v.round()),
            onChanged: (v) => setState(() => _minutes = v.round()),
          ),
          AppSpacing.gap20,
          GoalLinkField(
            area: LifeArea.health,
            choice: _goalChoice,
            onChanged: (c) => setState(() => _goalChoice = c),
          ),
        ],
      ),
    );
  }
}

class _WalkForm extends ConsumerStatefulWidget {
  const _WalkForm();

  @override
  ConsumerState<_WalkForm> createState() => _WalkFormState();
}

class _WalkFormState extends ConsumerState<_WalkForm> {
  final _steps = TextEditingController();
  int _minutes = 20;
  bool _saving = false;

  @override
  void dispose() {
    _steps.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final steps = parseNumber(_steps.text)?.round();
    await ref
        .read(healthRepositoryProvider)
        .logWalk(
          minutes: _minutes,
          steps: steps == null || steps <= 0 ? null : steps,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.walkTitle,
      action: PrimaryButton(
        key: const Key('walk-save'),
        label: l.commonSave,
        icon: Symbols.check,
        color: AppColors.health,
        loading: _saving,
        onPressed: _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(label: l.walkMinutes),
          AppSpacing.gap8,
          NumberStepper(
            value: _minutes.toDouble(),
            step: 5,
            min: 5,
            max: 300,
            format: (v) => Fmt.minutes(v.round()),
            onChanged: (v) => setState(() => _minutes = v.round()),
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.walkSteps,
            trailingLabel: l.commonOptional,
            hint: '0',
            controller: _steps,
            keyboardType: TextInputType.number,
            inputFormatters: numberInputFormatters,
          ),
        ],
      ),
    );
  }
}

class _SleepForm extends ConsumerStatefulWidget {
  const _SleepForm();

  @override
  ConsumerState<_SleepForm> createState() => _SleepFormState();
}

class _SleepFormState extends ConsumerState<_SleepForm> {
  int _bed = 23 * 60;
  int _wake = 6 * 60 + 30;
  Energy? _energy;
  bool _saving = false;

  /// Bed and wake as moments ending this morning; bedtimes after noon are
  /// the previous evening.
  (DateTime, DateTime) get _moments {
    final today = startOfDay(ref.read(clockProvider)());
    final wake = today.add(Duration(minutes: _wake));
    var bed = today.add(Duration(minutes: _bed));
    if (!bed.isBefore(wake)) bed = bed.subtract(const Duration(days: 1));
    return (bed, wake);
  }

  Future<void> _pick(bool bed) async {
    final minute = await pickMinuteOfDay(
      context,
      initial: bed ? _bed : _wake,
      use24h: ref.read(preferencesProvider).use24h,
    );
    if (minute == null) return;
    setState(() => bed ? _bed = minute : _wake = minute);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final (bed, wake) = _moments;
    await ref
        .read(healthRepositoryProvider)
        .logSleep(bedTime: bed, wakeTime: wake, energy: _energy);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final (bed, wake) = _moments;
    final minutes = wake.difference(bed).inMinutes;
    Widget timeTile(String label, int minute, bool isBed) => Expanded(
      child: OutlinedButton(
        onPressed: () => _pick(isBed),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
        child: Column(
          children: [
            Text(label, style: AppTypography.caption),
            Text(
              Fmt.timeOfDay(minute, use24h: use24h),
              style: AppTypography.headline.tabular,
            ),
          ],
        ),
      ),
    );
    return AppBottomSheet(
      title: l.sleepTitle,
      action: PrimaryButton(
        key: const Key('sleep-save'),
        label: l.commonSave,
        icon: Symbols.check,
        color: AppColors.health,
        loading: _saving,
        onPressed: _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              timeTile(l.sleepBed, _bed, true),
              AppSpacing.gap12,
              timeTile(l.sleepWake, _wake, false),
            ],
          ),
          AppSpacing.gap12,
          Center(
            child: Text(
              l.sleepDuration(Fmt.minutes(minutes)),
              style: AppTypography.caption,
            ),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.sleepEnergy, trailing: l.commonOptional),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final e in Energy.values)
                ChoiceTag(
                  label: energyLabel(context, e),
                  selected: _energy == e,
                  color: AppColors.health,
                  soft: AppColors.healthSoft,
                  onTap: () =>
                      setState(() => _energy = _energy == e ? null : e),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
