import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Languages the app ships complete. French is listed in the language picker
/// but stays disabled until its catalogue is finished.
abstract final class AppLanguages {
  static const english = 'en';
  static const arabic = 'ar';
  static const french = 'fr';

  static const selectable = [english, arabic];

  /// Native names, intentionally not translated.
  static const nativeNames = {
    english: 'English',
    arabic: 'العربية',
    french: 'Français',
  };

  static String normalize(String? code) =>
      selectable.contains(code) ? code! : english;
}

/// Process-wide formatting locale shared by [Intl] and `Fmt`.
///
/// The app locale for Arabic is Algerian Arabic (`ar_DZ`). Dates are formatted
/// with the generic `ar` symbols, which Flutter's localizations load, so month
/// names are the Modern Standard ones (يناير، فبراير…). Digits stay Latin
/// everywhere, including in Flutter's own date widgets.
abstract final class AppLocale {
  static String _code = AppLanguages.english;

  static String get code => _code;
  static bool get isArabic => _code == AppLanguages.arabic;

  static Locale localeFor(String code) => code == AppLanguages.arabic
      ? const Locale('ar', 'DZ')
      : Locale(AppLanguages.normalize(code));

  static String intlLocaleFor(String code) => AppLanguages.normalize(code);

  static void apply(String code) {
    _code = AppLanguages.normalize(code);
    Intl.defaultLocale = intlLocaleFor(_code);
    for (final locale in const ['ar', 'ar_DZ']) {
      DateFormat.useNativeDigitsByDefaultFor(locale, false);
    }
  }
}
