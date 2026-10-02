// l10n-ignore-file: demo-only sample content, seeded on request in debug builds.
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/finance/data/finance_repository.dart';
import '../../features/finance/domain/finance_categories.dart';
import '../../features/goals/data/goals_repository.dart';
import '../../features/health/data/health_repository.dart';
import '../../features/history/data/activity_repository.dart';
import '../../features/learning/data/learning_repository.dart';
import '../../features/quran/data/quran_repository.dart';
import '../../features/reviews/data/reviews_repository.dart';
import '../../features/settings/data/preferences.dart';
import '../../features/settings/data/settings_store.dart';
import '../../features/work/data/work_repository.dart';
import '../database/app_database.dart';
import '../domain/period.dart';
import '../providers.dart';
import '../utilities/ids.dart';

/// Fills the database with realistic sample data for development and demos.
///
/// Only available in debug builds or when built with
/// `--dart-define=TAQADDUM_DEMO=true`. Never runs automatically.
class DemoDataSeeder {
  DemoDataSeeder(this._ref);

  final Ref _ref;

  static const enabled = kDebugMode || bool.fromEnvironment('TAQADDUM_DEMO');

  static const days = 35;

  Future<void> seed() async {
    if (!enabled) return;
    final db = _ref.read(databaseProvider);
    final goals = _ref.read(goalsRepositoryProvider);
    final quran = _ref.read(quranRepositoryProvider);
    final work = _ref.read(workRepositoryProvider);
    final finance = _ref.read(financeRepositoryProvider);
    final health = _ref.read(healthRepositoryProvider);
    final learning = _ref.read(learningRepositoryProvider);
    final activity = _ref.read(activityRepositoryProvider);
    final settings = _ref.read(settingsStoreProvider);
    final currency = _ref.read(preferencesProvider).currency;
    final weekStart = _ref.read(preferencesProvider).weekStart;
    final now = _ref.read(clockProvider)();
    final today = startOfDay(now);
    final first = addDays(today, -days);
    final rng = Random(42);

    if ((await settings.get(SettingKeys.focusAreas) ?? '').isEmpty) {
      await settings.setFocusAreas(LifeArea.values);
    }
    await (db.update(db.userProfiles))
        .write(UserProfilesCompanion(createdAt: Value(first.toUtc())));

    Future<Goal> goal(GoalDraft draft) async {
      final id = await goals.save(draft);
      await (db.update(db.goals)..where((t) => t.id.equals(id))).write(
        GoalsCompanion(createdAt: Value(first.toUtc())),
      );
      return (await goals.getGoal(id))!;
    }

    final revenue = await goal(
      const GoalDraft(
        title: 'Grow business revenue',
        area: LifeArea.work,
        type: GoalType.target,
        unit: 'DZD',
        targetValue: 1800000,
        why: 'Build a stable, independent income for the family.',
        makePrimary: true,
        actions: [GoalActionDraft(title: 'Contact 5 qualified leads')],
      ),
    );
    final memorize = await goal(
      const GoalDraft(
        title: 'Memorize Juz Amma',
        area: LifeArea.quran,
        type: GoalType.target,
        unit: 'pages',
        targetValue: 23,
        why: 'Carry the Quran with me in every prayer.',
        actions: [
          GoalActionDraft(
            title: 'Memorize half a page after Fajr',
            frequency: GoalFrequency.daily,
          ),
        ],
      ),
    );
    final savings = await goal(
      const GoalDraft(
        title: 'Save 600,000 DZD',
        area: LifeArea.finance,
        type: GoalType.target,
        unit: 'DZD',
        targetValue: 600000,
        why: 'A six-month safety reserve.',
      ),
    );
    final workouts = await goal(
      const GoalDraft(
        title: 'Workout 3x / week',
        area: LifeArea.health,
        type: GoalType.routine,
        unit: 'sessions',
        frequency: GoalFrequency.weekly,
        periodTarget: 3,
      ),
    );
    await goal(
      const GoalDraft(
        title: 'Finish the negotiation course',
        area: LifeArea.learning,
        type: GoalType.milestone,
        milestones: [
          MilestoneDraft(title: 'Module 1: Preparation', completed: true),
          MilestoneDraft(title: 'Module 2: Anchoring', completed: true),
          MilestoneDraft(title: 'Module 3: Closing'),
          MilestoneDraft(title: 'Apply with two clients'),
        ],
      ),
    );

    final habitIds = [
      await health.addHabit(name: 'Morning walk', area: LifeArea.health),
      await health.addHabit(name: 'Read before bed', area: LifeArea.learning),
      await health.addHabit(name: 'Family dinner', area: LifeArea.personal),
    ];
    final habits = await (db.select(
      db.habits,
    )..where((t) => t.id.isIn(habitIds))).get();

    const clients = [
      'Atlas Construction',
      'Nour Pharma',
      'Sahel Logistics',
      'Medina Foods',
      'Oasis Travel',
      'Kaizen Studio',
    ];
    const expenses = [
      (FinanceCategories.food, 4500, 9000),
      (FinanceCategories.transport, 800, 2000),
      (FinanceCategories.bills, 3000, 6000),
      (FinanceCategories.business, 2500, 4000),
      (FinanceCategories.family, 3000, 12000),
    ];
    const taskPool = [
      ('Review client proposal', LifeArea.work),
      ('Call two warm leads', LifeArea.work),
      ('Plan tomorrow', LifeArea.personal),
      ('Read 5 Quran pages', LifeArea.quran),
      ('Log expenses', LifeArea.finance),
      ('Stretch 10 minutes', LifeArea.health),
      ('Study 30 minutes', LifeArea.learning),
      ('Call parents', LifeArea.personal),
    ];

    DateTime at(DateTime day, int hour, [int minute = 0]) =>
        day.add(Duration(hours: hour, minutes: minute));
    bool past(DateTime moment) => !moment.isAfter(now);

    for (var offset = days; offset >= 0; offset--) {
      final day = addDays(today, -offset);
      final key = dayKeyOf(day);
      final isToday = offset == 0;
      final rest = !isToday && rng.nextDouble() < 0.12;
      final weekday = day.weekday;
      final workday = weekday != DateTime.friday;

      final dayTasks = [...taskPool]..shuffle(rng);
      final count = 3 + rng.nextInt(3);
      final completion = rest ? 0.0 : 0.45 + rng.nextDouble() * 0.55;
      for (final (i, (title, area)) in dayTasks.take(count).indexed) {
        final completedAt = at(day, 9 + i * 2, 15);
        final done =
            (isToday ? i == 0 : rng.nextDouble() < completion) &&
            past(completedAt);
        await db
            .into(db.tasks)
            .insert(
              TasksCompanion.insert(
                id: newId(),
                dayKey: key,
                title: title,
                area: area,
                goalId: Value(area == LifeArea.work ? revenue.id : null),
                scheduledMinute: Value((9 + i * 2) * 60),
                priorityRank: Value(i < 3 ? i + 1 : null),
                sortOrder: Value(i),
                completedAt: Value(done ? completedAt.toUtc() : null),
                createdAt: at(day, 7).toUtc(),
              ),
            );
        if (done) {
          await activity.record(
            area: area,
            type: ActivityType.completed,
            title: title,
            entityType: 'task',
            at: completedAt,
          );
        }
      }
      if (rest) continue;

      if (rng.nextDouble() < 0.65) {
        await db
            .into(db.morningCheckIns)
            .insertOnConflictUpdate(
              MorningCheckInsCompanion.insert(
                dayKey: key,
                energy: Energy.values[rng.nextInt(3)],
                capacity: Capacity.values[rng.nextInt(3)],
                createdAt: at(day, 6, 45).toUtc(),
              ),
            );
      }

      if (past(at(day, 7, 10))) {
        await quran.add(
          kind: QuranKind.reading,
          pages: (2 + rng.nextInt(5)).toDouble(),
          surah: 'Al-Kahf (Surah 18)',
          at: at(day, 7, 10),
        );
      }
      if (offset.isEven && past(at(day, 5, 50))) {
        await quran.add(
          kind: QuranKind.memorization,
          pages: 0.5,
          surah: 'An-Naba (Surah 78)',
          goal: memorize,
          at: at(day, 5, 50),
        );
      }
      if (offset % 3 == 0 && past(at(day, 20, 30))) {
        await quran.add(
          kind: QuranKind.revision,
          minutes: 10 + rng.nextInt(10),
          surah: 'Al-Mulk (Surah 67)',
          at: at(day, 20, 30),
        );
      }

      if (workday && past(at(day, 9))) {
        await work.add(
          kind: WorkKind.deepWork,
          title: 'Client proposal',
          minutes: 60 + rng.nextInt(4) * 20,
          at: at(day, 9),
        );
        for (var i = 0; i < rng.nextInt(3); i++) {
          if (!past(at(day, 11, i * 20))) break;
          await work.add(
            kind: WorkKind.lead,
            title: 'Intro call',
            counterpart: clients[rng.nextInt(clients.length)],
            at: at(day, 11, i * 20),
          );
        }
        if (offset % 4 == 1 && past(at(day, 15))) {
          await work.add(
            kind: WorkKind.followUp,
            title: 'Proposal follow-up',
            counterpart: clients[rng.nextInt(clients.length)],
            at: at(day, 15),
          );
        }
        if (offset % 7 == 3 && past(at(day, 16))) {
          await work.add(
            kind: WorkKind.proposal,
            title: 'Website redesign proposal',
            counterpart: clients[rng.nextInt(clients.length)],
            valueMinor: 18000000,
            at: at(day, 16),
          );
        }
      }
      if (offset == 20 || offset == 6) {
        await work.add(
          kind: WorkKind.clientWon,
          title: 'Retainer signed',
          counterpart: clients[offset % clients.length],
          valueMinor: 16000000,
          goal: revenue,
          at: at(day, 17),
        );
      }

      if ((day.day == 1 || day.day == 15) && past(at(day, 10, 30))) {
        await finance.add(
          type: TransactionType.income,
          amountMinor: 27000000,
          category: FinanceCategories.clientPayment,
          currency: currency,
          at: at(day, 10),
        );
        await finance.add(
          type: TransactionType.saving,
          amountMinor: 4750000,
          category: FinanceCategories.emergency,
          goal: savings,
          currency: currency,
          at: at(day, 10, 30),
        );
      }
      if (offset % 2 == 0 && past(at(day, 13, 20))) {
        final (category, low, high) = expenses[rng.nextInt(expenses.length)];
        await finance.add(
          type: TransactionType.expense,
          amountMinor: (low + rng.nextInt(high - low)) * 100,
          category: category,
          currency: currency,
          at: at(day, 13, 20),
        );
      }

      if (weekday == DateTime.monday ||
          weekday == DateTime.wednesday ||
          weekday == DateTime.saturday) {
        if (rng.nextDouble() < 0.8 && past(at(day, 19))) {
          await health.logWorkout(
            title: 'Strength workout',
            minutes: 40 + rng.nextInt(20),
            detail: 'Upper body',
            goal: workouts,
            at: at(day, 19),
          );
        }
      }
      if (rng.nextDouble() < 0.75 && past(at(day, 18))) {
        await health.logWalk(minutes: 20 + rng.nextInt(25), at: at(day, 18));
      }
      if (!isToday) {
        final bed = at(addDays(day, -1), 22, 45 + rng.nextInt(60));
        await health.logSleep(
          bedTime: bed,
          wakeTime: bed.add(Duration(minutes: 380 + rng.nextInt(90))),
          energy: Energy.values[rng.nextInt(3)],
        );
      }
      for (final h in habits) {
        if (rng.nextDouble() < 0.7 && !isToday) {
          await health.setHabitDone(h, key, true);
        }
      }

      if (offset % 2 == 1 && past(at(day, 21))) {
        await learning.logSession(
          topic: 'Negotiation',
          minutes: 25 + rng.nextInt(20),
          takeaway: offset % 4 == 1
              ? 'Anchor first with a clear, confident number.'
              : null,
          at: at(day, 21),
        );
      }
    }

    final tomorrow = dayKeyOf(addDays(today, 1));
    for (final (i, (title, area)) in taskPool.take(3).indexed) {
      await db
          .into(db.tasks)
          .insert(
            TasksCompanion.insert(
              id: newId(),
              dayKey: tomorrow,
              title: title,
              area: area,
              sortOrder: Value(i),
              createdAt: now.toUtc(),
            ),
          );
    }
    await work.add(
      kind: WorkKind.meeting,
      title: 'Discovery call',
      counterpart: clients[1],
      minutes: 45,
      scheduledAt: at(addDays(today, 2), 10, 30),
    );

    final lastWeek = PeriodRange.week(today, weekStart: weekStart).previous;
    await _ref
        .read(reviewsRepositoryProvider)
        .saveWeekly(
          weekStart: lastWeek.startKey,
          wentWellTags: const ['focused', 'quran'],
          wentWellNote: 'Morning focus blocks protected proposal work.',
          changeTags: const ['sleep'],
          changeNote: 'Sleep earlier on weeknights.',
          biggestWin: 'Retainer signed',
          priorities: [
            const ReviewPriority(
              title: 'Contact 10 qualified leads',
              area: LifeArea.work,
            ),
          ],
          complete: true,
          rangeLabel: '${lastWeek.startKey} – ${lastWeek.endKeyInclusive}',
        );
  }
}

final demoDataSeederProvider = Provider<DemoDataSeeder>(DemoDataSeeder.new);
