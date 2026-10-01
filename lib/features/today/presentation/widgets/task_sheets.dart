import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utilities/formatters.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/chips.dart';
import '../../../../core/widgets/pickers.dart';
import '../../../settings/data/preferences.dart';
import '../../data/tasks_repository.dart';
import 'task_form.dart';

Future<void> showTaskSheet(
  BuildContext context, {
  Task? task,
  String? dayKey,
  LifeArea? area,
}) => showAppSheet<bool>(
  context,
  builder: (_) => TaskForm(task: task, dayKey: dayKey, area: area),
);

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Actions for a single task: done, edit, reschedule, priority, delete.
Future<void> showTaskOptions(
  BuildContext context,
  WidgetRef ref,
  Task task, {
  List<Task> dayTasks = const [],
}) async {
  final l = context.l10n;
  final done = task.completedAt != null;
  final isPriority = task.priorityRank != null;
  final action = await showAppSheet<String>(
    context,
    builder: (sheetContext) => AppBottomSheet(
      title: task.title,
      child: Column(
        children: [
          _OptionRow(
            icon: done ? Symbols.radio_button_unchecked : Symbols.check_circle,
            label: done ? l.taskMarkUndone : l.taskMarkDone,
            value: 'toggle',
          ),
          _OptionRow(icon: Symbols.edit, label: l.commonEdit, value: 'edit'),
          _OptionRow(
            icon: Symbols.event_repeat,
            label: l.taskReschedule,
            value: 'reschedule',
          ),
          _OptionRow(
            icon: Symbols.flag,
            label: isPriority ? l.taskRemovePriority : l.taskMakePriority,
            value: 'priority',
          ),
          _OptionRow(
            icon: Symbols.delete,
            label: l.taskDelete,
            value: 'delete',
            color: AppColors.danger,
          ),
        ],
      ),
    ),
  );
  if (action == null || !context.mounted) return;
  final repo = ref.read(tasksRepositoryProvider);
  switch (action) {
    case 'toggle':
      await repo.setDone(task, !done);
    case 'edit':
      await showTaskSheet(context, task: task);
    case 'reschedule':
      await showRescheduleSheet(context, ref, task);
    case 'priority':
      final current =
          dayTasks
              .where((t) => t.priorityRank != null && t.id != task.id)
              .toList()
            ..sort((a, b) => a.priorityRank!.compareTo(b.priorityRank!));
      if (isPriority) {
        await repo.setPriorities(
          task.dayKey,
          current.map((t) => t.id).toList(),
        );
      } else if (current.length >= 3) {
        if (context.mounted) _toast(context, l.taskPriorityFull);
      } else {
        await repo.setPriorities(task.dayKey, [
          ...current.map((t) => t.id),
          task.id,
        ]);
      }
    case 'delete':
      final ok = await showConfirmDialog(
        context,
        title: l.taskDeleteTitle,
        message: l.taskDeleteBody,
        confirmLabel: l.commonDelete,
        destructive: true,
      );
      if (ok) {
        await repo.delete(task);
        if (context.mounted) _toast(context, l.taskDeleted);
      }
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.icon,
    required this.label,
    required this.value,
    this.color = AppColors.textPrimary,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      minTileHeight: 52,
      leading: Icon(
        icon,
        color: color == AppColors.textPrimary ? AppColors.textSecondary : color,
      ),
      title: Text(
        label,
        style: AppTypography.bodyMedium.copyWith(color: color),
      ),
      onTap: () => Navigator.of(context).pop(value),
    );
  }
}

Future<void> showRescheduleSheet(
  BuildContext context,
  WidgetRef ref,
  Task task,
) => showAppSheet<void>(context, builder: (_) => _RescheduleSheet(task: task));

class _RescheduleSheet extends ConsumerStatefulWidget {
  const _RescheduleSheet({required this.task});

  final Task task;

  @override
  ConsumerState<_RescheduleSheet> createState() => _RescheduleSheetState();
}

enum _When { laterToday, tomorrow, nextWeek, custom }

class _RescheduleSheetState extends ConsumerState<_RescheduleSheet> {
  _When? _when;
  DateTime? _custom;
  late int? _minute = widget.task.scheduledMinute;

  String _targetKey() {
    final today = ref.read(currentDayProvider);
    final weekStart = ref.read(preferencesProvider).weekStart;
    return switch (_when) {
      _When.laterToday => dayKeyOf(today),
      _When.tomorrow => dayKeyOf(addDays(today, 1)),
      _When.nextWeek => dayKeyOf(
        PeriodRange.week(today, weekStart: weekStart).next.start,
      ),
      _When.custom => dayKeyOf(_custom!),
      null => widget.task.dayKey,
    };
  }

  Future<void> _pickTime() async {
    final minute = await pickMinuteOfDay(
      context,
      initial: _minute ?? 15 * 60,
      use24h: ref.read(preferencesProvider).use24h,
    );
    if (minute != null) setState(() => _minute = minute);
  }

  Future<void> _confirm() async {
    final key = _targetKey();
    await ref
        .read(tasksRepositoryProvider)
        .reschedule(widget.task, dayKey: key, minute: () => _minute);
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final label = context.l10n.rescheduledTo(
      Fmt.weekdayDayMonth(dateOfKey(key)),
    );
    Navigator.of(context).pop();
    messenger.showSnackBar(SnackBar(content: Text(label)));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final isToday = widget.task.dayKey == ref.watch(todayKeyProvider);
    return AppBottomSheet(
      title: l.rescheduleTitle,
      subtitle: l.rescheduleSubtitle,
      action: PrimaryButton(
        key: const Key('reschedule-confirm'),
        label: l.rescheduleConfirm,
        icon: Symbols.arrow_forward,
        onPressed: _when == null ? null : _confirm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (isToday)
                ChoiceTag(
                  label: l.rescheduleLaterToday,
                  selected: _when == _When.laterToday,
                  onTap: () async {
                    setState(() => _when = _When.laterToday);
                    await _pickTime();
                  },
                ),
              ChoiceTag(
                label: l.rescheduleTomorrow,
                selected: _when == _When.tomorrow,
                onTap: () => setState(() => _when = _When.tomorrow),
              ),
              ChoiceTag(
                label: l.rescheduleNextWeek,
                selected: _when == _When.nextWeek,
                onTap: () => setState(() => _when = _When.nextWeek),
              ),
              ChoiceTag(
                label: _custom == null
                    ? l.reschedulePick
                    : Fmt.dayMonth(_custom!),
                selected: _when == _When.custom,
                onTap: () async {
                  final date = await pickDate(
                    context,
                    initial: addDays(ref.read(currentDayProvider), 1),
                    first: ref.read(currentDayProvider),
                  );
                  if (date != null) {
                    setState(() {
                      _custom = date;
                      _when = _When.custom;
                    });
                  }
                },
              ),
            ],
          ),
          AppSpacing.gap20,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Symbols.schedule,
              color: AppColors.primaryStrong,
            ),
            title: Text(l.taskTime, style: AppTypography.bodyMedium),
            trailing: Text(
              _minute == null
                  ? l.taskAnytime
                  : Fmt.timeOfDay(_minute!, use24h: use24h),
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primaryStrong,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: _pickTime,
          ),
        ],
      ),
    );
  }
}
