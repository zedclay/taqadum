import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/features/finance/data/finance_repository.dart';
import 'package:taqadum/features/goals/data/goals_repository.dart';
import 'package:taqadum/features/notifications/data/reminders_repository.dart';
import 'package:taqadum/features/onboarding/data/onboarding_service.dart';
import 'package:taqadum/features/onboarding/domain/onboarding_draft.dart';
import 'package:taqadum/features/quran/data/quran_repository.dart';
import 'package:taqadum/features/settings/data/export_service.dart';
import 'package:taqadum/features/settings/data/settings_store.dart';
import 'package:taqadum/features/today/data/tasks_repository.dart';
import 'package:taqadum/l10n/generated/app_localizations.dart';

import '../helpers/test_env.dart';

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
  });

  GoalsRepository goals() => c.read(goalsRepositoryProvider);

  Future<Goal> saveGoal(GoalDraft draft) async {
    final id = await goals().save(draft);
    return (await goals().getGoal(id))!;
  }

  group('goals', () {
    test('save persists actions and milestones and edits in place', () async {
      final goal = await saveGoal(
        const GoalDraft(
          title: 'Finish course',
          area: LifeArea.learning,
          type: GoalType.milestone,
          actions: [GoalActionDraft(title: 'Watch a lesson')],
          milestones: [
            MilestoneDraft(title: 'Module 1'),
            MilestoneDraft(title: 'Module 2'),
          ],
          makePrimary: true,
        ),
      );
      expect(goal.isPrimary, isTrue);
      expect(await goals().actionsFor(goal.id), hasLength(1));
      final milestones = await goals().milestonesFor(goal.id);
      expect(milestones.map((m) => m.title), ['Module 1', 'Module 2']);

      await goals().save(
        GoalDraft(
          id: goal.id,
          title: 'Finish the course',
          area: LifeArea.learning,
          type: GoalType.milestone,
          milestones: [
            MilestoneDraft(id: milestones.first.id, title: 'Module 1'),
          ],
        ),
      );
      expect((await goals().getGoal(goal.id))!.title, 'Finish the course');
      expect(await goals().milestonesFor(goal.id), hasLength(1));
      expect(await env.db.select(env.db.goals).get(), hasLength(1));
    });

    test('only one goal is primary', () async {
      final a = await saveGoal(
        const GoalDraft(
          title: 'A',
          area: LifeArea.work,
          type: GoalType.target,
          targetValue: 10,
          makePrimary: true,
        ),
      );
      final b = await saveGoal(
        const GoalDraft(
          title: 'B',
          area: LifeArea.work,
          type: GoalType.target,
          targetValue: 10,
        ),
      );
      await goals().setPrimary(b.id);
      expect((await goals().getGoal(a.id))!.isPrimary, isFalse);
      expect((await goals().getGoal(b.id))!.isPrimary, isTrue);
    });

    test('manual progress records an event and an activity entry', () async {
      final goal = await saveGoal(
        const GoalDraft(
          title: 'Revenue',
          area: LifeArea.work,
          type: GoalType.target,
          targetValue: 1000,
        ),
      );
      await goals().logProgress(goal: goal, delta: 250, note: 'Invoice');
      final events = await env.db.select(env.db.goalProgressEvents).get();
      expect(events.single.delta, 250);
      final activity = await env.db.select(env.db.activityEvents).get();
      expect(activity.any((a) => a.entityType == 'goalProgress'), isTrue);
    });
  });

  group('module logs feed linked goals', () {
    test('quran pages count toward a page goal', () async {
      final goal = await saveGoal(
        const GoalDraft(
          title: 'Memorize',
          area: LifeArea.quran,
          type: GoalType.target,
          unit: 'pages',
          targetValue: 20,
        ),
      );
      await c
          .read(quranRepositoryProvider)
          .add(kind: QuranKind.memorization, pages: 2, goal: goal);
      final events = await env.db.select(env.db.goalProgressEvents).get();
      expect(events.single.delta, 2);
      expect(events.single.source, ProgressSource.quran);
    });

    test('savings count toward a money goal', () async {
      final goal = await saveGoal(
        const GoalDraft(
          title: 'Emergency fund',
          area: LifeArea.finance,
          type: GoalType.target,
          unit: 'SAR',
          targetValue: 10000,
        ),
      );
      await c
          .read(financeRepositoryProvider)
          .add(
            type: TransactionType.saving,
            amountMinor: 150000,
            category: 'Savings',
            goal: goal,
            currency: 'SAR',
          );
      final events = await env.db.select(env.db.goalProgressEvents).get();
      expect(events.single.delta, 1500);
      final activity = await env.db.select(env.db.activityEvents).get();
      expect(
        activity.singleWhere((a) => a.entityType == 'finance').amountMinor,
        -150000,
      );
    });

    test('completing a task linked to a routine goal counts once', () async {
      final goal = await saveGoal(
        const GoalDraft(
          title: 'Workouts',
          area: LifeArea.health,
          type: GoalType.routine,
          periodTarget: 3,
        ),
      );
      final tasks = c.read(tasksRepositoryProvider);
      await tasks.add(
        TaskDraft(
          title: 'Gym',
          area: LifeArea.health,
          dayKey: '2027-03-10',
          goalId: goal.id,
        ),
      );
      final task = (await tasks.dayTasks('2027-03-10')).single;
      Future<int> taskEvents() async =>
          (await env.db.select(env.db.activityEvents).get())
              .where((a) => a.entityType == 'task')
              .length;

      await tasks.setDone(task, true);
      expect(
        await env.db.select(env.db.goalProgressEvents).get(),
        hasLength(1),
      );
      expect(await taskEvents(), 1);

      await tasks.setDone(task, false);
      expect(await env.db.select(env.db.goalProgressEvents).get(), isEmpty);
      expect(await taskEvents(), 0);
    });
  });

  test('onboarding saves areas, habits and reminders', () async {
    final l = lookupAppLocalizations(const Locale('en'));
    final starters = starterTargetsFor(l);
    await c
        .read(onboardingServiceProvider)
        .complete(
          const OnboardingDraft(
            areas: {LifeArea.quran, LifeArea.health},
            targetIds: {'quran1', 'health1', 'work1'},
            morningMinute: 7 * 60,
            eveningOn: false,
          ),
          starters,
        );
    final areas = await c
        .read(settingsStoreProvider)
        .get(SettingKeys.focusAreas);
    expect(areas, contains('quran'));
    expect(areas, isNot(contains('work')));

    final habits = await env.db.select(env.db.habits).get();
    expect(habits, hasLength(2));

    final reminders = {
      for (final r in await c.read(remindersRepositoryProvider).all()) r.id: r,
    };
    expect(reminders[ReminderIds.morningCheckIn]!.minuteOfDay, 7 * 60);
    expect(reminders[ReminderIds.nightReview]!.enabled, isFalse);
    expect(reminders[ReminderIds.workFollowUp]!.enabled, isFalse);
  });

  test('demo seeder fills every area through the repositories', () async {
    await c.read(demoDataSeederProvider).seed();
    final goals = await env.db.select(env.db.goals).get();
    expect(goals, hasLength(5));
    expect(goals.where((g) => g.isPrimary), hasLength(1));
    final activity = await env.db.select(env.db.activityEvents).get();
    final areas = activity.map((a) => a.area).whereType<LifeArea>().toSet();
    expect(
      areas,
      containsAll(LifeArea.values.toSet()..remove(LifeArea.personal)),
    );
    expect(await env.db.select(env.db.tasks).get(), isNotEmpty);
    expect(activity.every((a) => !a.occurredAt.isAfter(env.now)), isTrue);
  });

  test('JSON export contains every table', () async {
    await saveGoal(
      const GoalDraft(
        title: 'Read 12 books',
        area: LifeArea.learning,
        type: GoalType.target,
        targetValue: 12,
      ),
    );
    final json = await ExportService(env.db).buildJson();
    final tables = json['tables']! as Map<String, Object?>;
    expect(tables.keys, containsAll(['goals', 'tasks', 'activity_events']));
    expect(tables['goals'], hasLength(1));
    expect(() => jsonEncode(json), returnsNormally);
  });

  test('CSV cells are escaped', () {
    expect(
      ExportService.csv([
        ['a', 'b,c', 'say "hi"'],
      ]),
      'a,"b,c","say ""hi"""',
    );
  });

  test('data persists after the database is reopened', () async {
    final dir = await Directory.systemTemp.createTemp('taqaddum_test');
    final file = File('${dir.path}/app.sqlite');
    addTearDown(() => dir.delete(recursive: true));

    final first = await TestEnv.create(db: AppDatabase(NativeDatabase(file)));
    final c1 = first.container();
    await c1
        .read(goalsRepositoryProvider)
        .save(
          const GoalDraft(
            title: 'Persisted goal',
            area: LifeArea.personal,
            type: GoalType.target,
            targetValue: 5,
          ),
        );
    c1.dispose();
    await first.db.close();

    final reopened = AppDatabase(NativeDatabase(file));
    final goals = await reopened.select(reopened.goals).get();
    expect(goals.single.title, 'Persisted goal');
    await reopened.close();
  });
}
