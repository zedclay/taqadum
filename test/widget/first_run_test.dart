import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/routing/app_router.dart';
import 'package:taqadum/features/auth/data/session_controller.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

void main() {
  for (final scale in [1.0, 1.35]) {
    testWidgets('first run: device profile, onboarding, first goal (x$scale)', (
      tester,
    ) async {
      setPhoneSize(tester, width: 360);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final env = await TestEnv.create();
      final c = await pumpApp(tester, env);
      String path() =>
          c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

      Future<void> tap(Key key) async {
        final target = find.byKey(key);
        if (target.evaluate().isEmpty) {
          await tester.scrollUntilVisible(
            target,
            200,
            scrollable: find.byType(Scrollable).first,
          );
        }
        await tester.ensureVisible(target);
        await tester.pump();
        await tester.tap(find.byKey(key));
        await settle(tester);
      }

      expect(path(), AppRoutes.auth);
      await tap(const Key('continue-on-device'));
      await tester.enterText(
        find.byKey(const Key('device-profile-name')),
        'Sara',
      );
      await tester.pump();
      await tap(const Key('device-profile-start'));
      expect(path(), AppRoutes.onboarding);
      expect(tester.takeException(), isNull);

      for (var i = 0; i < 6 && path() == AppRoutes.onboarding; i++) {
        await tap(const Key('onboarding-continue'));
        expect(tester.takeException(), isNull);
      }
      expect(path(), AppRoutes.goalSetup);

      await tester.enterText(
        find.byKey(const Key('goal-title')),
        'Memorize Juz Amma',
      );
      await tester.enterText(find.byKey(const Key('goal-target')), '30');
      await tester.pump();
      await tap(const Key('goal-save'));
      expect(tester.takeException(), isNull);
      await tap(const Key('goal-setup-finish'));
      expect(path(), AppRoutes.today);

      final session = c.read(sessionProvider);
      expect(session.onboardingDone, isTrue);
      expect(session.goalSetupDone, isTrue);
      final goals = await tester.runAsync(
        () => env.db.select(env.db.goals).get(),
      );
      expect(goals!.single.title, 'Memorize Juz Amma');
      expect(goals.single.targetValue, 30);
      await goTo(tester, c, AppRoutes.goals);
      expect(find.text('Memorize Juz Amma'), findsWidgets);
    });
  }
}
