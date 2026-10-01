import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/database/app_database.dart';
import '../core/providers.dart';
import '../core/services/credential_store.dart';
import '../core/services/notification_service.dart';
import '../features/auth/data/session_controller.dart';
import 'app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final prefs = await SharedPreferences.getInstance();
  final database = AppDatabase();
  final credentials = SecureCredentialStore();
  final session = await SessionController.load(prefs, credentials);
  final notifications = LocalNotificationService();
  try {
    await notifications.init();
  } catch (error) {
    debugPrint('Notifications unavailable: $error');
  }

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        sharedPreferencesProvider.overrideWithValue(prefs),
        credentialStoreProvider.overrideWithValue(credentials),
        notificationServiceProvider.overrideWithValue(notifications),
        initialSessionProvider.overrideWithValue(session),
      ],
      child: const TaqaddumApp(),
    ),
  );
}
