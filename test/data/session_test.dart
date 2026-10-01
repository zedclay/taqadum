import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/features/auth/data/session_controller.dart';
import 'package:taqadum/features/auth/domain/launch_decider.dart';
import 'package:taqadum/features/goals/data/goals_repository.dart';

import '../helpers/test_env.dart';

void main() {
  late TestEnv env;
  late ProviderContainer c;

  setUp(() async {
    env = await TestEnv.create();
    c = env.container();
  });

  tearDown(() async {
    c.dispose();
    await env.db.close();
  });

  SessionController session() => c.read(sessionProvider.notifier);

  test('create account stores only a salted hash', () async {
    await session().createAccount(
      name: 'Sara',
      email: 'Sara@Example.com ',
      password: 'steady-steps-1',
    );
    final state = c.read(sessionProvider);
    expect(state.signedIn, isTrue);
    expect(state.email, 'sara@example.com');
    expect(decideLaunch(state), LaunchTarget.onboarding);

    final stored = await env.credentials.read();
    final raw = jsonEncode(stored!.toJson());
    expect(raw.contains('steady-steps-1'), isFalse);
    expect(stored.password!.salt, isNotEmpty);

    final profiles = await env.db.select(env.db.userProfiles).get();
    expect(profiles.single.name, 'Sara');
  });

  test('a second account on the device is refused', () async {
    await session().createAccount(
      name: 'Sara',
      email: 'sara@example.com',
      password: 'steady-steps-1',
    );
    expect(
      () => session().createAccount(
        name: 'Other',
        email: 'other@example.com',
        password: 'steady-steps-2',
      ),
      throwsA(isA<AuthException>()),
    );
  });

  test('sign out keeps data and sign in verifies the password', () async {
    await session().createAccount(
      name: 'Sara',
      email: 'sara@example.com',
      password: 'steady-steps-1',
    );
    await session().signOut();
    expect(c.read(sessionProvider).signedIn, isFalse);
    expect(c.read(sessionProvider).hasAccount, isTrue);

    await expectLater(
      session().signIn(email: 'sara@example.com', password: 'wrong-pass-1'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.code,
          'code',
          AuthError.wrongCredentials,
        ),
      ),
    );
    await session().signIn(
      email: ' SARA@example.com',
      password: 'steady-steps-1',
    );
    expect(c.read(sessionProvider).signedIn, isTrue);
    expect(await env.db.select(env.db.userProfiles).get(), hasLength(1));
  });

  test('restored session survives an app restart', () async {
    await session().createAccount(
      name: 'Sara',
      email: 'sara@example.com',
      password: 'steady-steps-1',
    );
    final restored = await SessionController.load(env.prefs, env.credentials);
    expect(restored.signedIn, isTrue);
    expect(restored.hasPassword, isTrue);

    await session().signOut();
    final afterLogout = await SessionController.load(
      env.prefs,
      env.credentials,
    );
    expect(afterLogout.signedIn, isFalse);
    expect(afterLogout.hasAccount, isTrue);
  });

  test('continue on this device works without a password', () async {
    await expectLater(
      session().continueOnDevice(),
      throwsA(isA<AuthException>()),
    );
    await session().continueOnDevice(name: 'Omar');
    expect(c.read(sessionProvider).signedIn, isTrue);
    expect(c.read(sessionProvider).hasPassword, isFalse);

    await session().signOut();
    await session().continueOnDevice();
    expect(c.read(sessionProvider).signedIn, isTrue);

    await expectLater(
      session().setPassword(next: 'new-secret-1'),
      throwsA(isA<AuthException>()),
    );
    await session().updateEmail('omar@example.com');
    await session().setPassword(next: 'new-secret-1');
    expect(c.read(sessionProvider).hasPassword, isTrue);
    await session().signOut();
    await expectLater(
      session().continueOnDevice(),
      throwsA(isA<AuthException>()),
    );
  });

  test('delete account wipes every local record', () async {
    await session().createAccount(
      name: 'Sara',
      email: 'sara@example.com',
      password: 'steady-steps-1',
    );
    await session().completeOnboarding();
    await c
        .read(goalsRepositoryProvider)
        .save(
          const GoalDraft(
            title: 'Save 10,000',
            area: LifeArea.finance,
            type: GoalType.target,
            targetValue: 10000,
          ),
        );
    expect(await env.db.select(env.db.goals).get(), hasLength(1));

    await session().deleteAccount();
    expect(c.read(sessionProvider).hasAccount, isFalse);
    expect(await env.credentials.read(), isNull);
    expect(await env.db.select(env.db.goals).get(), isEmpty);
    expect(await env.db.select(env.db.userProfiles).get(), isEmpty);
    expect(await env.db.select(env.db.activityEvents).get(), isEmpty);
    final restored = await SessionController.load(env.prefs, env.credentials);
    expect(restored.onboardingDone, isFalse);
  });
}
