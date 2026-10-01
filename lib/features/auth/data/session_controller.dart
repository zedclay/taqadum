import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers.dart';
import '../../../core/services/credential_store.dart';
import '../../../core/utilities/ids.dart';
import '../../profile/data/profile_repository.dart';
import '../../settings/data/preferences.dart';
import '../domain/launch_decider.dart';

enum AuthError {
  accountExists,
  noAccount,
  wrongCredentials,
  passwordRequired,
  nameRequired,
}

class AuthException implements Exception {
  const AuthException(this.code);
  final AuthError code;

  @override
  String toString() => 'AuthException($code)';
}

/// Initial session, resolved during bootstrap.
final initialSessionProvider = Provider<SessionState>(
  (ref) => const SessionState(),
);

final sessionProvider = NotifierProvider<SessionController, SessionState>(
  SessionController.new,
);

class SessionController extends Notifier<SessionState> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);
  CredentialStore get _credentials => ref.read(credentialStoreProvider);

  @override
  SessionState build() => ref.read(initialSessionProvider);

  static Future<SessionState> load(
    SharedPreferences prefs,
    CredentialStore credentials,
  ) async {
    final credential = await credentials.read();
    final remember = prefs.getBool(PrefKeys.rememberSession) ?? true;
    var userId = prefs.getString(PrefKeys.sessionUserId);
    if (credential == null || userId != credential.userId || !remember) {
      await prefs.remove(PrefKeys.sessionUserId);
      userId = null;
    }
    return SessionState(
      hasAccount: credential != null,
      hasPassword: credential?.hasPassword ?? false,
      userId: userId,
      email: credential?.email,
      onboardingDone: prefs.getBool(PrefKeys.onboardingDone) ?? false,
      goalSetupDone: prefs.getBool(PrefKeys.goalSetupDone) ?? false,
    );
  }

  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
    bool remember = true,
  }) async {
    if (await _credentials.read() != null) {
      throw const AuthException(AuthError.accountExists);
    }
    final id = newId();
    final hash = await ref.read(passwordHasherProvider).hash(password);
    final normalized = email.trim().toLowerCase();
    await _credentials.write(
      StoredCredential(userId: id, email: normalized, password: hash),
    );
    await ref
        .read(profileRepositoryProvider)
        .create(id: id, name: name.trim(), email: normalized);
    await _startSession(id, remember: remember);
    state = state.copyWith(
      hasAccount: true,
      hasPassword: true,
      email: () => normalized,
    );
  }

  Future<void> continueOnDevice({String? name}) async {
    final existing = await _credentials.read();
    if (existing != null) {
      if (existing.hasPassword) {
        throw const AuthException(AuthError.passwordRequired);
      }
      await _startSession(existing.userId, remember: true);
      return;
    }
    if (name == null || name.trim().isEmpty) {
      throw const AuthException(AuthError.nameRequired);
    }
    final id = newId();
    await _credentials.write(StoredCredential(userId: id));
    await ref.read(profileRepositoryProvider).create(id: id, name: name.trim());
    await _startSession(id, remember: true);
    state = state.copyWith(hasAccount: true, hasPassword: false);
  }

  Future<void> signIn({
    required String email,
    required String password,
    bool remember = true,
  }) async {
    final credential = await _credentials.read();
    if (credential == null) throw const AuthException(AuthError.noAccount);
    if (!credential.hasPassword) {
      throw const AuthException(AuthError.wrongCredentials);
    }
    final emailMatches = credential.email == email.trim().toLowerCase();
    final ok = await ref
        .read(passwordHasherProvider)
        .verify(password, credential.password!);
    if (!emailMatches || !ok) {
      throw const AuthException(AuthError.wrongCredentials);
    }
    await _startSession(credential.userId, remember: remember);
  }

  Future<void> setPassword({String? current, required String next}) async {
    final credential = await _credentials.read();
    if (credential == null) throw const AuthException(AuthError.noAccount);
    final hasher = ref.read(passwordHasherProvider);
    if (credential.hasPassword) {
      if (current == null ||
          !await hasher.verify(current, credential.password!)) {
        throw const AuthException(AuthError.wrongCredentials);
      }
    }
    final email = credential.email ?? state.email;
    if (email == null) throw const AuthException(AuthError.wrongCredentials);
    await _credentials.write(
      StoredCredential(
        userId: credential.userId,
        email: email,
        password: await hasher.hash(next),
      ),
    );
    state = state.copyWith(hasPassword: true);
  }

  Future<void> updateEmail(String email) async {
    final credential = await _credentials.read();
    if (credential == null) return;
    final normalized = email.trim().toLowerCase();
    await _credentials.write(
      StoredCredential(
        userId: credential.userId,
        email: normalized,
        password: credential.password,
      ),
    );
    await ref
        .read(profileRepositoryProvider)
        .update(id: credential.userId, email: () => normalized);
    state = state.copyWith(email: () => normalized);
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(PrefKeys.onboardingDone, true);
    state = state.copyWith(onboardingDone: true);
  }

  Future<void> completeGoalSetup() async {
    await _prefs.setBool(PrefKeys.goalSetupDone, true);
    state = state.copyWith(goalSetupDone: true);
  }

  Future<void> signOut() async {
    await _prefs.remove(PrefKeys.sessionUserId);
    state = state.copyWith(userId: () => null);
  }

  /// Erases every local record, preference, credential and reminder.
  Future<void> deleteAccount() async {
    await ref.read(notificationServiceProvider).cancelAll();
    await ref.read(databaseProvider).wipeAllData();
    await ref.read(preferencesProvider.notifier).resetAll();
    await _credentials.clear();
    state = const SessionState();
  }

  Future<void> _startSession(String userId, {required bool remember}) async {
    await _prefs.setString(PrefKeys.sessionUserId, userId);
    await _prefs.setBool(PrefKeys.rememberSession, remember);
    state = state.copyWith(userId: () => userId);
  }
}
