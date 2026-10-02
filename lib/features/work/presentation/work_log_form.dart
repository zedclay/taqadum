import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
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
import '../data/work_repository.dart';

String workKindLabel(BuildContext context, WorkKind kind) =>
    workKindText(context.l10n, kind);

String workKindText(AppLocalizations l, WorkKind kind) => switch (kind) {
  WorkKind.deepWork => l.workDeepWork,
  WorkKind.lead => l.workLead,
  WorkKind.followUp => l.workFollowUp,
  WorkKind.meeting => l.workMeeting,
  WorkKind.proposal => l.workProposal,
  WorkKind.clientWon => l.workClientWon,
};

IconData workKindIcon(WorkKind kind) => switch (kind) {
  WorkKind.deepWork => Symbols.target,
  WorkKind.lead => Symbols.person_add,
  WorkKind.followUp => Symbols.forward_to_inbox,
  WorkKind.meeting => Symbols.groups,
  WorkKind.proposal => Symbols.description,
  WorkKind.clientWon => Symbols.handshake,
};

Future<void> showWorkLogSheet(
  BuildContext context, {
  WorkKind kind = WorkKind.deepWork,
  String? title,
  String? counterpart,
}) => showAppSheet<void>(
  context,
  builder: (_) =>
      WorkLogForm(kind: kind, title: title, counterpart: counterpart),
);

class WorkLogForm extends ConsumerStatefulWidget {
  const WorkLogForm({
    super.key,
    this.kind = WorkKind.deepWork,
    this.title,
    this.counterpart,
    this.onBack,
    this.onSaved,
  });

  final WorkKind kind;
  final String? title;
  final String? counterpart;
  final VoidCallback? onBack;
  final VoidCallback? onSaved;

  @override
  ConsumerState<WorkLogForm> createState() => _WorkLogFormState();
}

class _WorkLogFormState extends ConsumerState<WorkLogForm> {
  late WorkKind _kind = widget.kind;
  late final _title = TextEditingController(text: widget.title);
  late final _counterpart = TextEditingController(text: widget.counterpart);
  final _value = TextEditingController();
  int _minutes = 60;
  DateTime? _scheduledAt;
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
    _counterpart.dispose();
    _value.dispose();
    super.dispose();
  }

  bool get _hasCounterpart => _kind != WorkKind.deepWork;
  bool get _hasMinutes =>
      _kind == WorkKind.deepWork || _kind == WorkKind.meeting;
  bool get _hasValue =>
      _kind == WorkKind.lead ||
      _kind == WorkKind.proposal ||
      _kind == WorkKind.clientWon;
  bool get _hasSchedule =>
      _kind == WorkKind.meeting || _kind == WorkKind.followUp;

  String _titleHint(BuildContext context) {
    final l = context.l10n;
    return switch (_kind) {
      WorkKind.deepWork => l.workTitleDeepHint,
      WorkKind.lead => l.workTitleLeadHint,
      WorkKind.followUp => l.workTitleFollowHint,
      WorkKind.meeting => l.workTitleMeetingHint,
      WorkKind.proposal => l.workTitleProposalHint,
      WorkKind.clientWon => l.workTitleWonHint,
    };
  }

  Future<void> _pickSchedule() async {
    final use24h = ref.read(preferencesProvider).use24h;
    final now = DateTime.now();
    final date = await pickDate(
      context,
      initial: _scheduledAt ?? now,
      first: now.subtract(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;
    final base = _scheduledAt ?? now;
    final minute = await pickMinuteOfDay(
      context,
      initial: base.hour * 60 + base.minute,
      use24h: use24h,
    );
    if (minute == null) return;
    setState(
      () => _scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        minute ~/ 60,
        minute % 60,
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final goals = (ref.read(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    final value = _hasValue ? parseNumber(_value.text) : null;
    final counterpart = _counterpart.text.trim();
    await ref
        .read(workRepositoryProvider)
        .add(
          kind: _kind,
          title: _title.text.trim(),
          counterpart: _hasCounterpart && counterpart.isNotEmpty
              ? counterpart
              : null,
          valueMinor: value == null || value <= 0
              ? null
              : Fmt.majorToMinor(value),
          minutes: _hasMinutes ? _minutes : null,
          scheduledAt: _hasSchedule ? _scheduledAt : null,
          goal: resolveLinkedGoal(goals, LifeArea.work, _goalChoice),
        );
    if (!mounted) return;
    widget.onSaved?.call();
    if (widget.onSaved == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final prefs = ref.watch(preferencesProvider);
    return AppBottomSheet(
      title: l.workLogTitle,
      leading: widget.onBack == null
          ? null
          : SheetBackButton(onPressed: widget.onBack!),
      showClose: widget.onBack == null,
      action: PrimaryButton(
        key: const Key('work-save'),
        label: l.workSave,
        icon: Symbols.check,
        loading: _saving,
        onPressed: _title.text.trim().isEmpty || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final k in WorkKind.values)
                ChoiceTag(
                  key: Key('work-kind-${k.name}'),
                  label: workKindLabel(context, k),
                  selected: _kind == k,
                  color: AppColors.work,
                  soft: AppColors.workSoft,
                  onTap: () => setState(() => _kind = k),
                ),
            ],
          ),
          AppSpacing.gap20,
          AppTextField(
            fieldKey: const Key('work-title'),
            label: l.workTitle,
            hint: _titleHint(context),
            controller: _title,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
          ),
          if (_hasCounterpart) ...[
            AppSpacing.gap16,
            AppTextField(
              label: l.workCounterpart,
              trailingLabel: l.commonOptional,
              hint: l.workCounterpartHint,
              controller: _counterpart,
              textCapitalization: TextCapitalization.words,
            ),
          ],
          if (_hasMinutes) ...[
            AppSpacing.gap16,
            FieldLabel(label: l.workDuration),
            AppSpacing.gap8,
            NumberStepper(
              value: _minutes.toDouble(),
              step: 15,
              min: 15,
              max: 720,
              format: (v) => Fmt.minutes(v.round()),
              onChanged: (v) => setState(() => _minutes = v.round()),
            ),
          ],
          if (_hasValue) ...[
            AppSpacing.gap16,
            AppTextField(
              label: l.workValue,
              trailingLabel: l.commonOptional,
              hint: '0',
              controller: _value,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: numberInputFormatters,
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.lg),
                child: Center(widthFactor: 1, child: Text(prefs.currency)),
              ),
            ),
          ],
          if (_hasSchedule) ...[
            AppSpacing.gap16,
            FieldLabel(label: l.workWhen),
            AppSpacing.gap8,
            OutlinedButton.icon(
              onPressed: _pickSchedule,
              icon: const Icon(Symbols.event, size: 18),
              label: Text(
                _scheduledAt == null
                    ? l.workNow
                    : '${Fmt.shortWeekdayDayMonth(_scheduledAt!)} · '
                          '${Fmt.time(_scheduledAt!, use24h: prefs.use24h)}',
              ),
            ),
          ],
          AppSpacing.gap20,
          GoalLinkField(
            area: LifeArea.work,
            choice: _goalChoice,
            onChanged: (c) => setState(() => _goalChoice = c),
          ),
        ],
      ),
    );
  }
}
