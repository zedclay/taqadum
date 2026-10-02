import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class ScheduledReminder {
  const ScheduledReminder({
    required this.id,
    required this.title,
    required this.body,
    required this.at,
  });

  final int id;
  final String title;
  final String body;
  final DateTime at;
}

/// Android channel labels shown in system settings, in the app language.
class ReminderChannel {
  const ReminderChannel({required this.name, required this.description});

  final String name;
  final String description;
}

abstract class NotificationService {
  Future<void> init();
  Future<bool> requestPermission();
  Future<bool?> permissionGranted();

  /// Cancels every pending reminder and schedules [reminders] instead.
  Future<void> replaceAll(
    List<ScheduledReminder> reminders, {
    required ReminderChannel channel,
  });
  Future<void> cancelAll();
}

class LocalNotificationService implements NotificationService {
  LocalNotificationService([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _ready = false;

  static const _channelId = 'taqaddum_reminders';

  static NotificationDetails _details(ReminderChannel channel) =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: const DarwinNotificationDetails(),
      );

  @override
  Future<void> init() async {
    if (_ready) return;
    try {
      tz_data.initializeTimeZones();
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (error) {
      debugPrint('Timezone fallback to UTC: $error');
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _ready = true;
  }

  @override
  Future<bool> requestPermission() async {
    await init();
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return false;
  }

  @override
  Future<bool?> permissionGranted() async {
    await init();
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) return android.areNotificationsEnabled();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      final options = await ios.checkPermissions();
      return options?.isEnabled;
    }
    return null;
  }

  @override
  Future<void> replaceAll(
    List<ScheduledReminder> reminders, {
    required ReminderChannel channel,
  }) async {
    await init();
    await _plugin.cancelAllPendingNotifications();
    // Android keeps a channel's first name; re-creating it renames the channel
    // in system settings after a language change.
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            _channelId,
            channel.name,
            description: channel.description,
          ),
        );
    final details = _details(channel);
    for (final reminder in reminders) {
      await _plugin.zonedSchedule(
        id: reminder.id,
        title: reminder.title,
        body: reminder.body,
        scheduledDate: tz.TZDateTime.from(reminder.at, tz.local),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  @override
  Future<void> cancelAll() async {
    await init();
    await _plugin.cancelAll();
  }
}

class NoopNotificationService implements NotificationService {
  List<ScheduledReminder> scheduled = const [];
  ReminderChannel? channel;

  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<bool?> permissionGranted() async => true;

  @override
  Future<void> replaceAll(
    List<ScheduledReminder> reminders, {
    required ReminderChannel channel,
  }) async {
    scheduled = reminders;
    this.channel = channel;
  }

  @override
  Future<void> cancelAll() async => scheduled = const [];
}
