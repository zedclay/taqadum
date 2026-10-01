import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/app/app.dart';
import 'package:taqadum/core/routing/app_router.dart';
import 'package:taqadum/features/splash/presentation/splash_screen.dart';

import 'test_env.dart';

/// Advances frames without waiting for endless animations to stop.
Future<void> settle(WidgetTester tester, {int frames = 12}) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void setPhoneSize(WidgetTester tester, {double width = 390}) {
  tester.view.devicePixelRatio = 3;
  tester.view.physicalSize = Size(width * 3, 844 * 3);
  addTearDown(tester.view.reset);
}

/// Boots the real app on top of [env] and waits past the splash screen.
Future<ProviderContainer> pumpApp(
  WidgetTester tester,
  TestEnv env, {
  Future<void> Function(ProviderContainer c)? seed,
}) async {
  final container = env.container();
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.runAsync(env.db.close);
  });
  if (seed != null) await tester.runAsync(() => seed(container));
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const TaqaddumApp()),
  );
  await tester.pump(SplashScreen.holdDuration);
  await settle(tester);
  return container;
}

Future<void> goTo(
  WidgetTester tester,
  ProviderContainer container,
  String location,
) async {
  container.read(routerProvider).go(location);
  await settle(tester);
}
