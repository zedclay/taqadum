import '../localization/app_locale.dart';

final _latin = RegExp('[A-Za-z]');
final _arabic = RegExp('[\u0600-\u06FF]');

/// User-written text (goal titles, notes, names, emails) can be in any script.
/// In the Arabic UI, text containing Latin letters is wrapped in a Unicode
/// first-strong isolate so an English title keeps its own reading order and
/// punctuation inside a right-to-left layout.
///
/// Text that already mixes in Arabic (a composed label such as
/// "العمل · Atlas") is left alone: wrap the user-written piece instead.
String bidiSafe(String text) =>
    AppLocale.isArabic &&
        _latin.hasMatch(text) &&
        !_arabic.hasMatch(text) &&
        !text.contains('\u2068')
    ? '\u2068$text\u2069'
    : text;
