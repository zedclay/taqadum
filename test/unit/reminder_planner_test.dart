import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/features/notifications/data/reminders_repository.dart';
import 'package:taqadum/features/notifications/domain/reminder_planner.dart';

Reminder _reminder(
  String id,
  ReminderKind kind,
  int minute, {
  bool enabled = true,
  int weekdays = 127,
  String? habitId,
}) => Reminder(
  id: id,
  kind: kind,
  enabled: enabled,
  minuteOfDay: minute,
  weekdays: weekdays,
  habitId: habitId,
);

PlannerInput _input(
  List<Reminder> reminders, {
  DateTime? now,
  bool masterOn = true,
  bool quietEnabled = false,
  int quietStart = 22 * 60,
  int quietEnd = 7 * 60,
  bool smart = false,
  bool Function(Reminder, String)? isDone,
  Map<String, String> habitNames = const {},
  int days = 7,
}) => PlannerInput(
  now: now ?? DateTime(2027, 3, 10, 6),
  reminders: reminders,
  habitNames: habitNames,
  masterOn: masterOn,
  quietEnabled: quietEnabled,
  quietStart: quietStart,
  quietEnd: quietEnd,
  smartSuppression: smart,
  isDone: isDone ?? (_, _) => false,
  copy: (r, habit) => ReminderCopy(r.kind.name, habit ?? ''),
  days: days,
);

void main() {
  test('weekday masks', () {
    expect(weekdayBit(DateTime.monday), 1);
    expect(weekdayBit(DateTime.sunday), 64);
    final weekdays = weekdayBit(DateTime.monday) | weekdayBit(DateTime.friday);
    expect(maskHas(weekdays, DateTime.friday), isTrue);
    expect(maskHas(weekdays, DateTime.tuesday), isFalse);
  });

  test('quiet hours handle overnight windows', () {
    expect(ReminderPlanner.inQuietHours(23 * 60, 22 * 60, 7 * 60), isTrue);
    expect(ReminderPlanner.inQuietHours(6 * 60, 22 * 60, 7 * 60), isTrue);
    expect(ReminderPlanner.inQuietHours(7 * 60, 22 * 60, 7 * 60), isFalse);
    expect(ReminderPlanner.inQuietHours(13 * 60, 12 * 60, 14 * 60), isTrue);
    expect(ReminderPlanner.inQuietHours(13 * 60, 60, 60), isFalse);
  });

  test('master switch off plans nothing', () {
    final plan = ReminderPlanner.plan(
      _input([
        _reminder('m', ReminderKind.morningCheckIn, 8 * 60),
      ], masterOn: false),
    );
    expect(plan, isEmpty);
  });

  test('plans daily reminders for each day, skipping the past', () {
    final plan = ReminderPlanner.plan(
      _input([
        _reminder('m', ReminderKind.morningCheckIn, 5 * 60),
        _reminder('n', ReminderKind.nightReview, 21 * 60),
        _reminder('off', ReminderKind.quranReading, 9 * 60, enabled: false),
      ]),
    );
    expect(plan.first.at, DateTime(2027, 3, 10, 21));
    expect(plan.length, 13);
    expect(plan.map((r) => r.id).toSet().length, plan.length);
    for (var i = 1; i < plan.length; i++) {
      expect(plan[i].at.isBefore(plan[i - 1].at), isFalse);
    }
  });

  test('respects quiet hours', () {
    final plan = ReminderPlanner.plan(
      _input(
        [
          _reminder('late', ReminderKind.nightReview, 23 * 60),
          _reminder('day', ReminderKind.quranReading, 12 * 60),
        ],
        quietEnabled: true,
        days: 1,
      ),
    );
    expect(plan.map((r) => r.title), ['quranReading']);
  });

  test('smart suppression skips activities already done that day', () {
    final plan = ReminderPlanner.plan(
      _input(
        [_reminder('q', ReminderKind.quranReading, 20 * 60)],
        smart: true,
        days: 2,
        isDone: (r, key) => key == '2027-03-10',
      ),
    );
    expect(plan.single.at, DateTime(2027, 3, 11, 20));
  });

  test('weekly reminders follow their weekday mask', () {
    final plan = ReminderPlanner.plan(
      _input([
        _reminder(
          'w',
          ReminderKind.weeklyReview,
          18 * 60,
          weekdays: weekdayBit(DateTime.friday),
        ),
      ]),
    );
    expect(plan.single.at, DateTime(2027, 3, 12, 18));
  });

  test('monthly review fires on the last day of the month', () {
    final plan = ReminderPlanner.plan(
      _input([
        _reminder('mo', ReminderKind.monthlyReview, 19 * 60),
      ], now: DateTime(2027, 2, 25, 8)),
    );
    expect(plan.single.at, DateTime(2027, 2, 28, 19));
  });

  test('habit reminders need an existing habit', () {
    final plan = ReminderPlanner.plan(
      _input(
        [
          _reminder('h1', ReminderKind.habit, 20 * 60, habitId: 'water'),
          _reminder('h2', ReminderKind.habit, 20 * 60, habitId: 'gone'),
        ],
        habitNames: {'water': 'Drink water'},
        days: 1,
      ),
    );
    expect(plan.single.body, 'Drink water');
  });

  test('caps pending notifications', () {
    final plan = ReminderPlanner.plan(
      _input([
        for (var i = 0; i < 12; i++)
          _reminder('r$i', ReminderKind.quranReading, 8 * 60 + i),
      ], days: 7),
    );
    expect(plan.length, ReminderPlanner.maxPending);
  });
}
