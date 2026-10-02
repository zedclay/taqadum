// l10n-ignore-file: frozen English values written by schema v1.
import 'dart:convert';

import 'package:drift/drift.dart';

import 'activity_fallback.dart';
import 'app_database.dart';

/// Upgrades schema-v1 rows that stored English system text so they can be
/// displayed in any language. User-written content is never rewritten.
///
/// * starter habits get their template id,
/// * built-in finance categories become stable ids,
/// * activity events get structured facts read from their source rows.
class LegacyTextMigration {
  LegacyTextMigration(this._db);

  final AppDatabase _db;

  /// Starter habit labels exactly as v1 stored them.
  static const starterHabits = {
    'Read 1 Hizb daily': 'quran1',
    'Memorization practice': 'quran2',
    'Daily morning Adhkar': 'quran3',
    '4 hours deep work': 'work1',
    'Daily follow-ups': 'work2',
    'Log expenses every evening': 'finance1',
    'Set aside savings': 'finance2',
    'Walk 8,000 steps': 'health1',
    'Sleep before 11 PM': 'health2',
    'Study 30 minutes': 'learning1',
    'Read 10 pages': 'learning2',
    'Quality family time': 'personal1',
    'Call a relative': 'personal2',
  };

  /// Built-in finance category labels exactly as v1 stored them.
  static const financeCategories = {
    'Food': 'food',
    'Transport': 'transport',
    'Home': 'home',
    'Bills': 'bills',
    'Family': 'family',
    'Health': 'health',
    'Education': 'education',
    'Business': 'business',
    'Shopping': 'shopping',
    'Salary': 'salary',
    'Client payment': 'clientPayment',
    'Freelance': 'freelance',
    'Gift': 'gift',
    'Emergency fund': 'emergency',
    'Savings goal': 'savingsGoal',
    'Investment': 'investment',
  };

  Future<void> run() => _db.transaction(() async {
    await _habits();
    await _categories();
    await _activity();
  });

  Future<void> _habits() async {
    for (final MapEntry(key: label, value: id) in starterHabits.entries) {
      await (_db.update(_db.habits)
            ..where((t) => t.name.equals(label) & t.templateId.isNull()))
          .write(HabitsCompanion(templateId: Value(id)));
    }
  }

  Future<void> _categories() async {
    for (final MapEntry(key: label, value: id) in financeCategories.entries) {
      await (_db.update(_db.financeTransactions)
            ..where((t) => t.category.equals(label)))
          .write(FinanceTransactionsCompanion(category: Value(id)));
    }
  }

  Future<void> _activity() async {
    final events = await (_db.select(
      _db.activityEvents,
    )..where((t) => t.facts.isNull())).get();
    final habits = {
      for (final h in await _db.select(_db.habits).get()) h.id: h,
    };
    final habitLogs = {
      for (final log in await _db.select(_db.habitLogs).get())
        log.id: log.habitId,
    };
    for (final e in events) {
      final facts = await _factsFor(e, habits, habitLogs);
      if (facts == null) continue;
      await (_db.update(_db.activityEvents)..where((t) => t.id.equals(e.id)))
          .write(ActivityEventsCompanion(facts: Value(jsonEncode(facts))));
    }
  }

  Future<Map<String, Object?>?> _factsFor(
    ActivityEvent e,
    Map<String, Habit> habits,
    Map<String, String> habitLogs,
  ) async {
    final id = e.entityId;
    switch (e.entityType) {
      case 'checkin':
        final m = ActivityFallback.prioritiesPattern.firstMatch(
          e.subtitle ?? '',
        );
        return m == null ? null : {'count': int.parse(m.group(1)!)};
      case 'nightReview':
        final m = ActivityFallback.ratingPattern.firstMatch(e.subtitle ?? '');
        return m == null ? null : {'rating': int.parse(m.group(1)!)};
      case 'habit':
        final template = habits[id]?.templateId;
        return template == null ? null : {'template': template};
      case 'habitLog':
        final template = habits[habitLogs[id]]?.templateId;
        return template == null ? null : {'template': template};
      case 'quran':
        if (id == null) return null;
        final log = await (_db.select(
          _db.quranLogs,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        return log == null
            ? null
            : {
                'kind': log.kind.name,
                'pages': log.pages,
                'minutes': log.minutes,
              };
      case 'learning':
        if (id == null) return null;
        final s = await (_db.select(
          _db.learningSessions,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        return s == null
            ? null
            : {'topic': s.topic, 'skill': s.skill, 'minutes': s.minutes};
      case 'work':
        if (id == null) return null;
        final w = await (_db.select(
          _db.workActivities,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        return w == null
            ? null
            : {
                'kind': w.kind.name,
                'counterpart': w.counterpart,
                'minutes': w.minutes,
              };
      case 'finance':
        if (id == null) return null;
        final t = await (_db.select(
          _db.financeTransactions,
        )..where((x) => x.id.equals(id))).getSingleOrNull();
        return t == null
            ? null
            : {'type': t.type.name, 'category': t.category, 'note': t.note};
      case 'workout':
        if (id == null) return null;
        final w = await (_db.select(
          _db.workoutLogs,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        return w == null ? null : {'minutes': w.minutes, 'detail': w.detail};
      case 'walk':
        if (id == null) return null;
        final w = await (_db.select(
          _db.walkingLogs,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        return w == null ? null : {'minutes': w.minutes, 'steps': w.steps};
      case 'sleep':
        if (id == null) return null;
        final s = await (_db.select(
          _db.sleepLogs,
        )..where((t) => t.dayKey.equals(id))).getSingleOrNull();
        return s == null ? null : sleepFacts(s.bedTime, s.wakeTime);
    }
    return null;
  }

  static Map<String, Object?> sleepFacts(DateTime bed, DateTime wake) {
    final b = bed.toLocal();
    final w = wake.toLocal();
    return {
      'minutes': wake.difference(bed).inMinutes,
      'bed': b.hour * 60 + b.minute,
      'wake': w.hour * 60 + w.minute,
    };
  }
}
