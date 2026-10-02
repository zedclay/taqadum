import 'dart:convert';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/database/legacy_text_migration.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/localization/app_locale.dart';
import 'package:taqadum/features/notifications/data/reminder_scheduler.dart';
import 'package:taqadum/features/notifications/data/reminders_repository.dart';
import 'package:taqadum/features/settings/data/preferences.dart';

import '../helpers/test_env.dart';

final _arabicLetter = RegExp('[\u0600-\u06FF]');
final _latinLetter = RegExp('[A-Za-z]');

void main() {
  late TestEnv env;
  late ProviderContainer c;

  setUp(() async {
    env = await TestEnv.create(session: readySession);
    c = env.container();
  });

  tearDown(() async {
    c.dispose();
    await env.db.close();
    AppLocale.apply(AppLanguages.english);
  });

  PreferencesController prefs() => c.read(preferencesProvider.notifier);

  /// Row counts and contents of every table, to prove a language switch
  /// never touches stored data.
  Future<String> snapshot() async {
    final parts = <String>[];
    for (final table in env.db.allTables) {
      final rows = await env.db.select(table).get();
      parts.add(
        '${table.actualTableName}:${rows.length}:'
        '${rows.map((r) => jsonEncode((r as DataClass).toJson())).join('|')}',
      );
    }
    return parts.join('\n');
  }

  test('the language choice persists and French stays disabled', () async {
    await prefs().setLocale(AppLanguages.arabic);
    expect(env.prefs.getString(PrefKeys.locale), 'ar');
    expect(AppPreferences.read(env.prefs).localeCode, 'ar');
    expect(AppPreferences.read(env.prefs).locale.toString(), 'ar_DZ');

    await prefs().setLocale(AppLanguages.french);
    expect(env.prefs.getString(PrefKeys.locale), 'en');
  });

  test('switching language never changes stored data', () async {
    await c.read(demoDataSeederProvider).seed();
    final before = await snapshot();

    await prefs().setLocale(AppLanguages.arabic);
    expect(await snapshot(), before);

    await prefs().setLocale(AppLanguages.english);
    expect(await snapshot(), before);
  });

  test('reminders are written in the current language', () async {
    await c.read(remindersRepositoryProvider).ensureDefaults();
    final scheduler = c.read(reminderSchedulerProvider);

    await prefs().setLocale(AppLanguages.arabic);
    await scheduler.reschedule();
    final arabic = env.notifications.scheduled;
    expect(arabic, isNotEmpty);
    expect(env.notifications.channel!.name, 'التذكيرات');
    for (final r in arabic) {
      expect(r.title, matches(_arabicLetter), reason: r.title);
      expect(r.title, isNot(matches(_latinLetter)), reason: r.title);
      expect(r.body, matches(_arabicLetter), reason: r.body);
    }

    await prefs().setLocale(AppLanguages.english);
    await scheduler.reschedule();
    final english = env.notifications.scheduled;
    expect(english.length, arabic.length);
    expect(env.notifications.channel!.name, 'Reminders');
    expect(english.map((r) => r.title), contains('Morning check-in'));
  });

  test('v1 English system text gains stable ids and facts', () async {
    final db = env.db;
    final now = DateTime.utc(2027, 3, 10, 8);
    await db
        .into(db.habits)
        .insert(
          HabitsCompanion.insert(
            id: 'h1',
            name: 'Walk 8,000 steps',
            area: LifeArea.health,
            createdAt: now,
          ),
        );
    await db
        .into(db.habits)
        .insert(
          HabitsCompanion.insert(
            id: 'h2',
            name: 'Stretch',
            area: LifeArea.health,
            createdAt: now,
          ),
        );
    for (final (id, category) in [('t1', 'Client payment'), ('t2', 'Atlas')]) {
      await db
          .into(db.financeTransactions)
          .insert(
            FinanceTransactionsCompanion.insert(
              id: id,
              type: TransactionType.income,
              amountMinor: 100,
              category: category,
              occurredAt: now,
            ),
          );
    }
    await db
        .into(db.walkingLogs)
        .insert(
          WalkingLogsCompanion.insert(
            id: 'w1',
            minutes: 30,
            steps: const Value(4000),
            occurredAt: now,
          ),
        );
    Future<void> event(String id, String type, String title, String? sub) => db
        .into(db.activityEvents)
        .insert(
          ActivityEventsCompanion.insert(
            id: id,
            type: ActivityType.logged,
            title: title,
            subtitle: Value(sub),
            entityType: Value(type),
            entityId: Value(type == 'walk' ? 'w1' : null),
            occurredAt: now,
          ),
        );
    await event('a1', 'checkin', 'Morning check-in', '3 priorities set');
    await event('a2', 'walk', 'Walk · 30 min', '4,000 steps');
    await event('a3', 'note', 'Call the bank', 'Note');

    await LegacyTextMigration(db).run();

    final habits = {for (final h in await db.select(db.habits).get()) h.id: h};
    expect(habits['h1']!.templateId, 'health1');
    expect(habits['h1']!.name, 'Walk 8,000 steps');
    expect(habits['h2']!.templateId, isNull);

    final txs = {
      for (final t in await db.select(db.financeTransactions).get())
        t.id: t.category,
    };
    expect(txs, {'t1': 'clientPayment', 't2': 'Atlas'});

    final events = {
      for (final e in await db.select(db.activityEvents).get()) e.id: e,
    };
    expect(jsonDecode(events['a1']!.facts!), {'count': 3});
    expect(jsonDecode(events['a2']!.facts!), {'minutes': 30, 'steps': 4000});
    expect(events['a3']!.facts, isNull);
    expect(events['a3']!.title, 'Call the bank');

    await LegacyTextMigration(db).run();
    expect(
      (await db.select(db.financeTransactions).get()).map((t) => t.category),
      containsAll(['clientPayment', 'Atlas']),
    );
  });
}
