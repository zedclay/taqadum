import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utilities/formatters.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/area_style.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/chips.dart';
import '../../../../core/widgets/pickers.dart';
import '../../../goals/data/goals_repository.dart';
import '../../../settings/data/preferences.dart';
import '../../data/tasks_repository.dart';
import '../../../../core/utilities/bidi.dart';

const taskDurations = [15, 30, 45, 60, 90, 120];

/// Create or edit a task. Used standalone and inside Quick Add.
class TaskForm extends ConsumerStatefulWidget {
  const TaskForm({
    super.key,
    this.task,
    this.dayKey,
    this.area,
    this.onBack,
    this.onSaved,
  });

  final Task? task;
  final String? dayKey;
  final LifeArea? area;
  final VoidCallback? onBack;
  final VoidCallback? onSaved;

  @override
  ConsumerState<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends ConsumerState<TaskForm> {
  late final _title = TextEditingController(text: widget.task?.title);
  late final _detail = TextEditingController(text: widget.task?.badge);
  late LifeArea _area = widget.task?.area ?? widget.area ?? LifeArea.work;
  late String _dayKey =
      widget.task?.dayKey ?? widget.dayKey ?? ref.read(todayKeyProvider);
  late int? _minute = widget.task?.scheduledMinute;
  late int? _duration = widget.task?.durationMinutes;
  late String? _goalId = widget.task?.goalId;
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
    final title = _title.text.trim();
    if (title.isEmpty) return;
    setState(() => _saving = true);
    final repo = ref.read(tasksRepositoryProvider);
    final detail = _detail.text.trim().isEmpty ? null : _detail.text.trim();
    final task = widget.task;
    if (task == null) {
      await repo.add(
        TaskDraft(
          title: title,
          area: _area,
          dayKey: _dayKey,
          goalId: _goalId,
          scheduledMinute: _minute,
          durationMinutes: _duration,
          badge: detail,
        ),
      );
    } else {
      await repo.update(
        task.copyWith(
          title: title,
          area: _area,
          dayKey: _dayKey,
          goalId: Value(_goalId),
          scheduledMinute: Value(_minute),
          durationMinutes: Value(_duration),
          badge: Value(detail),
          priorityRank: _dayKey == task.dayKey
              ? Value(task.priorityRank)
              : const Value(null),
        ),
      );
    }
    if (!mounted) return;
    widget.onSaved?.call();
    if (widget.onSaved == null) Navigator.of(context).pop(true);
  }

  Future<void> _pickDate() async {
    final date = await pickDate(context, initial: dateOfKey(_dayKey));
    if (date != null) setState(() => _dayKey = dayKeyOf(date));
  }

  Future<void> _pickTime() async {
    final use24h = ref.read(preferencesProvider).use24h;
    final minute = await pickMinuteOfDay(
      context,
      initial: _minute ?? 9 * 60,
      use24h: use24h,
    );
    if (minute != null) setState(() => _minute = minute);
  }

  Future<void> _pickGoal(List<Goal> goals) async {
    final l = context.l10n;
    final picked = await showOptionSheet<String>(
      context,
      title: l.taskGoal,
      selected: _goalId ?? '',
      options: [
        SheetOption(value: '', label: l.taskNoGoal),
        for (final g in goals)
          SheetOption(
            value: g.id,
            label: bidiSafe(g.title),
            subtitle: g.area.label(context),
          ),
      ],
    );
    if (picked != null) {
      setState(() => _goalId = picked.isEmpty ? null : picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final todayKey = ref.watch(todayKeyProvider);
    final tomorrowKey = dayKeyOf(addDays(dateOfKey(todayKey), 1));
    final goals =
        (ref.watch(goalsProvider).value ?? const <Goal>[])
            .where((g) => g.status == GoalStatus.active)
            .toList()
          ..sort(
            (a, b) =>
                (b.area == _area ? 1 : 0).compareTo(a.area == _area ? 1 : 0),
          );
    final goal = goals.where((g) => g.id == _goalId).firstOrNull;
    final customDay = _dayKey != todayKey && _dayKey != tomorrowKey;

    return AppBottomSheet(
      title: widget.task == null ? l.taskNew : l.taskEdit,
      leading: widget.onBack == null
          ? null
          : CircleIconButton(
              icon: Symbols.arrow_back,
              tooltip: l.commonBack,
              background: Colors.transparent,
              size: 36,
              onPressed: widget.onBack,
            ),
      showClose: widget.onBack == null,
      action: PrimaryButton(
        key: const Key('task-save'),
        label: widget.task == null ? l.taskAdd : l.taskSave,
        icon: Symbols.arrow_forward,
        loading: _saving,
        onPressed: _title.text.trim().isEmpty || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('task-title'),
            label: l.taskTitle,
            hint: l.taskTitleHint,
            controller: _title,
            autofocus: widget.task == null,
            textInputAction: TextInputAction.done,
          ),
          AppSpacing.gap20,
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
          AppSpacing.gap20,
          FieldLabel(label: l.taskSchedule),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ChoiceTag(
                label: l.commonToday,
                selected: _dayKey == todayKey,
                onTap: () => setState(() => _dayKey = todayKey),
              ),
              ChoiceTag(
                label: l.commonTomorrow,
                selected: _dayKey == tomorrowKey,
                onTap: () => setState(() => _dayKey = tomorrowKey),
              ),
              ChoiceTag(
                label: customDay
                    ? Fmt.dayMonth(dateOfKey(_dayKey))
                    : l.taskPickDate,
                selected: customDay,
                onTap: _pickDate,
              ),
            ],
          ),
          AppSpacing.gap12,
          Row(
            children: [
              Expanded(
                child: _OptionTile(
                  icon: Symbols.schedule,
                  label: l.taskTime,
                  value: _minute == null
                      ? l.taskAnytime
                      : Fmt.timeOfDay(_minute!, use24h: use24h),
                  onTap: _pickTime,
                  onClear: _minute == null
                      ? null
                      : () => setState(() => _minute = null),
                ),
              ),
            ],
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.taskDuration),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ChoiceTag(
                label: l.taskNoDuration,
                selected: _duration == null,
                onTap: () => setState(() => _duration = null),
              ),
              for (final d in taskDurations)
                ChoiceTag(
                  label: Fmt.minutes(d),
                  selected: _duration == d,
                  onTap: () => setState(() => _duration = d),
                ),
            ],
          ),
          AppSpacing.gap20,
          AppTextField(
            label: l.taskDetail,
            trailingLabel: l.commonOptional,
            hint: l.taskDetailHint,
            controller: _detail,
          ),
          if (goals.isNotEmpty) ...[
            AppSpacing.gap16,
            _OptionTile(
              icon: Symbols.track_changes,
              label: l.taskGoal,
              value: goal?.title ?? l.taskNoGoal,
              onTap: () => _pickGoal(goals),
              chevron: true,
            ),
          ],
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
    this.chevron = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final VoidCallback? onClear;
  final bool chevron;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceMuted,
      borderRadius: AppRadius.cardAll,
      child: InkWell(
        borderRadius: AppRadius.cardAll,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 8, 10),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryStrong, size: 20),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTypography.caption),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onClear != null)
                IconButton(
                  tooltip: context.l10n.commonDelete,
                  onPressed: onClear,
                  icon: const Icon(
                    Symbols.close,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                )
              else if (chevron)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Symbols.chevron_right,
                    color: AppColors.textMuted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
