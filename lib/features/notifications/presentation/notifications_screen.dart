import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/relative_time.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/insight_card.dart';
import '../../../core/widgets/pickers.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../../core/widgets/top_bar.dart';
import '../../health/data/health_repository.dart';
import '../../health/presentation/habit_form.dart';
import '../../settings/data/preferences.dart';
import '../data/reminder_scheduler.dart';
import '../data/reminders_repository.dart';
import '../domain/reminder_planner.dart';

final notificationPermissionProvider = FutureProvider.autoDispose<bool?>(
  (ref) => ref.watch(notificationServiceProvider).permissionGranted(),
);

String weekdaysLabel(BuildContext context, int mask) {
  final l = context.l10n;
  if (mask == 127) return l.notifDaily;
  if (mask == 0x1F) return l.notifWeekdays;
  return [
    for (var d = DateTime.monday; d <= DateTime.sunday; d++)
      if (maskHas(mask, d)) DateFormat.E().format(DateTime(2024, 1, d)),
  ].join(' · ');
}

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final reminders = ref.watch(remindersProvider);
    return Scaffold(
      appBar: AppTopBar(title: l.notifTitle),
      body: AsyncView<List<Reminder>>(
        value: reminders,
        builder: (list) => _Body(reminders: list),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.reminders});

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final prefs = ref.watch(preferencesProvider);
    final habits = (ref.watch(habitsProvider).value ?? const <Habit>[])
        .where((h) => !h.archived)
        .toList();
    final byId = {for (final r in reminders) r.id: r};
    final habitNames = {for (final h in habits) h.id: h.name};
    final habitReminders =
        reminders
            .where(
              (r) =>
                  r.kind == ReminderKind.habit &&
                  habitNames.containsKey(r.habitId),
            )
            .toList()
          ..sort((a, b) => a.minuteOfDay.compareTo(b.minuteOfDay));
    final active = reminders
        .where(
          (r) =>
              r.enabled &&
              (r.kind != ReminderKind.habit ||
                  habitNames.containsKey(r.habitId)),
        )
        .length;
    String time(int m) => Fmt.timeOfDay(m, use24h: prefs.use24h);
    final quietRange = '${time(prefs.quietStart)} – ${time(prefs.quietEnd)}';

    Widget tile(
      String id, {
      required IconData icon,
      required Color color,
      required String title,
      required String body,
      bool editDays = true,
    }) {
      final r = byId[id];
      if (r == null) return const SizedBox.shrink();
      return _ReminderTile(
        reminder: r,
        icon: icon,
        color: color,
        title: title,
        body: body,
        editDays: editDays,
      );
    }

    final weekly = byId[ReminderIds.weeklyReview];
    final monthly = byId[ReminderIds.monthlyReview];

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.sm,
        AppSpacing.screen,
        AppSpacing.huge,
      ),
      children: [
        Text(l.notifHeadline, style: AppTypography.pageTitle),
        AppSpacing.gap4,
        Text(l.notifSubtitle, style: AppTypography.body),
        AppSpacing.gap12,
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Pill(
            dot: true,
            label: prefs.notificationsOn
                ? [
                    l.notifActiveCount(active),
                    if (prefs.quietEnabled) l.notifQuietActive(quietRange),
                  ].join(' · ')
                : l.notifPaused,
            foreground: prefs.notificationsOn
                ? AppColors.primaryStrong
                : AppColors.textSecondary,
            background: prefs.notificationsOn
                ? AppColors.brandSoft
                : AppColors.surfaceMuted,
            dense: true,
          ),
        ),
        AppSpacing.gap16,
        AppCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.notifAll, style: AppTypography.sectionTitle),
                    AppSpacing.gap4,
                    Text(l.notifAllBody, style: AppTypography.caption),
                  ],
                ),
              ),
              AppSpacing.gap12,
              Switch(
                key: const Key('notif-master'),
                value: prefs.notificationsOn,
                onChanged: (v) async {
                  await ref
                      .read(preferencesProvider.notifier)
                      .setNotificationsOn(v);
                  if (v) await _ensurePermission(ref);
                },
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: prefs.notificationsOn ? 1 : 0.55,
          duration: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Section(
                title: l.notifDailyRoutine,
                children: [
                  tile(
                    ReminderIds.morningCheckIn,
                    icon: Symbols.wb_sunny,
                    color: AppColors.warning,
                    title: l.reminderMorningTitle,
                    body: l.notifMorningBody,
                  ),
                  tile(
                    ReminderIds.nightReview,
                    icon: Symbols.bedtime,
                    color: AppColors.info,
                    title: l.reminderNightTitle,
                    body: l.notifNightBody,
                  ),
                ],
              ),
              _Section(
                title: l.notifQuranSection,
                children: [
                  tile(
                    ReminderIds.quranReading,
                    icon: Symbols.auto_stories,
                    color: AppColors.quran,
                    title: l.notifQuranReading,
                    body: l.notifQuranReadingBody,
                  ),
                  tile(
                    ReminderIds.quranMemorization,
                    icon: Symbols.psychology,
                    color: AppColors.quran,
                    title: l.notifQuranMemo,
                    body: l.notifQuranMemoBody,
                  ),
                  tile(
                    ReminderIds.quranRevision,
                    icon: Symbols.history_edu,
                    color: AppColors.quran,
                    title: l.notifQuranRevision,
                    body: l.notifQuranRevisionBody,
                  ),
                ],
              ),
              _Section(
                title: l.notifHabitsSection,
                children: [
                  for (final r in habitReminders)
                    _ReminderTile(
                      reminder: r,
                      icon: Symbols.repeat,
                      color: AppColors.health,
                      title: habitNames[r.habitId]!,
                      body: weekdaysLabel(context, r.weekdays),
                      editDays: true,
                    ),
                  if (habitReminders.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(
                        l.notifNoHabitReminders,
                        style: AppTypography.caption,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: AppTextButton(
                      key: const Key('notif-manage-habits'),
                      label: habits.isEmpty
                          ? l.notifAddHabit
                          : l.notifManageHabits,
                      icon: Symbols.add,
                      onPressed: () => habits.isEmpty
                          ? showHabitSheet(context, startWithNew: true)
                          : showAppSheet<void>(
                              context,
                              builder: (_) => const _HabitRemindersSheet(),
                            ),
                    ),
                  ),
                ],
              ),
              _Section(
                title: l.notifWorkSection,
                children: [
                  if (byId[ReminderIds.workFollowUp] case final r?)
                    _ReminderTile(
                      reminder: r,
                      icon: Symbols.work,
                      color: AppColors.work,
                      title: l.notifFollowUps,
                      body: l.notifFollowUpsBody,
                      timeLabel: l.notifMorningSummary(time(r.minuteOfDay)),
                      editDays: true,
                    ),
                ],
              ),
              _Section(
                title: l.notifReviewsSection,
                children: [
                  if (weekly != null)
                    _ReminderTile(
                      reminder: weekly,
                      icon: Symbols.explore,
                      color: AppColors.primaryStrong,
                      title: l.reminderWeeklyTitle,
                      body: l.notifWeeklyBody,
                      timeLabel: l.notifEvery(
                        _singleDay(weekly.weekdays),
                        time(weekly.minuteOfDay),
                      ),
                      singleDay: true,
                    ),
                  if (monthly != null)
                    _ReminderTile(
                      reminder: monthly,
                      icon: Symbols.event_repeat,
                      color: AppColors.primaryStrong,
                      title: l.reminderMonthlyTitle,
                      body: l.notifMonthlyBody,
                      timeLabel: l.notifLastDay(time(monthly.minuteOfDay)),
                      editDays: false,
                    ),
                ],
              ),
              _Section(
                title: l.notifQuietSection,
                children: [
                  _SwitchTile(
                    switchKey: const Key('notif-quiet'),
                    icon: Symbols.do_not_disturb_on,
                    color: AppColors.textSecondary,
                    title: l.notifQuiet,
                    body: l.notifQuietBody,
                    value: prefs.quietEnabled,
                    onChanged: (v) => ref
                        .read(preferencesProvider.notifier)
                        .setQuietHours(enabled: v),
                    chip: _TimeChip(
                      label: quietRange,
                      onTap: () => _pickQuiet(context, ref, prefs),
                    ),
                  ),
                  _SwitchTile(
                    switchKey: const Key('notif-smart'),
                    icon: Symbols.verified,
                    color: AppColors.success,
                    title: l.notifSmart,
                    body: l.notifSmartBody,
                    value: prefs.smartSuppression,
                    onChanged: (v) => ref
                        .read(preferencesProvider.notifier)
                        .setSmartSuppression(v),
                  ),
                ],
              ),
              AppSpacing.gap28,
              SectionHeader(title: l.notifPreview),
              _Preview(reminders: reminders, habitNames: habitNames),
            ],
          ),
        ),
        AppSpacing.gap20,
        const _PermissionBanner(),
      ],
    );
  }

  static String _singleDay(int mask) {
    for (var d = DateTime.monday; d <= DateTime.sunday; d++) {
      if (maskHas(mask, d)) {
        return DateFormat.EEEE().format(DateTime(2024, 1, d));
      }
    }
    return DateFormat.EEEE().format(DateTime(2024, 1, DateTime.saturday));
  }

  static Future<void> _pickQuiet(
    BuildContext context,
    WidgetRef ref,
    AppPreferences prefs,
  ) async {
    final start = await pickMinuteOfDay(
      context,
      initial: prefs.quietStart,
      use24h: prefs.use24h,
    );
    if (start == null || !context.mounted) return;
    final end = await pickMinuteOfDay(
      context,
      initial: prefs.quietEnd,
      use24h: prefs.use24h,
    );
    if (end == null) return;
    await ref
        .read(preferencesProvider.notifier)
        .setQuietHours(enabled: true, start: start, end: end);
  }
}

Future<void> _ensurePermission(WidgetRef ref) async {
  final service = ref.read(notificationServiceProvider);
  if (await service.permissionGranted() == false) {
    await service.requestPermission();
    ref.invalidate(notificationPermissionProvider);
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.gap28,
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm, left: 4),
          child: OverlineLabel(title),
        ),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, c) in children.indexed) ...[
                if (i > 0 && c is! Padding)
                  const Divider(
                    height: 1,
                    indent: AppSpacing.md,
                    endIndent: AppSpacing.md,
                  ),
                c,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label, required this.onTap, this.chipKey});

  final String label;
  final VoidCallback onTap;
  final Key? chipKey;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceMuted,
      borderRadius: AppRadius.pillAll,
      child: InkWell(
        key: chipKey,
        borderRadius: AppRadius.pillAll,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 36),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: AppTypography.label.tabular),
                const SizedBox(width: 2),
                const Icon(Symbols.chevron_right, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReminderTile extends ConsumerWidget {
  const _ReminderTile({
    required this.reminder,
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    this.timeLabel,
    this.editDays = true,
    this.singleDay = false,
  });

  final Reminder reminder;
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String? timeLabel;
  final bool editDays;
  final bool singleDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final prefs = ref.watch(preferencesProvider);
    final repo = ref.read(remindersRepositoryProvider);
    final r = reminder;
    final quiet =
        prefs.quietEnabled &&
        ReminderPlanner.inQuietHours(
          r.minuteOfDay,
          prefs.quietStart,
          prefs.quietEnd,
        );

    Future<void> editTime() async {
      final m = await pickMinuteOfDay(
        context,
        initial: r.minuteOfDay,
        use24h: prefs.use24h,
      );
      if (m != null) await repo.setTime(r.id, m);
    }

    Future<void> editWeekdays() async {
      if (singleDay) {
        final day = await showOptionSheet<int>(
          context,
          title: l.notifReviewDay,
          selected: [
            for (var d = 1; d <= 7; d++)
              if (maskHas(r.weekdays, d)) d,
          ].firstOrNull,
          options: [
            for (var d = DateTime.monday; d <= DateTime.sunday; d++)
              SheetOption(
                value: d,
                label: DateFormat.EEEE().format(DateTime(2024, 1, d)),
              ),
          ],
        );
        if (day != null) await repo.setWeekdays(r.id, weekdayBit(day));
        return;
      }
      final mask = await showAppSheet<int>(
        context,
        builder: (_) => _WeekdaysSheet(initial: r.weekdays),
      );
      if (mask != null && mask != 0) await repo.setWeekdays(r.id, mask);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTile(
                icon: icon,
                color: color,
                background: color.withValues(alpha: 0.1),
                size: 36,
                iconSize: 18,
              ),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.bodyMedium),
                    const SizedBox(height: 2),
                    Text(body, style: AppTypography.caption),
                  ],
                ),
              ),
              Switch(
                key: Key('reminder-${r.id}'),
                value: r.enabled,
                onChanged: (v) async {
                  await repo.setEnabled(r.id, v);
                  if (v) await _ensurePermission(ref);
                },
              ),
            ],
          ),
          if (r.enabled) ...[
            AppSpacing.gap8,
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 48),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _TimeChip(
                    chipKey: Key('reminder-time-${r.id}'),
                    label:
                        timeLabel ??
                        Fmt.timeOfDay(r.minuteOfDay, use24h: prefs.use24h),
                    onTap: singleDay ? editWeekdays : editTime,
                  ),
                  if (singleDay)
                    _TimeChip(label: l.notifTime, onTap: editTime)
                  else if (editDays)
                    _TimeChip(
                      label: weekdaysLabel(context, r.weekdays),
                      onTap: editWeekdays,
                    ),
                  if (quiet)
                    StatusChip(
                      label: l.notifInQuiet,
                      tone: StatusTone.warning,
                      icon: Symbols.do_not_disturb_on,
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.switchKey,
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.value,
    required this.onChanged,
    this.chip,
  });

  final Key switchKey;
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? chip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTile(
                icon: icon,
                color: color,
                background: color.withValues(alpha: 0.1),
                size: 36,
                iconSize: 18,
              ),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.bodyMedium),
                    const SizedBox(height: 2),
                    Text(body, style: AppTypography.caption),
                  ],
                ),
              ),
              Switch(key: switchKey, value: value, onChanged: onChanged),
            ],
          ),
          if (chip != null && value) ...[
            AppSpacing.gap8,
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 48),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: chip,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WeekdaysSheet extends StatefulWidget {
  const _WeekdaysSheet({required this.initial});

  final int initial;

  @override
  State<_WeekdaysSheet> createState() => _WeekdaysSheetState();
}

class _WeekdaysSheetState extends State<_WeekdaysSheet> {
  late int _mask = widget.initial;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.notifRepeat,
      action: PrimaryButton(
        label: l.commonSave,
        icon: Symbols.check,
        onPressed: _mask == 0 ? null : () => Navigator.of(context).pop(_mask),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ChoiceTag(
                label: l.notifDaily,
                selected: _mask == 127,
                onTap: () => setState(() => _mask = 127),
              ),
              ChoiceTag(
                label: l.notifWeekdays,
                selected: _mask == 0x1F,
                onTap: () => setState(() => _mask = 0x1F),
              ),
            ],
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.notifDays),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (var d = DateTime.monday; d <= DateTime.sunday; d++)
                ChoiceTag(
                  label: DateFormat.E().format(DateTime(2024, 1, d)),
                  selected: maskHas(_mask, d),
                  onTap: () => setState(() => _mask ^= weekdayBit(d)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HabitRemindersSheet extends ConsumerWidget {
  const _HabitRemindersSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final prefs = ref.watch(preferencesProvider);
    final habits = (ref.watch(habitsProvider).value ?? const <Habit>[])
        .where((h) => !h.archived)
        .toList();
    final reminders = {
      for (final r in ref.watch(remindersProvider).value ?? const <Reminder>[])
        if (r.habitId != null) r.habitId!: r,
    };
    final repo = ref.read(remindersRepositoryProvider);
    return AppBottomSheet(
      title: l.notifHabitPicker,
      subtitle: l.notifHabitPickerBody,
      child: Column(
        children: [
          for (final h in habits)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: AppRadius.mdAll,
                      onTap: () async {
                        final m = await pickMinuteOfDay(
                          context,
                          initial:
                              reminders[h.id]?.minuteOfDay ??
                              h.reminderMinute ??
                              18 * 60,
                          use24h: prefs.use24h,
                        );
                        if (m == null) return;
                        await repo.upsertHabitReminder(
                          habitId: h.id,
                          minuteOfDay: m,
                          weekdays: reminders[h.id]?.weekdays ?? 127,
                        );
                        await _ensurePermission(ref);
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: AppSpacing.minTouch,
                        ),
                        child: Row(
                          children: [
                            Icon(Symbols.repeat, size: 18, color: h.area.color),
                            AppSpacing.gap12,
                            Expanded(
                              child: Text(
                                h.name,
                                style: AppTypography.bodyMedium,
                              ),
                            ),
                            Text(
                              reminders[h.id] == null
                                  ? l.notifHabitNone
                                  : l.notifHabitSet(
                                      Fmt.timeOfDay(
                                        reminders[h.id]!.minuteOfDay,
                                        use24h: prefs.use24h,
                                      ),
                                    ),
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (reminders[h.id] != null)
                    IconButton(
                      tooltip: l.notifRemoveReminder,
                      icon: const Icon(Symbols.close, size: 18),
                      onPressed: () => repo.delete(reminders[h.id]!.id),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Preview extends ConsumerWidget {
  const _Preview({required this.reminders, required this.habitNames});

  final List<Reminder> reminders;
  final Map<String, String> habitNames;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final prefs = ref.watch(preferencesProvider);
    final now = ref.watch(clockProvider)();
    final next = ReminderPlanner.plan(
      PlannerInput(
        now: now,
        reminders: reminders,
        habitNames: habitNames,
        masterOn: prefs.notificationsOn,
        quietEnabled: prefs.quietEnabled,
        quietStart: prefs.quietStart,
        quietEnd: prefs.quietEnd,
        smartSuppression: false,
        weekStart: prefs.weekStart,
        isDone: (_, _) => false,
        copy: (r, habit) => ReminderScheduler.copyFor(l, r, habit),
      ),
    ).firstOrNull;
    if (next == null) {
      return AppCard(
        child: Text(l.notifPreviewNone, style: AppTypography.caption),
      );
    }
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.primaryStrong,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Symbols.north_east,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              AppSpacing.gap8,
              Expanded(
                child: Text(
                  l.appName.toUpperCase(),
                  style: AppTypography.overline,
                ),
              ),
              Text(
                l.notifPreviewNext(
                  whenLabel(context, next.at, use24h: prefs.use24h, now: now),
                ),
                style: AppTypography.captionSmall,
              ),
            ],
          ),
          AppSpacing.gap8,
          Text(next.title, style: AppTypography.label),
          const SizedBox(height: 2),
          Text(next.body, style: AppTypography.body),
        ],
      ),
    );
  }
}

class _PermissionBanner extends ConsumerWidget {
  const _PermissionBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final granted = ref.watch(notificationPermissionProvider).value;
    if (granted == null) return const SizedBox.shrink();
    if (granted) {
      return InfoBanner(message: l.notifAuthorized, icon: Symbols.check_circle);
    }
    return AppCard(
      color: AppColors.warningSoft,
      borderColor: AppColors.warningSoft,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.notifications_off,
                size: 20,
                color: AppColors.warning,
              ),
              AppSpacing.gap8,
              Expanded(child: Text(l.notifDenied, style: AppTypography.label)),
            ],
          ),
          AppSpacing.gap8,
          Text(l.notifDeniedBody, style: AppTypography.caption),
          AppSpacing.gap12,
          SecondaryButton(
            key: const Key('notif-allow'),
            label: l.notifAllow,
            leadingIcon: Symbols.notifications_active,
            onPressed: () async {
              await ref.read(notificationServiceProvider).requestPermission();
              ref.invalidate(notificationPermissionProvider);
            },
          ),
        ],
      ),
    );
  }
}
