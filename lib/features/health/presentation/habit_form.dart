import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/pickers.dart';
import '../../notifications/data/reminders_repository.dart';
import '../../settings/data/preferences.dart';
import '../data/health_repository.dart';
import '../domain/habit_names.dart';
import '../../../core/utilities/bidi.dart';

Future<void> showHabitSheet(
  BuildContext context, {
  bool startWithNew = false,
}) => showAppSheet<void>(
  context,
  builder: (_) => HabitForm(startWithNew: startWithNew),
);

/// Checks off today's habits, or adds a new one.
class HabitForm extends ConsumerStatefulWidget {
  const HabitForm({
    super.key,
    this.startWithNew = false,
    this.onBack,
    this.onSaved,
  });

  final bool startWithNew;
  final VoidCallback? onBack;
  final VoidCallback? onSaved;

  @override
  ConsumerState<HabitForm> createState() => _HabitFormState();
}

class _HabitFormState extends ConsumerState<HabitForm> {
  late bool _creating = widget.startWithNew;

  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitsProvider).value;
    final empty = habits != null && habits.isEmpty;
    if (_creating || empty) {
      return _NewHabit(
        onBack: empty ? widget.onBack : () => setState(() => _creating = false),
        onSaved: _onCreated,
      );
    }
    return _TodayHabits(
      habits: habits ?? const [],
      onBack: widget.onBack,
      onNew: () => setState(() => _creating = true),
      onDone: () {
        widget.onSaved?.call();
        if (widget.onSaved == null) Navigator.of(context).pop();
      },
    );
  }

  void _onCreated() {
    if (!mounted) return;
    setState(() => _creating = false);
  }
}

class _TodayHabits extends ConsumerWidget {
  const _TodayHabits({
    required this.habits,
    required this.onBack,
    required this.onNew,
    required this.onDone,
  });

  final List<Habit> habits;
  final VoidCallback? onBack;
  final VoidCallback onNew;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final dayKey = dayKeyOf(today);
    final logs =
        ref.watch(habitLogsProvider(PeriodRange.day(today))).value ?? const [];
    final done = {for (final log in logs) log.habitId};
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    final doneCount = habits.where((h) => done.contains(h.id)).length;
    return AppBottomSheet(
      title: l.habitQuickTitle,
      subtitle: l.habitDoneCount(doneCount, habits.length),
      leading: onBack == null ? null : SheetBackButton(onPressed: onBack!),
      showClose: onBack == null,
      action: PrimaryButton(
        key: const Key('habit-done'),
        label: l.commonDone,
        icon: Symbols.check,
        onPressed: onDone,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final habit in habits) ...[
            _HabitRow(
              habit: habit,
              done: done.contains(habit.id),
              reminder: habit.reminderMinute == null
                  ? null
                  : Fmt.timeOfDay(habit.reminderMinute!, use24h: use24h),
              onChanged: (v) => ref
                  .read(healthRepositoryProvider)
                  .setHabitDone(habit, dayKey, v),
            ),
            AppSpacing.gap8,
          ],
          AppSpacing.gap4,
          AddRowButton(
            key: const Key('habit-new'),
            label: l.habitNew,
            color: AppColors.health,
            onTap: onNew,
          ),
        ],
      ),
    );
  }
}

class _HabitRow extends StatelessWidget {
  const _HabitRow({
    required this.habit,
    required this.done,
    required this.reminder,
    required this.onChanged,
  });

  final Habit habit;
  final bool done;
  final String? reminder;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final area = habit.area;
    return Material(
      color: done ? area.soft : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardAll,
        side: BorderSide(
          color: done ? area.color.withValues(alpha: 0.3) : AppColors.border,
        ),
      ),
      child: InkWell(
        key: Key('habit-${habit.id}'),
        customBorder: const RoundedRectangleBorder(
          borderRadius: AppRadius.cardAll,
        ),
        onTap: () => onChanged(!done),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: area.soft,
                  shape: BoxShape.circle,
                ),
                child: Icon(area.icon, size: 18, color: area.color),
              ),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bidiSafe(habitDisplayName(context.l10n, habit)),
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        decoration: done ? TextDecoration.lineThrough : null,
                        decorationColor: AppColors.textMuted,
                      ),
                    ),
                    if (habit.label != null || reminder != null)
                      Text(
                        [?habit.label, ?reminder].join(' · '),
                        style: AppTypography.caption,
                      ),
                  ],
                ),
              ),
              Semantics(
                checked: done,
                child: Icon(
                  done ? Symbols.check_circle : Symbols.radio_button_unchecked,
                  fill: done ? 1 : 0,
                  color: done ? area.color : AppColors.textMuted,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewHabit extends ConsumerStatefulWidget {
  const _NewHabit({required this.onBack, required this.onSaved});

  final VoidCallback? onBack;
  final VoidCallback onSaved;

  @override
  ConsumerState<_NewHabit> createState() => _NewHabitState();
}

class _NewHabitState extends ConsumerState<_NewHabit> {
  final _name = TextEditingController();
  LifeArea _area = LifeArea.health;
  int? _reminder;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pickReminder() async {
    final minute = await pickMinuteOfDay(
      context,
      initial: _reminder ?? 8 * 60,
      use24h: ref.read(preferencesProvider).use24h,
    );
    if (minute != null) setState(() => _reminder = minute);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final id = await ref
        .read(healthRepositoryProvider)
        .addHabit(name: _name.text, area: _area, reminderMinute: _reminder);
    if (_reminder != null) {
      await ref
          .read(remindersRepositoryProvider)
          .upsertHabitReminder(habitId: id, minuteOfDay: _reminder!);
      await ref.read(notificationServiceProvider).requestPermission();
    }
    if (!mounted) return;
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final use24h = ref.watch(preferencesProvider.select((p) => p.use24h));
    return AppBottomSheet(
      title: l.habitNew,
      leading: widget.onBack == null
          ? null
          : SheetBackButton(onPressed: widget.onBack!),
      showClose: widget.onBack == null,
      action: PrimaryButton(
        key: const Key('habit-save'),
        label: l.habitAdd,
        icon: Symbols.check,
        color: AppColors.health,
        loading: _saving,
        onPressed: _name.text.trim().isEmpty || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('habit-name'),
            label: l.habitName,
            hint: l.habitNameHint,
            controller: _name,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.habitArea),
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
                  onTap: () => setState(() => _area = area),
                ),
            ],
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.habitReminder, trailing: l.commonOptional),
          AppSpacing.gap8,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickReminder,
                  icon: const Icon(Symbols.notifications, size: 18),
                  label: Text(
                    _reminder == null
                        ? l.habitNoReminder
                        : Fmt.timeOfDay(_reminder!, use24h: use24h),
                  ),
                ),
              ),
              if (_reminder != null)
                IconButton(
                  tooltip: l.commonDelete,
                  onPressed: () => setState(() => _reminder = null),
                  icon: const Icon(Symbols.close),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
