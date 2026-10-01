import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';

abstract final class ReminderIds {
  static const morningCheckIn = 'morning_checkin';
  static const nightReview = 'night_review';
  static const quranReading = 'quran_reading';
  static const quranMemorization = 'quran_memorization';
  static const quranRevision = 'quran_revision';
  static const workFollowUp = 'work_followup';
  static const weeklyReview = 'weekly_review';
  static const monthlyReview = 'monthly_review';

  static String habit(String habitId) => 'habit_$habitId';
}

int weekdayBit(int weekday) => 1 << (weekday - 1);

bool maskHas(int mask, int weekday) => mask & weekdayBit(weekday) != 0;

class RemindersRepository {
  RemindersRepository(this._db);

  final AppDatabase _db;

  static final defaults = <RemindersCompanion>[
    _d(ReminderIds.morningCheckIn, ReminderKind.morningCheckIn, 7 * 60, true),
    _d(ReminderIds.nightReview, ReminderKind.nightReview, 21 * 60 + 30, true),
    _d(ReminderIds.quranReading, ReminderKind.quranReading, 8 * 60, true),
    _d(
      ReminderIds.quranMemorization,
      ReminderKind.quranMemorization,
      6 * 60 + 30,
      false,
    ),
    _d(ReminderIds.quranRevision, ReminderKind.quranRevision, 20 * 60, false),
    _d(
      ReminderIds.workFollowUp,
      ReminderKind.workFollowUp,
      8 * 60 + 30,
      true,
      mask: 0x1F,
    ),
    _d(
      ReminderIds.weeklyReview,
      ReminderKind.weeklyReview,
      19 * 60,
      true,
      mask: weekdayBit(DateTime.saturday),
    ),
    _d(ReminderIds.monthlyReview, ReminderKind.monthlyReview, 20 * 60, true),
  ];

  static RemindersCompanion _d(
    String id,
    ReminderKind kind,
    int minute,
    bool enabled, {
    int mask = 127,
  }) => RemindersCompanion.insert(
    id: id,
    kind: kind,
    minuteOfDay: minute,
    enabled: Value(enabled),
    weekdays: Value(mask),
  );

  Future<void> ensureDefaults() async {
    for (final d in defaults) {
      await _db.into(_db.reminders).insert(d, mode: InsertMode.insertOrIgnore);
    }
  }

  Stream<List<Reminder>> watchAll() => _db.select(_db.reminders).watch();

  Future<List<Reminder>> all() => _db.select(_db.reminders).get();

  Future<void> save(Reminder reminder) =>
      _db.into(_db.reminders).insertOnConflictUpdate(reminder);

  Future<void> setEnabled(String id, bool enabled) =>
      (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
        RemindersCompanion(enabled: Value(enabled)),
      );

  Future<void> setTime(String id, int minuteOfDay) =>
      (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
        RemindersCompanion(minuteOfDay: Value(minuteOfDay)),
      );

  Future<void> setWeekdays(String id, int mask) =>
      (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
        RemindersCompanion(weekdays: Value(mask)),
      );

  Future<void> delete(String id) =>
      (_db.delete(_db.reminders)..where((t) => t.id.equals(id))).go();

  Future<void> upsertHabitReminder({
    required String habitId,
    required int minuteOfDay,
    bool enabled = true,
    int weekdays = 127,
  }) => _db
      .into(_db.reminders)
      .insertOnConflictUpdate(
        RemindersCompanion.insert(
          id: ReminderIds.habit(habitId),
          kind: ReminderKind.habit,
          minuteOfDay: minuteOfDay,
          enabled: Value(enabled),
          weekdays: Value(weekdays),
          habitId: Value(habitId),
        ),
      );
}

final remindersRepositoryProvider = Provider<RemindersRepository>(
  (ref) => RemindersRepository(ref.watch(databaseProvider)),
);

final remindersProvider = StreamProvider<List<Reminder>>(
  (ref) => ref.watch(remindersRepositoryProvider).watchAll(),
);
