import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/domain/enums.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/routing/app_router.dart';
import 'package:taqadum/core/widgets/app_bottom_navigation.dart';
import 'package:taqadum/features/goals/data/goals_repository.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

const _routes = [
  AppRoutes.today,
  AppRoutes.morningCheckIn,
  AppRoutes.plan,
  AppRoutes.nightReview,
  AppRoutes.quran,
  AppRoutes.work,
  AppRoutes.finance,
  AppRoutes.health,
  AppRoutes.learning,
  AppRoutes.goals,
  AppRoutes.newGoal,
  AppRoutes.progress,
  AppRoutes.calendar,
  AppRoutes.weeklyReview,
  AppRoutes.monthlyReview,
  AppRoutes.activity,
  AppRoutes.notifications,
  AppRoutes.profile,
  AppRoutes.settings,
];

void main() {
  for (final width in [360.0, 430.0]) {
    testWidgets('every screen renders with demo data at ${width}px', (
      tester,
    ) async {
      setPhoneSize(tester, width: width);
      final env = await TestEnv.create(session: readySession);
      final c = await pumpApp(
        tester,
        env,
        seed: (c) => c.read(demoDataSeederProvider).seed(),
      );
      expect(
        c.read(routerProvider).routerDelegate.currentConfiguration.uri.path,
        AppRoutes.today,
      );

      for (final route in _routes) {
        await goTo(tester, c, route);
        expect(tester.takeException(), isNull, reason: route);
        expect(find.byType(Scaffold), findsWidgets, reason: route);
      }

      final goals = await tester.runAsync(
        () => env.db.select(env.db.goals).get(),
      );
      await goTo(tester, c, AppRoutes.goal(goals!.first.id));
      expect(tester.takeException(), isNull);
      await goTo(tester, c, AppRoutes.editGoal(goals.first.id));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('screens fit at the largest supported text size', (tester) async {
    setPhoneSize(tester, width: 360);
    tester.platformDispatcher.textScaleFactorTestValue = 1.35;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final env = await TestEnv.create(session: readySession);
    final c = await pumpApp(
      tester,
      env,
      seed: (c) => c.read(demoDataSeederProvider).seed(),
    );
    for (final route in _routes) {
      await goTo(tester, c, route);
      expect(tester.takeException(), isNull, reason: route);
    }
  });

  testWidgets('empty account shows calm empty states', (tester) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(session: readySession);
    final c = await pumpApp(tester, env);
    for (final route in _routes) {
      await goTo(tester, c, route);
      expect(tester.takeException(), isNull, reason: route);
    }
  });

  testWidgets('bottom navigation switches tabs and hides in focused flows', (
    tester,
  ) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(session: readySession);
    final c = await pumpApp(tester, env);
    Finder navLabel(String text) => find.descendant(
      of: find.byType(AppBottomNavigation),
      matching: find.text(text),
    );

    expect(navLabel('Today'), findsOneWidget);
    await tester.tap(navLabel('Progress'));
    await settle(tester);
    expect(
      c.read(routerProvider).routerDelegate.currentConfiguration.uri.path,
      AppRoutes.progress,
    );

    await tester.tap(navLabel('Goals'));
    await settle(tester);
    expect(
      c.read(routerProvider).routerDelegate.currentConfiguration.uri.path,
      AppRoutes.goals,
    );

    await goTo(tester, c, AppRoutes.morningCheckIn);
    expect(find.byType(AppBottomNavigation), findsNothing);
  });

  testWidgets('first launch lands on account creation', (tester) async {
    setPhoneSize(tester);
    final env = await TestEnv.create();
    final c = await pumpApp(tester, env);
    expect(
      c.read(routerProvider).routerDelegate.currentConfiguration.uri.path,
      AppRoutes.auth,
    );
    expect(find.textContaining('Google'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('goals created in the editor appear on the goals tab', (
    tester,
  ) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(session: readySession);
    final c = await pumpApp(tester, env);
    await tester.runAsync(
      () => c
          .read(goalsRepositoryProvider)
          .save(
            const GoalDraft(
              title: 'Read 12 books',
              area: LifeArea.learning,
              type: GoalType.target,
              targetValue: 12,
              unit: 'books',
            ),
          ),
    );
    await goTo(tester, c, AppRoutes.goals);
    expect(find.text('Read 12 books'), findsWidgets);
  });
}
