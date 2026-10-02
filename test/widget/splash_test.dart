import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

void main() {
  for (final width in [360.0, 430.0]) {
    testWidgets('splash content is horizontally centered at ${width}px', (
      tester,
    ) async {
      setPhoneSize(tester, width: width);
      final env = await TestEnv.create();
      final container = env.container();
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        container.dispose();
        await tester.runAsync(env.db.close);
      });
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const TaqaddumApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      for (final finder in [
        find.byType(Image),
        find.text('Progress, one day at a time.'),
        find.text('Build your better days.'),
      ]) {
        expect(
          tester.getCenter(finder).dx,
          moreOrLessEquals(width / 2, epsilon: 0.5),
        );
      }
      await settle(tester, frames: 20);
    });
  }
}
