import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

const _kinds = ['task', 'quran', 'money', 'work', 'habit', 'note'];

void main() {
  for (final scale in [1.0, 1.35]) {
    testWidgets('every quick add form opens cleanly (x$scale)', (tester) async {
      setPhoneSize(tester, width: 360);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final env = await TestEnv.create(session: readySession);
      await pumpApp(
        tester,
        env,
        seed: (c) => c.read(demoDataSeederProvider).seed(),
      );

      for (final kind in _kinds) {
        await tester.tap(find.byKey(const Key('quick-add-button')));
        await settle(tester);
        expect(tester.takeException(), isNull, reason: 'menu');
        await tester.tap(find.byKey(Key('quick-$kind')));
        await settle(tester);
        expect(tester.takeException(), isNull, reason: kind);
        await tester.tapAt(const Offset(20, 20));
        await settle(tester);
      }
    });
  }

  testWidgets('a note logged from quick add is saved', (tester) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(session: readySession);
    await pumpApp(tester, env);

    await tester.tap(find.byKey(const Key('quick-add-button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('quick-note')));
    await settle(tester);
    await tester.enterText(
      find.byKey(const Key('note-body')),
      'Protect the morning block.',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('note-save')));
    await settle(tester);

    final notes = await tester.runAsync(
      () => env.db.select(env.db.notes).get(),
    );
    expect(notes!.single.body, 'Protect the morning block.');
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
