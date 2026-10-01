import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/providers.dart';
import 'package:taqadum/core/services/credential_store.dart';
import 'package:taqadum/core/services/notification_service.dart';
import 'package:taqadum/core/services/password_hasher.dart';
import 'package:taqadum/features/auth/data/session_controller.dart';
import 'package:taqadum/features/auth/domain/launch_decider.dart';

/// Everything a test needs to run the app's providers fully offline.
class TestEnv {
  TestEnv._({
    required this.db,
    required this.prefs,
    required this.credentials,
    required this.notifications,
    required this.now,
    required this.session,
  });

  static Future<TestEnv> create({
    AppDatabase? db,
    DateTime? now,
    Map<String, Object> prefs = const {},
    CredentialStore? credentials,
    SessionState session = const SessionState(),
  }) async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    SharedPreferences.setMockInitialValues(prefs);
    return TestEnv._(
      db: db ?? AppDatabase(NativeDatabase.memory()),
      prefs: await SharedPreferences.getInstance(),
      credentials: credentials ?? InMemoryCredentialStore(),
      notifications: NoopNotificationService(),
      now: now ?? DateTime(2027, 3, 10, 9),
      session: session,
    );
  }

  final AppDatabase db;
  final SharedPreferences prefs;
  final CredentialStore credentials;
  final NoopNotificationService notifications;
  final DateTime now;
  final SessionState session;

  List<Override> get overrides => [
    databaseProvider.overrideWithValue(db),
    sharedPreferencesProvider.overrideWithValue(prefs),
    credentialStoreProvider.overrideWithValue(credentials),
    notificationServiceProvider.overrideWithValue(notifications),
    passwordHasherProvider.overrideWithValue(
      const PasswordHasher(iterations: 1000),
    ),
    clockProvider.overrideWithValue(() => now),
    initialSessionProvider.overrideWithValue(session),
  ];

  ProviderContainer container() => ProviderContainer(overrides: overrides);
}

/// A session that has finished onboarding and goal setup.
const readySession = SessionState(
  hasAccount: true,
  userId: 'user-1',
  onboardingDone: true,
  goalSetupDone: true,
);
