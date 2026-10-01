import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/input_sheets.dart';
import '../data/goals_repository.dart';
import '../domain/goal_units.dart';
import 'goal_labels.dart';

const _customUnit = '__custom__';

Future<String?> showUnitSheet(
  BuildContext context, {
  required String current,
  required String currency,
}) async {
  final l = context.l10n;
  final units = {currency, ...GoalUnits.common};
  final picked = await showOptionSheet<String>(
    context,
    title: l.goalUnit,
    selected: current,
    options: [
      for (final u in units) SheetOption(value: u, label: u),
      SheetOption(value: _customUnit, label: l.goalUnitCustom),
    ],
  );
  if (picked != _customUnit || !context.mounted) return picked;
  return showTextSheet(
    context,
    title: l.goalUnitCustom,
    hint: l.goalUnitCustomHint,
    initial: units.contains(current) ? null : current,
  );
}

Future<GoalActionDraft?> showActionSheet(
  BuildContext context, {
  GoalActionDraft? initial,
}) => showAppSheet<GoalActionDraft>(
  context,
  builder: (_) => _ActionSheet(initial: initial),
);

class _ActionSheet extends StatefulWidget {
  const _ActionSheet({this.initial});

  final GoalActionDraft? initial;

  @override
  State<_ActionSheet> createState() => _ActionSheetState();
}

class _ActionSheetState extends State<_ActionSheet> {
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _detail = TextEditingController(text: widget.initial?.detail);
  late GoalFrequency _frequency =
      widget.initial?.frequency ?? GoalFrequency.weekly;

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

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: widget.initial == null ? l.goalAddAction : l.goalEditAction,
      action: PrimaryButton(
        key: const Key('goal-action-save'),
        label: l.commonSave,
        onPressed: _title.text.trim().isEmpty
            ? null
            : () => Navigator.of(context).pop(
                GoalActionDraft(
                  id: widget.initial?.id,
                  title: _title.text.trim(),
                  detail: _detail.text.trim(),
                  frequency: _frequency,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('goal-action-title'),
            label: l.goalActionTitle,
            hint: l.goalActionTitleHint,
            controller: _title,
            autofocus: true,
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.goalActionDetail,
            trailingLabel: l.commonOptional,
            hint: l.goalActionDetailHint,
            controller: _detail,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.goalFrequency),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final f in GoalFrequency.values)
                ChoiceTag(
                  label: frequencyLabel(context, f),
                  selected: f == _frequency,
                  onTap: () => setState(() => _frequency = f),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
