import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/services/notification_service.dart';
import '../../settings/data/preferences.dart';
import '../domain/reminder_planner.dart';
import 'reminders_repository.dart';
import '../../health/domain/habit_names.dart';

class ReminderScheduler {
  ReminderScheduler(this._ref);

  final Ref _ref;

  Future<void> reschedule() async {
    final db = _ref.read(databaseProvider);
    final prefs = _ref.read(preferencesProvider);
    final service = _ref.read(notificationServiceProvider);
    final now = _ref.read(clockProvider)();
    final reminders = await _ref.read(remindersRepositoryProvider).all();
    final habits = await db.select(db.habits).get();
    final done = await _doneToday(db, now, prefs.weekStart);
    final l10n = lookupAppLocalizations(prefs.locale);

    final plan = ReminderPlanner.plan(
      PlannerInput(
        now: now,
        reminders: reminders,
        habitNames: {
          for (final h in habits.where((h) => !h.archived))
            h.id: habitDisplayName(l10n, h),
        },
        masterOn: prefs.notificationsOn,
        quietEnabled: prefs.quietEnabled,
        quietStart: prefs.quietStart,
        quietEnd: prefs.quietEnd,
        smartSuppression: prefs.smartSuppression,
        weekStart: prefs.weekStart,
        isDone: (r, dayKey) =>
            dayKey == dayKeyOf(now) && done.contains(r.habitId ?? r.id),
        copy: (r, habit) => copyFor(l10n, r, habit),
      ),
    );
    try {
      await service.replaceAll(
        plan,
        channel: ReminderChannel(
          name: l10n.notifChannelName,
          description: l10n.notifChannelDescription,
        ),
      );
    } catch (error) {
      debugPrint('Reminder scheduling failed: $error');
    }
  }

  static Future<Set<String>> _doneToday(
    AppDatabase db,
    DateTime now,
    int weekStart,
  ) async {
    final key = dayKeyOf(now);
    final day = PeriodRange.day(now);
    final done = <String>{};
    final checkIn = await (db.select(
      db.morningCheckIns,
    )..where((t) => t.dayKey.equals(key))).getSingleOrNull();
    if (checkIn != null) done.add(ReminderIds.morningCheckIn);
    final night = await (db.select(
      db.nightReviews,
    )..where((t) => t.dayKey.equals(key))).getSingleOrNull();
    if (night != null) done.add(ReminderIds.nightReview);
    final quran =
        await (db.select(db.quranLogs)..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(day.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(day.end.toUtc()),
            ))
            .get();
    for (final log in quran) {
      done.add(switch (log.kind) {
        QuranKind.reading => ReminderIds.quranReading,
        QuranKind.memorization => ReminderIds.quranMemorization,
        QuranKind.revision => ReminderIds.quranRevision,
      });
    }
    final followUps =
        await (db.select(db.workActivities)..where(
              (t) =>
                  t.kind.equalsValue(WorkKind.followUp) &
                  t.occurredAt.isBiggerOrEqualValue(day.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(day.end.toUtc()),
            ))
            .get();
    if (followUps.isNotEmpty) done.add(ReminderIds.workFollowUp);
    final habitLogs = await (db.select(
      db.habitLogs,
    )..where((t) => t.dayKey.equals(key))).get();
    done.addAll(habitLogs.map((l) => l.habitId));
    final week = PeriodRange.week(now, weekStart: weekStart);
    final weekly = await (db.select(
      db.weeklyReviews,
    )..where((t) => t.weekStart.equals(week.startKey))).getSingleOrNull();
    if (weekly?.completedAt != null) done.add(ReminderIds.weeklyReview);
    final monthly = await (db.select(
      db.monthlyReviews,
    )..where((t) => t.monthKey.equals(monthKeyOf(now)))).getSingleOrNull();
    if (monthly?.completedAt != null) done.add(ReminderIds.monthlyReview);
    return done;
  }

  static ReminderCopy copyFor(AppLocalizations l, Reminder r, String? habit) =>
      switch (r.kind) {
        ReminderKind.morningCheckIn => ReminderCopy(
          l.reminderMorningTitle,
          l.reminderMorningBody,
        ),
        ReminderKind.nightReview => ReminderCopy(
          l.reminderNightTitle,
          l.reminderNightBody,
        ),
        ReminderKind.quranReading => ReminderCopy(
          l.reminderQuranReadingTitle,
          l.reminderQuranReadingBody,
        ),
        ReminderKind.quranMemorization => ReminderCopy(
          l.reminderQuranMemoTitle,
          l.reminderQuranMemoBody,
        ),
        ReminderKind.quranRevision => ReminderCopy(
          l.reminderQuranRevisionTitle,
          l.reminderQuranRevisionBody,
        ),
        ReminderKind.habit => ReminderCopy(
          l.reminderHabitTitle(habit ?? ''),
          l.reminderHabitBody,
        ),
        ReminderKind.workFollowUp => ReminderCopy(
          l.reminderWorkTitle,
          l.reminderWorkBody,
        ),
        ReminderKind.weeklyReview => ReminderCopy(
          l.reminderWeeklyTitle,
          l.reminderWeeklyBody,
        ),
        ReminderKind.monthlyReview => ReminderCopy(
          l.reminderMonthlyTitle,
          l.reminderMonthlyBody,
        ),
      };
}

final reminderSchedulerProvider = Provider<ReminderScheduler>(
  ReminderScheduler.new,
);

/// Keeps OS-scheduled reminders in sync with settings and today's activity.
final reminderSyncProvider = Provider<void>((ref) {
  Timer? debounce;
  void schedule() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 800), () {
      ref.read(reminderSchedulerProvider).reschedule();
    });
  }

  ref.listen(remindersProvider, (_, _) => schedule());
  ref.listen(preferencesProvider, (_, _) => schedule());
  ref.listen(currentDayProvider, (_, _) => schedule());
  final db = ref.watch(databaseProvider);
  final count = db.activityEvents.id.count();
  final sub = (db.selectOnly(db.activityEvents)..addColumns([count]))
      .map((row) => row.read(count))
      .watchSingle()
      .distinct()
      .listen((_) => schedule());
  ref.onDispose(() {
    debounce?.cancel();
    sub.cancel();
  });
});
