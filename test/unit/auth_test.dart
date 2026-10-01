import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/routing/app_router.dart';
import 'package:taqadum/core/services/password_hasher.dart';
import 'package:taqadum/features/auth/domain/launch_decider.dart';
import 'package:taqadum/features/auth/domain/validators.dart';

String _hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

void main() {
  group('PasswordHasher', () {
    const hasher = PasswordHasher(iterations: 1000);

    test('PBKDF2-HMAC-SHA256 matches published test vectors', () {
      expect(
        _hex(
          PasswordHasher.pbkdf2(
            utf8.encode('password'),
            utf8.encode('salt'),
            1,
          ),
        ),
        '120fb6cffcf8b32c43e7225256c4f837a86548c92ccc35480805987cb70be17b',
      );
      expect(
        _hex(
          PasswordHasher.pbkdf2(
            utf8.encode('password'),
            utf8.encode('salt'),
            2,
          ),
        ),
        'ae4d0c95af6b46d32d0adff928f06dd02a303f8ef3c251dfd6e2d85a95474c43',
      );
    });

    test('verifies the right password only', () async {
      final stored = await hasher.hash('calm-progress-1');
      expect(await hasher.verify('calm-progress-1', stored), isTrue);
      expect(await hasher.verify('calm-progress-2', stored), isFalse);
    });

    test('salts every hash and never stores the plaintext', () async {
      final a = await hasher.hash('same-password-1');
      final b = await hasher.hash('same-password-1');
      expect(a.salt, isNot(b.salt));
      expect(a.hash, isNot(b.hash));
      final json = jsonEncode(a.toJson());
      expect(json.contains('same-password-1'), isFalse);
      final restored = PasswordHash.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
      expect(await hasher.verify('same-password-1', restored), isTrue);
    });
  });

  group('validators', () {
    test('email', () {
      expect(isValidEmail('sara@example.com'), isTrue);
      expect(isValidEmail(' sara@example.co '), isTrue);
      expect(isValidEmail('sara@example'), isFalse);
      expect(isValidEmail('sara example.com'), isFalse);
    });

    test('password strength', () {
      expect(isStrongPassword('abcdefg1'), isTrue);
      expect(isStrongPassword('abcdefgh'), isFalse);
      expect(isStrongPassword('1234567a'), isTrue);
      expect(isStrongPassword('abc1'), isFalse);
    });
  });

  group('launch decisions', () {
    const signedIn = SessionState(hasAccount: true, userId: 'u1');

    test('decideLaunch walks the first-run funnel', () {
      expect(decideLaunch(const SessionState()), LaunchTarget.authCreate);
      expect(
        decideLaunch(const SessionState(hasAccount: true)),
        LaunchTarget.authSignIn,
      );
      expect(decideLaunch(signedIn), LaunchTarget.onboarding);
      expect(
        decideLaunch(signedIn.copyWith(onboardingDone: true)),
        LaunchTarget.goalSetup,
      );
      expect(
        decideLaunch(
          signedIn.copyWith(onboardingDone: true, goalSetupDone: true),
        ),
        LaunchTarget.today,
      );
    });

    test('guardRoute keeps users inside the right stage', () {
      expect(guardRoute(const SessionState(), AppRoutes.splash), isNull);
      expect(
        guardRoute(const SessionState(), AppRoutes.today),
        '/auth?mode=create',
      );
      expect(guardRoute(const SessionState(), AppRoutes.auth), isNull);
      expect(guardRoute(signedIn, AppRoutes.today), AppRoutes.onboarding);
      final ready = signedIn.copyWith(
        onboardingDone: true,
        goalSetupDone: true,
      );
      expect(guardRoute(ready, AppRoutes.auth), AppRoutes.today);
      expect(guardRoute(ready, AppRoutes.onboarding), AppRoutes.today);
      expect(guardRoute(ready, AppRoutes.progress), isNull);
    });
  });
}
