import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utilities/number_input.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/chips.dart';
import '../../data/goals_repository.dart';
import '../../domain/goal_progress.dart';
import '../goal_labels.dart';
import '../../../../core/utilities/bidi.dart';

String goalHealthLabel(BuildContext context, GoalHealth health) {
  final l = context.l10n;
  return switch (health) {
    GoalHealth.onTrack => l.healthOnTrack,
    GoalHealth.needsAttention => l.healthAttention,
    GoalHealth.completed => l.healthCompletedLabel,
    GoalHealth.paused => l.healthPausedLabel,
  };
}

class GoalHealthChip extends StatelessWidget {
  const GoalHealthChip({super.key, required this.health});

  final GoalHealth health;

  @override
  Widget build(BuildContext context) {
    return StatusChip(
      label: goalHealthLabel(context, health),
      dot: health != GoalHealth.completed,
      icon: health == GoalHealth.completed ? Symbols.done : null,
      tone: switch (health) {
        GoalHealth.onTrack => StatusTone.success,
        GoalHealth.needsAttention => StatusTone.danger,
        GoalHealth.completed => StatusTone.brand,
        GoalHealth.paused => StatusTone.neutral,
      },
    );
  }
}

PeriodKind? _periodOf(GoalFrequency f) => switch (f) {
  GoalFrequency.daily => PeriodKind.day,
  GoalFrequency.weekly => PeriodKind.week,
  GoalFrequency.monthly => PeriodKind.month,
  GoalFrequency.once => null,
};

/// Whether [action] has been completed within its current repeat period.
bool actionDone(GoalAction action, DateTime now, {int weekStart = 1}) {
  final last = action.lastCompletedAt;
  if (last == null) return false;
  final period = _periodOf(action.frequency);
  if (period == null) return true;
  return PeriodRange.of(period, now, weekStart: weekStart).contains(last);
}

GoalAction? nextActionOf(
  List<GoalAction> actions,
  DateTime now, {
  int weekStart = 1,
}) =>
    actions.where((a) => !actionDone(a, now, weekStart: weekStart)).firstOrNull;

/// Adds manual progress to a target or routine goal.
Future<bool> showLogProgressSheet(BuildContext context, Goal goal) async {
  final saved = await showAppSheet<bool>(
    context,
    builder: (_) => _LogProgressSheet(goal: goal),
  );
  return saved ?? false;
}

class _LogProgressSheet extends ConsumerStatefulWidget {
  const _LogProgressSheet({required this.goal});

  final Goal goal;

  @override
  ConsumerState<_LogProgressSheet> createState() => _LogProgressSheetState();
}

class _LogProgressSheetState extends ConsumerState<_LogProgressSheet> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  double _times = 1;
  bool _saving = false;

  bool get _routine => widget.goal.type == GoalType.routine;

  @override
  void initState() {
    super.initState();
    _amount.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  double? get _delta {
    if (_routine) return _times;
    final v = parseNumber(_amount.text);
    return v == null || v == 0 ? null : v;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final note = _note.text.trim();
    await ref
        .read(goalsRepositoryProvider)
        .logProgress(
          goal: widget.goal,
          delta: _delta!,
          note: note.isEmpty ? null : note,
        );
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final unit = widget.goal.unit.trim();
    return AppBottomSheet(
      title: l.goalLogTitle,
      subtitle: bidiSafe(widget.goal.title),
      action: PrimaryButton(
        key: const Key('goal-log-save'),
        label: l.goalLogSave,
        icon: Symbols.check,
        loading: _saving,
        onPressed: _delta == null || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_routine) ...[
            FieldLabel(label: l.goalLogTimes),
            AppSpacing.gap8,
            NumberStepper(
              value: _times,
              min: 1,
              max: 50,
              onChanged: (v) => setState(() => _times = v),
            ),
          ] else
            AppTextField(
              fieldKey: const Key('goal-log-amount'),
              label: l.goalLogAmount,
              hint: '0',
              controller: _amount,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: numberInputFormatters,
              suffixIcon: unit.isEmpty
                  ? null
                  : Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: AppSpacing.lg,
                      ),
                      child: Center(
                        widthFactor: 1,
                        child: Text(unitName(l, unit)),
                      ),
                    ),
            ),
          AppSpacing.gap16,
          AppTextField(
            label: l.goalLogNote,
            trailingLabel: l.commonOptional,
            hint: l.commonNotePlaceholder,
            controller: _note,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }
}
