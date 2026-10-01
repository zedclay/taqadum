import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers.dart';

abstract final class PrefKeys {
  static const sessionUserId = 'session.userId';
  static const rememberSession = 'session.remember';
  static const onboardingDone = 'onboarding.done';
  static const goalSetupDone = 'setup.goalDone';
  static const locale = 'pref.locale';
  static const weekStart = 'pref.weekStart';
  static const currency = 'pref.currency';
  static const use24h = 'pref.use24h';
  static const reduceMotion = 'pref.reduceMotion';
  static const notificationsOn = 'notif.master';
  static const quietEnabled = 'notif.quietEnabled';
  static const quietStart = 'notif.quietStart';
  static const quietEnd = 'notif.quietEnd';
  static const smartSuppression = 'notif.smart';

  static const all = [
    sessionUserId,
    rememberSession,
    onboardingDone,
    goalSetupDone,
    locale,
    weekStart,
    currency,
    use24h,
    reduceMotion,
    notificationsOn,
    quietEnabled,
    quietStart,
    quietEnd,
    smartSuppression,
  ];
}

@immutable
class AppPreferences {
  const AppPreferences({
    this.localeCode = 'en',
    this.weekStart = DateTime.monday,
    this.currency = 'DZD',
    this.use24h = true,
    this.reduceMotion = false,
    this.notificationsOn = true,
    this.quietEnabled = true,
    this.quietStart = 22 * 60 + 30,
    this.quietEnd = 6 * 60 + 30,
    this.smartSuppression = true,
  });

  factory AppPreferences.read(SharedPreferences p) => AppPreferences(
    localeCode: p.getString(PrefKeys.locale) ?? 'en',
    weekStart: p.getInt(PrefKeys.weekStart) ?? DateTime.monday,
    currency: p.getString(PrefKeys.currency) ?? 'DZD',
    use24h: p.getBool(PrefKeys.use24h) ?? true,
    reduceMotion: p.getBool(PrefKeys.reduceMotion) ?? false,
    notificationsOn: p.getBool(PrefKeys.notificationsOn) ?? true,
    quietEnabled: p.getBool(PrefKeys.quietEnabled) ?? true,
    quietStart: p.getInt(PrefKeys.quietStart) ?? 22 * 60 + 30,
    quietEnd: p.getInt(PrefKeys.quietEnd) ?? 6 * 60 + 30,
    smartSuppression: p.getBool(PrefKeys.smartSuppression) ?? true,
  );

  final String localeCode;
  final int weekStart;
  final String currency;
  final bool use24h;
  final bool reduceMotion;
  final bool notificationsOn;
  final bool quietEnabled;
  final int quietStart;
  final int quietEnd;
  final bool smartSuppression;

  Locale get locale => Locale(localeCode);

  AppPreferences copyWith({
    String? localeCode,
    int? weekStart,
    String? currency,
    bool? use24h,
    bool? reduceMotion,
    bool? notificationsOn,
    bool? quietEnabled,
    int? quietStart,
    int? quietEnd,
    bool? smartSuppression,
  }) => AppPreferences(
    localeCode: localeCode ?? this.localeCode,
    weekStart: weekStart ?? this.weekStart,
    currency: currency ?? this.currency,
    use24h: use24h ?? this.use24h,
    reduceMotion: reduceMotion ?? this.reduceMotion,
    notificationsOn: notificationsOn ?? this.notificationsOn,
    quietEnabled: quietEnabled ?? this.quietEnabled,
    quietStart: quietStart ?? this.quietStart,
    quietEnd: quietEnd ?? this.quietEnd,
    smartSuppression: smartSuppression ?? this.smartSuppression,
  );
}

final preferencesProvider =
    NotifierProvider<PreferencesController, AppPreferences>(
      PreferencesController.new,
    );

class PreferencesController extends Notifier<AppPreferences> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppPreferences build() =>
      AppPreferences.read(ref.watch(sharedPreferencesProvider));

  Future<void> setLocale(String code) async {
    await _prefs.setString(PrefKeys.locale, code);
    state = state.copyWith(localeCode: code);
  }

  Future<void> setWeekStart(int weekday) async {
    await _prefs.setInt(PrefKeys.weekStart, weekday);
    state = state.copyWith(weekStart: weekday);
  }

  Future<void> setCurrency(String code) async {
    await _prefs.setString(PrefKeys.currency, code);
    state = state.copyWith(currency: code);
  }

  Future<void> setUse24h(bool value) async {
    await _prefs.setBool(PrefKeys.use24h, value);
    state = state.copyWith(use24h: value);
  }

  Future<void> setReduceMotion(bool value) async {
    await _prefs.setBool(PrefKeys.reduceMotion, value);
    state = state.copyWith(reduceMotion: value);
  }

  Future<void> setNotificationsOn(bool value) async {
    await _prefs.setBool(PrefKeys.notificationsOn, value);
    state = state.copyWith(notificationsOn: value);
  }

  Future<void> setQuietHours({bool? enabled, int? start, int? end}) async {
    if (enabled != null) await _prefs.setBool(PrefKeys.quietEnabled, enabled);
    if (start != null) await _prefs.setInt(PrefKeys.quietStart, start);
    if (end != null) await _prefs.setInt(PrefKeys.quietEnd, end);
    state = state.copyWith(
      quietEnabled: enabled,
      quietStart: start,
      quietEnd: end,
    );
  }

  Future<void> setSmartSuppression(bool value) async {
    await _prefs.setBool(PrefKeys.smartSuppression, value);
    state = state.copyWith(smartSuppression: value);
  }

  Future<void> resetAll() async {
    for (final key in PrefKeys.all) {
      await _prefs.remove(key);
    }
    state = const AppPreferences();
  }
}

const supportedCurrencies = [
  ('DZD', 'Algerian Dinar'),
  ('MAD', 'Moroccan Dirham'),
  ('TND', 'Tunisian Dinar'),
  ('SAR', 'Saudi Riyal'),
  ('AED', 'UAE Dirham'),
  ('EGP', 'Egyptian Pound'),
  ('EUR', 'Euro'),
  ('USD', 'US Dollar'),
  ('GBP', 'British Pound'),
];
