import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/app_database.dart';
import 'domain/period.dart';
import 'services/credential_store.dart';
import 'services/notification_service.dart';
import 'services/password_hasher.dart';

typedef Clock = DateTime Function();

final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) =>
      throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final credentialStoreProvider = Provider<CredentialStore>(
  (ref) => SecureCredentialStore(),
);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => LocalNotificationService(),
);

final passwordHasherProvider = Provider<PasswordHasher>(
  (ref) => const PasswordHasher(),
);

final clockProvider = Provider<Clock>((ref) => DateTime.now);

/// The current local calendar day. Refreshed when the app resumes so that
/// day-bound screens roll over at midnight.
final currentDayProvider = NotifierProvider<CurrentDay, DateTime>(
  CurrentDay.new,
);

class CurrentDay extends Notifier<DateTime> {
  @override
  DateTime build() => startOfDay(ref.watch(clockProvider)());

  void refresh() {
    final today = startOfDay(ref.read(clockProvider)());
    if (today != state) state = today;
  }
}

final todayKeyProvider = Provider<String>(
  (ref) => dayKeyOf(ref.watch(currentDayProvider)),
);
