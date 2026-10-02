import 'package:intl/intl.dart';

import '../localization/app_locale.dart';

/// Display formatting. Digits stay Latin in every language; unit words,
/// currency symbols and date names follow [AppLocale].
abstract final class Fmt {
  static final _grouped = NumberFormat.decimalPattern('en');

  static bool _canonical = false;

  static bool get _ar => !_canonical && AppLocale.isArabic;

  /// Keeps a leading sign attached to its number inside right-to-left text.
  static String _signed(String value) => _ar ? '\u2066$value\u2069' : value;

  /// Runs [format] with English output, for fallback text stored in the
  /// database (the UI renders those rows from structured facts instead).
  static T inEnglish<T>(T Function() format) {
    final previous = _canonical;
    _canonical = true;
    try {
      return format();
    } finally {
      _canonical = previous;
    }
  }

  static String number(num value, {int maxDecimals = 2}) {
    if (value == value.roundToDouble()) return _grouped.format(value.round());
    final f = NumberFormat.decimalPattern('en')
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = maxDecimals;
    return f.format(value);
  }

  static String compact(num value) {
    final abs = value.abs();
    final sign = value < 0 ? '-' : '';
    String trim(double v) => number(double.parse(v.toStringAsFixed(2)));
    if (abs >= 1000000) {
      return _ar
          ? '$sign${trim(abs / 1000000)} مليون'
          : '$sign${trim(abs / 1000000)}M';
    }
    if (abs >= 1000) {
      return _ar ? '$sign${trim(abs / 1000)} ألف' : '$sign${trim(abs / 1000)}k';
    }
    return '$sign${number(abs)}';
  }

  static double minorToMajor(int minor) => minor / 100;
  static int majorToMinor(num major) => (major * 100).round();

  static const _arabicCurrency = {
    'DZD': 'دج',
    'MAD': 'د.م.',
    'TND': 'د.ت.',
    'SAR': 'ر.س',
    'AED': 'د.إ',
    'EGP': 'ج.م',
  };

  /// Currency label for the active language: "DZD" in English, "دج" in Arabic.
  static String currency(String code) {
    final upper = code.toUpperCase();
    return _ar ? (_arabicCurrency[upper] ?? upper) : upper;
  }

  static String money(
    int minor,
    String currency, {
    bool signed = false,
    bool compact = false,
    bool withCode = true,
  }) {
    final major = minorToMajor(minor);
    final body = compact ? Fmt.compact(major.abs()) : number(major.abs());
    final sign = major < 0 ? '-' : (signed && major > 0 ? '+' : '');
    final amount = sign.isEmpty ? body : _signed('$sign$body');
    return withCode ? '$amount ${Fmt.currency(currency)}' : amount;
  }

  static String percent(double ratio) => '${(ratio * 100).round()}%';

  static String signedPercent(double deltaRatio) {
    final v = (deltaRatio * 100).round();
    if (v == 0) return '0%';
    return _signed(v > 0 ? '+$v%' : '$v%');
  }

  static String minutes(int totalMinutes, {bool short = true}) {
    final min = _ar ? 'د' : 'min';
    final hShort = _ar ? ' س' : 'h';
    final mShort = _ar ? ' د' : 'm';
    if (totalMinutes < 60) return '$totalMinutes $min';
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    if (m == 0) return '$h$hShort';
    return '$h$hShort $m$mShort';
  }

  static String hours(int totalMinutes) =>
      number(totalMinutes / 60, maxDecimals: 1);

  static String timeOfDay(int minuteOfDay, {required bool use24h}) {
    final h = minuteOfDay ~/ 60;
    final m = minuteOfDay % 60;
    final mm = m.toString().padLeft(2, '0');
    if (use24h) return '${h.toString().padLeft(2, '0')}:$mm';
    final suffix = _ar ? (h < 12 ? 'ص' : 'م') : (h < 12 ? 'AM' : 'PM');
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:$mm $suffix';
  }

  static String time(DateTime moment, {required bool use24h}) {
    final l = moment.toLocal();
    return timeOfDay(l.hour * 60 + l.minute, use24h: use24h);
  }

  static String _date(String en, String ar, DateTime d) =>
      DateFormat(_ar ? ar : en, _canonical ? 'en' : null).format(d);

  static String dayMonth(DateTime d) => _date('d MMM', 'd MMM', d);
  static String monthDay(DateTime d) => _date('MMM d', 'd MMM', d);
  static String monthDayYear(DateTime d) =>
      _date('MMM d, yyyy', 'd MMM yyyy', d);
  static String dayMonthYear(DateTime d) =>
      _date('d MMM yyyy', 'd MMM yyyy', d);
  static String weekdayLong(DateTime d) => _date('EEEE', 'EEEE', d);
  static String weekdayShort(DateTime d) => _date('EEE', 'EEE', d);
  static String weekdayNarrow(DateTime d) => _date('EEEEE', 'EEEEE', d);
  static String weekdayDayMonth(DateTime d) =>
      _date('EEEE, d MMMM', 'EEEE، d MMMM', d);
  static String weekdayMonthDay(DateTime d) =>
      _date('EEEE, MMM d', 'EEEE، d MMM', d);
  static String shortWeekdayDayMonth(DateTime d) =>
      _date('EEE, d MMM', 'EEE، d MMM', d);
  static String monthYear(DateTime d) => _date('MMMM yyyy', 'MMMM yyyy', d);
  static String shortMonthYear(DateTime d) => _date('MMM yyyy', 'MMM yyyy', d);
  static String monthName(DateTime d) => _date('MMMM', 'MMMM', d);

  /// Chart axis month: "J" in English; Arabic single letters are ambiguous,
  /// so the month number is used instead.
  static String monthNarrow(DateTime d) =>
      _ar ? '${d.month}' : DateFormat('MMMMM', 'en').format(d);
}
