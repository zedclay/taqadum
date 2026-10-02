import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/number_input.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/input_sheets.dart';
import '../../../core/widgets/pickers.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/segmented.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../auth/data/session_controller.dart';
import '../../settings/data/preferences.dart';
import '../data/goals_repository.dart';
import '../domain/goal_units.dart';
import 'goal_editor_sheets.dart';
import 'goal_labels.dart';

class GoalEditorScreen extends ConsumerStatefulWidget {
  const GoalEditorScreen({super.key, this.goalId, this.setupFlow = false});

  final String? goalId;
  final bool setupFlow;

  static const setupGoalCount = 3;

  @override
  ConsumerState<GoalEditorScreen> createState() => _GoalEditorScreenState();
}

class _GoalEditorScreenState extends ConsumerState<GoalEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _target = TextEditingController();
  final _why = TextEditingController();
  final _scroll = ScrollController();

  late LifeArea _area;
  GoalType _type = GoalType.target;
  String _unit = '';
  double _start = 0;
  DateTime? _date;
  GoalFrequency _frequency = GoalFrequency.weekly;
  int _periodTarget = 3;
  List<GoalActionDraft> _actions = [];
  List<MilestoneDraft> _milestones = [];
  bool _makePrimary = false;
  bool _wasPrimary = false;

  bool _loading = false;
  bool _saving = false;
  bool _dirty = false;
  int _savedCount = 0;
  String? _milestoneError;

  bool get _editing => widget.goalId != null;

  @override
  void initState() {
    super.initState();
    _resetForm();
    for (final c in [_title, _target, _why]) {
      c.addListener(_markDirty);
    }
    if (_editing) _load();
  }

  void _markDirty() {
    if (!_dirty) setState(() => _dirty = true);
  }

  void _resetForm() {
    final currency = ref.read(preferencesProvider).currency;
    _area = LifeArea.finance;
    _type = GoalType.target;
    _unit = GoalUnits.defaultFor(_area, currency);
    _start = 0;
    _date = null;
    _frequency = GoalFrequency.weekly;
    _periodTarget = 3;
    _actions = [];
    _milestones = [];
    _makePrimary = false;
    _title.clear();
    _target.clear();
    _why.clear();
    _dirty = false;
    _milestoneError = null;
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final repo = ref.read(goalsRepositoryProvider);
    final goal = await repo.getGoal(widget.goalId!);
    if (goal == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final actions = await repo.actionsFor(goal.id);
    final milestones = await repo.milestonesFor(goal.id);
    if (!mounted) return;
    setState(() {
      _title.text = goal.title;
      _area = goal.area;
      _type = goal.type;
      _unit = goal.unit;
      _start = goal.startValue;
      _target.text = goal.targetValue > 0
          ? editableNumber(goal.targetValue)
          : '';
      _date = goal.targetDate?.toLocal();
      _why.text = goal.why ?? '';
      _frequency = goal.frequency == GoalFrequency.once
          ? GoalFrequency.weekly
          : goal.frequency;
      _periodTarget = goal.periodTarget;
      _wasPrimary = goal.isPrimary;
      _makePrimary = goal.isPrimary;
      _actions = [
        for (final a in actions)
          GoalActionDraft(
            id: a.id,
            title: a.title,
            detail: a.detail,
            frequency: a.frequency,
          ),
      ];
      _milestones = [
        for (final m in milestones)
          MilestoneDraft(
            id: m.id,
            title: m.title,
            completed: m.completedAt != null,
          ),
      ];
      _dirty = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _target.dispose();
    _why.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _set(VoidCallback change) => setState(() {
    change();
    _dirty = true;
  });

  double get _targetValue => parseNumber(_target.text) ?? 0;

  String _fmtValue(double v) => unitQuantity(
    context.l10n,
    _unit,
    v,
    Fmt.number(v, maxDecimals: GoalUnits.isCurrency(_unit) ? 0 : 2),
  );

  Future<void> _save() async {
    final l = context.l10n;
    final valid = _formKey.currentState!.validate();
    final milestonesOk = _type != GoalType.milestone || _milestones.isNotEmpty;
    setState(() => _milestoneError = milestonesOk ? null : l.goalErrMilestones);
    if (!valid || !milestonesOk) return;
    setState(() => _saving = true);
    final draft = GoalDraft(
      id: widget.goalId,
      title: _title.text,
      area: _area,
      type: _type,
      unit: _type == GoalType.milestone ? '' : _unit,
      targetValue: switch (_type) {
        GoalType.target => _targetValue,
        GoalType.routine => _periodTarget.toDouble(),
        GoalType.milestone => _milestones.length.toDouble(),
      },
      startValue: _type == GoalType.target ? _start : 0,
      frequency: _type == GoalType.routine ? _frequency : GoalFrequency.once,
      periodTarget: _periodTarget,
      targetDate: _type == GoalType.routine ? null : _date,
      why: _why.text,
      actions: _actions,
      milestones: _type == GoalType.milestone ? _milestones : const [],
      makePrimary: _makePrimary && !_wasPrimary,
    );
    try {
      final id = await ref.read(goalsRepositoryProvider).save(draft);
      if (!mounted) return;
      if (widget.setupFlow) {
        _savedCount++;
        if (_savedCount >= GoalEditorScreen.setupGoalCount) {
          await _finishSetup();
          return;
        }
        setState(() {
          _resetForm();
          _saving = false;
        });
        _scroll.jumpTo(0);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.goalSavedNext)));
      } else if (_editing) {
        _dirty = false;
        context.pop();
      } else {
        _dirty = false;
        context.pushReplacement(AppRoutes.goal(id));
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.commonSomethingWrong)));
    }
  }

  Future<void> _finishSetup() =>
      ref.read(sessionProvider.notifier).completeGoalSetup();

  Future<void> _pickArea() async {
    final l = context.l10n;
    final area = await showOptionSheet<LifeArea>(
      context,
      title: l.goalCategory,
      selected: _area,
      options: [
        for (final a in LifeArea.values)
          SheetOption(value: a, label: a.longLabel(context)),
      ],
    );
    if (area == null || area == _area) return;
    final currency = ref.read(preferencesProvider).currency;
    _set(() {
      final wasDefault =
          _unit.isEmpty || _unit == GoalUnits.defaultFor(_area, currency);
      _area = area;
      if (wasDefault) _unit = GoalUnits.defaultFor(area, currency);
    });
  }

  Future<void> _pickUnit() async {
    final unit = await showUnitSheet(
      context,
      current: _unit,
      currency: ref.read(preferencesProvider).currency,
    );
    if (unit != null) _set(() => _unit = unit);
  }

  Future<void> _editStart() async {
    final value = await showNumberSheet(
      context,
      title: context.l10n.goalStartingPoint,
      hint: context.l10n.goalStartingPointHint,
      initial: _start,
      suffix: unitName(context.l10n, _unit),
    );
    if (value != null) _set(() => _start = value);
  }

  Future<void> _pickDate() async {
    final now = ref.read(clockProvider)();
    final date = await pickDate(
      context,
      initial: _date ?? DateTime(now.year, 12, 31),
      first: DateTime(now.year, now.month, now.day),
      last: DateTime(now.year + 30),
    );
    if (date != null) _set(() => _date = date);
  }

  Future<void> _editAction([int? index]) async {
    final result = await showActionSheet(
      context,
      initial: index == null ? null : _actions[index],
    );
    if (result == null) return;
    _set(() {
      if (index == null) {
        _actions = [..._actions, result];
      } else {
        _actions = [..._actions]..[index] = result;
      }
    });
  }

  Future<void> _addMilestone() async {
    final title = await showTextSheet(
      context,
      title: context.l10n.goalAddMilestone,
      hint: context.l10n.goalMilestoneHint,
    );
    if (title == null) return;
    _set(() {
      _milestones = [..._milestones, MilestoneDraft(title: title)];
      _milestoneError = null;
    });
  }

  Future<bool> _confirmDiscard() async {
    if (!_dirty || widget.setupFlow) return true;
    final l = context.l10n;
    return showConfirmDialog(
      context,
      title: l.commonUnsavedTitle,
      message: l.commonUnsavedBody,
      confirmLabel: l.commonDiscard,
      destructive: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final setup = widget.setupFlow;
    return PopScope(
      canPop: !_dirty || setup,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmDiscard() && context.mounted) {
          setState(() => _dirty = false);
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppTopBar(
          title: setup
              ? l.goalSetupHeader
              : (_editing ? l.goalEditTitle : l.goalNewTitle),
          showBack: !setup,
          closeIcon: !setup,
          actions: [
            if (setup)
              AppTextButton(
                key: const Key('goal-setup-skip'),
                label: l.commonSkip,
                onPressed: _saving ? null : _finishSetup,
              ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
        body: _loading
            ? const LoadingState()
            : Form(
                key: _formKey,
                child: ListView(
                  controller: _scroll,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.screen,
                    AppSpacing.sm,
                    AppSpacing.screen,
                    AppSpacing.xxl,
                  ),
                  children: [
                    if (setup) ...[
                      _SetupProgress(index: _savedCount),
                      AppSpacing.gap20,
                      Text(l.goalSetupHeadline, style: AppTypography.headline),
                      AppSpacing.gap4,
                      Text(l.goalSetupSub, style: AppTypography.body),
                      AppSpacing.gap20,
                    ],
                    _detailsCard(),
                    AppSpacing.gap28,
                    if (_type == GoalType.milestone) ...[
                      _milestonesSection(),
                      AppSpacing.gap28,
                    ],
                    _actionsSection(),
                    if (_type == GoalType.target) ...[
                      AppSpacing.gap20,
                      _trajectory(),
                    ],
                  ],
                ),
              ),
        bottomNavigationBar: _loading ? null : _bottomBar(),
      ),
    );
  }

  Widget _bottomBar() {
    final l = context.l10n;
    final setup = widget.setupFlow;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screen,
          AppSpacing.md,
          AppSpacing.screen,
          AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              key: const Key('goal-save'),
              label: setup ? l.goalSaveContinue : l.goalSave,
              icon: setup ? Symbols.arrow_forward : Symbols.check,
              loading: _saving,
              onPressed: _saving ? null : _save,
            ),
            if (setup && _savedCount > 0)
              AppTextButton(
                key: const Key('goal-setup-finish'),
                label: l.goalFinishSetup,
                onPressed: _saving ? null : _finishSetup,
              )
            else if (!setup)
              AppTextButton(
                label: l.commonCancel,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailsCard() {
    final l = context.l10n;
    return AppCard.hero(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('goal-title'),
            label: l.goalTitleLabel,
            hint: l.goalTitleHint,
            controller: _title,
            textInputAction: TextInputAction.next,
            suffixIcon: const Icon(
              Symbols.edit,
              color: AppColors.textMuted,
              size: 20,
            ),
            validator: (v) => (v ?? '').trim().isEmpty ? l.goalErrTitle : null,
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.goalCategory),
          AppSpacing.gap8,
          _SelectField(
            key: const Key('goal-category'),
            onTap: _pickArea,
            leading: IconTile(
              icon: _area.icon,
              color: _area.color,
              background: _area.soft,
              size: 32,
              iconSize: 18,
              radius: AppRadius.sm,
              fill: true,
            ),
            label: _area.longLabel(context),
            trailingIcon: Symbols.expand_more,
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.goalType),
          AppSpacing.gap8,
          SegmentedPills<GoalType>(
            values: GoalType.values,
            selected: _type,
            labelOf: (t) => goalTypeLabel(context, t),
            onChanged: (t) => _set(() => _type = t),
          ),
          AppSpacing.gap8,
          Text(goalTypeHint(context, _type), style: AppTypography.caption),
          AppSpacing.gap20,
          ...switch (_type) {
            GoalType.target => _targetFields(),
            GoalType.routine => _routineFields(),
            GoalType.milestone => const <Widget>[],
          },
          if (_type != GoalType.routine) ...[
            FieldLabel(label: l.goalTargetDate),
            AppSpacing.gap8,
            _SelectField(
              key: const Key('goal-date'),
              onTap: _pickDate,
              leading: const Icon(
                Symbols.calendar_today,
                color: AppColors.primaryStrong,
                size: 20,
              ),
              label: _date == null ? l.goalNoDate : Fmt.dayMonthYear(_date!),
              muted: _date == null,
              trailing: _date == null
                  ? null
                  : Pill(
                      label: timeLeftLabel(
                        context,
                        _date!,
                        now: ref.watch(currentDayProvider),
                      ),
                      dense: true,
                    ),
            ),
            if (_date != null)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: AppTextButton(
                  label: l.goalClearDate,
                  onPressed: () => _set(() => _date = null),
                ),
              )
            else
              AppSpacing.gap20,
          ],
          AppTextField(
            fieldKey: const Key('goal-why'),
            label: l.goalWhy,
            hint: l.goalWhyHint,
            controller: _why,
            maxLines: 4,
            minLines: 2,
          ),
          if (!widget.setupFlow || _savedCount > 0) ...[
            AppSpacing.gap12,
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _makePrimary,
              title: Text(l.goalMakePrimary, style: AppTypography.bodyMedium),
              onChanged: _wasPrimary
                  ? null
                  : (v) => _set(() => _makePrimary = v),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _targetFields() {
    final l = context.l10n;
    final target = _targetValue;
    final ratio = target <= 0 ? 0.0 : (_start / target).clamp(0.0, 1.0);
    return [
      FieldLabel(label: l.goalTargetUnit),
      AppSpacing.gap8,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AppTextField(
              fieldKey: const Key('goal-target'),
              hint: '600,000',
              controller: _target,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: numberInputFormatters,
              style: AppTypography.metric.copyWith(fontSize: 20),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                final value = parseNumber(v);
                if (value == null || value <= 0 || value <= _start) {
                  return l.goalErrTarget;
                }
                return null;
              },
            ),
          ),
          AppSpacing.gap8,
          SizedBox(
            width: 116,
            child: _SelectField(
              key: const Key('goal-unit'),
              onTap: _pickUnit,
              label: _unit.isEmpty ? l.goalUnit : unitName(l, _unit),
              muted: _unit.isEmpty,
              trailingIcon: Symbols.unfold_more,
              compact: true,
            ),
          ),
        ],
      ),
      AppSpacing.gap12,
      Material(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.cardAll,
        child: InkWell(
          key: const Key('goal-start'),
          borderRadius: AppRadius.cardAll,
          onTap: _editStart,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      l.goalStartingPoint,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Symbols.edit,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const Spacer(),
                    Text(
                      _fmtValue(_start),
                      style: AppTypography.bodyMedium
                          .copyWith(
                            color: AppColors.primaryStrong,
                            fontWeight: FontWeight.w700,
                          )
                          .tabular,
                    ),
                  ],
                ),
                if (target > 0) ...[
                  AppSpacing.gap12,
                  AppProgressBar(value: ratio, trackColor: AppColors.border),
                  AppSpacing.gap8,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.goalAccumulated('${(ratio * 1000).round() / 10}%'),
                          style: AppTypography.caption,
                        ),
                      ),
                      Text(
                        l.goalRemaining(
                          _fmtValue(
                            (target - _start).clamp(0, double.infinity),
                          ),
                        ),
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      AppSpacing.gap20,
    ];
  }

  List<Widget> _routineFields() {
    final l = context.l10n;
    return [
      FieldLabel(label: l.goalRoutineEvery),
      AppSpacing.gap8,
      SegmentedPills<GoalFrequency>(
        values: const [
          GoalFrequency.daily,
          GoalFrequency.weekly,
          GoalFrequency.monthly,
        ],
        selected: _frequency,
        labelOf: (f) => frequencyLabel(context, f),
        onChanged: (f) => _set(() => _frequency = f),
      ),
      AppSpacing.gap20,
      FieldLabel(label: l.goalRoutineTimes),
      AppSpacing.gap8,
      NumberStepper(
        value: _periodTarget.toDouble(),
        min: 1,
        max: 99,
        onChanged: (v) => _set(() => _periodTarget = v.round()),
      ),
      AppSpacing.gap20,
      FieldLabel(label: l.goalUnit, trailing: l.commonOptional),
      AppSpacing.gap8,
      _SelectField(
        onTap: _pickUnit,
        label: _unit.isEmpty ? l.goalUnit : unitName(l, _unit),
        muted: _unit.isEmpty,
        trailingIcon: Symbols.unfold_more,
      ),
      AppSpacing.gap20,
    ];
  }

  Widget _milestonesSection() {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.goalMilestonesTitle, style: AppTypography.sectionTitle),
        const SizedBox(height: 2),
        Text(l.goalMilestonesSubtitle, style: AppTypography.body),
        AppSpacing.gap12,
        for (var i = 0; i < _milestones.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: AppCard(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 4, 4),
              child: Row(
                children: [
                  Icon(
                    _milestones[i].completed
                        ? Symbols.check_circle
                        : Symbols.flag,
                    color: _milestones[i].completed
                        ? AppColors.success
                        : AppColors.textSecondary,
                    size: 20,
                    fill: _milestones[i].completed ? 1 : 0,
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Text(
                      _milestones[i].title,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l.commonDelete,
                    icon: const Icon(Symbols.close, size: 20),
                    color: AppColors.textMuted,
                    onPressed: () =>
                        _set(() => _milestones = [..._milestones]..removeAt(i)),
                  ),
                ],
              ),
            ),
          ),
        if (_milestoneError != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              _milestoneError!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ),
        AddRowButton(label: l.goalAddMilestone, onTap: _addMilestone),
      ],
    );
  }

  Widget _actionsSection() {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.goalActionsTitle, style: AppTypography.sectionTitle),
        const SizedBox(height: 2),
        Text(l.goalActionsSubtitle, style: AppTypography.body),
        AppSpacing.gap12,
        for (var i = 0; i < _actions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: AppCard(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 4, 12),
              onTap: () => _editAction(i),
              child: Row(
                children: [
                  IconTile(
                    icon: _actions[i].frequency == GoalFrequency.daily
                        ? Symbols.today
                        : Symbols.event_repeat,
                    color: _area.color,
                    background: _area.soft,
                    size: 32,
                    iconSize: 18,
                    radius: AppRadius.sm,
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _actions[i].title,
                          style: AppTypography.cardTitle.copyWith(fontSize: 15),
                        ),
                        if ((_actions[i].detail ?? '').isNotEmpty)
                          Text(
                            _actions[i].detail!,
                            style: AppTypography.caption,
                          ),
                      ],
                    ),
                  ),
                  Pill(
                    label: frequencyLabel(context, _actions[i].frequency),
                    dense: true,
                  ),
                  PopupMenuButton<String>(
                    tooltip: l.commonMore,
                    icon: const Icon(
                      Symbols.more_vert,
                      color: AppColors.textSecondary,
                    ),
                    onSelected: (v) {
                      if (v == 'edit') {
                        _editAction(i);
                      } else {
                        _set(() => _actions = [..._actions]..removeAt(i));
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'edit', child: Text(l.commonEdit)),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(l.commonDelete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        AddRowButton(
          key: const Key('goal-add-action'),
          label: l.goalAddAction,
          onTap: () => _editAction(),
        ),
      ],
    );
  }

  Widget _trajectory() {
    final l = context.l10n;
    final target = _targetValue;
    final String message;
    if (target > 0 && _start >= target) {
      message = l.goalTrajectoryDone;
    } else if (_date == null || target <= 0) {
      message = l.goalTrajectoryNoDate;
    } else {
      final now = ref.watch(clockProvider)();
      final months = ((_date!.difference(now).inDays) / 30.44).clamp(
        1.0,
        double.infinity,
      );
      final perMonth = (target - _start) / months;
      message = l.goalTrajectoryBody(
        Fmt.dayMonthYear(_date!),
        _fmtValue(perMonth),
      );
    }
    return AppCard(
      child: Row(
        children: [
          IconTile(
            icon: Symbols.trending_up,
            color: _area.color,
            background: _area.soft,
            size: 44,
            iconSize: 22,
          ),
          AppSpacing.gap12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.goalTrajectoryTitle.toUpperCase(),
                  style: AppTypography.overline.copyWith(
                    color: AppColors.primaryStrong,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SetupProgress extends StatelessWidget {
  const _SetupProgress({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    const total = GoalEditorScreen.setupGoalCount;
    final pct = ((index + 1) / total * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              l.goalSetupCounter(index + 1, total),
              style: AppTypography.label.copyWith(color: AppColors.textPrimary),
            ),
            const Spacer(),
            Text(l.goalSetupPercent(pct), style: AppTypography.caption),
          ],
        ),
        AppSpacing.gap8,
        AppProgressBar(
          value: (index + 1) / total,
          color: AppColors.brand,
          trackColor: AppColors.border,
          height: 6,
        ),
      ],
    );
  }
}

class _SelectField extends StatelessWidget {
  const _SelectField({
    super.key,
    required this.onTap,
    required this.label,
    this.leading,
    this.trailing,
    this.trailingIcon,
    this.muted = false,
    this.compact = false,
  });

  final VoidCallback onTap;
  final String label;
  final Widget? leading;
  final Widget? trailing;
  final IconData? trailingIcon;
  final bool muted;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.inputAll,
        side: BorderSide(color: AppColors.borderStrong),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const RoundedRectangleBorder(
          borderRadius: AppRadius.inputAll,
        ),
        child: SizedBox(
          height: AppSpacing.inputHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? AppSpacing.md : AppSpacing.lg,
            ),
            child: Row(
              children: [
                if (leading != null) ...[leading!, AppSpacing.gap12],
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyLarge.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: muted
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                ?trailing,
                if (trailingIcon != null)
                  Icon(trailingIcon, color: AppColors.textSecondary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
