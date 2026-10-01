import 'package:intl/intl.dart';

abstract final class Fmt {
  static final _grouped = NumberFormat.decimalPattern('en');

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
    if (abs >= 1000000) return '$sign${trim(abs / 1000000)}M';
    if (abs >= 1000) return '$sign${trim(abs / 1000)}k';
    return '$sign${number(abs)}';
  }

  static double minorToMajor(int minor) => minor / 100;
  static int majorToMinor(num major) => (major * 100).round();

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
    return withCode ? '$sign$body $currency' : '$sign$body';
  }

  static String percent(double ratio) => '${(ratio * 100).round()}%';

  static String signedPercent(double deltaRatio) {
    final v = (deltaRatio * 100).round();
    return v > 0 ? '+$v%' : '$v%';
  }

  static String minutes(int totalMinutes, {bool short = true}) {
    if (totalMinutes < 60) return '$totalMinutes min';
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    if (m == 0) return '${h}h';
    return short ? '${h}h ${m}m' : '${h}h ${m}m';
  }

  static String hours(int totalMinutes) =>
      number(totalMinutes / 60, maxDecimals: 1);

  static String timeOfDay(int minuteOfDay, {required bool use24h}) {
    final h = minuteOfDay ~/ 60;
    final m = minuteOfDay % 60;
    final mm = m.toString().padLeft(2, '0');
    if (use24h) return '${h.toString().padLeft(2, '0')}:$mm';
    final suffix = h < 12 ? 'AM' : 'PM';
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:$mm $suffix';
  }

  static String time(DateTime moment, {required bool use24h}) {
    final l = moment.toLocal();
    return timeOfDay(l.hour * 60 + l.minute, use24h: use24h);
  }

  static String dayMonth(DateTime d) => DateFormat('d MMM').format(d);
  static String monthDay(DateTime d) => DateFormat('MMM d').format(d);
  static String monthDayYear(DateTime d) => DateFormat('MMM d, yyyy').format(d);
  static String dayMonthYear(DateTime d) => DateFormat('d MMM yyyy').format(d);
  static String weekdayLong(DateTime d) => DateFormat('EEEE').format(d);
  static String weekdayShort(DateTime d) => DateFormat('EEE').format(d);
  static String weekdayNarrow(DateTime d) => DateFormat('EEEEE').format(d);
  static String weekdayDayMonth(DateTime d) =>
      DateFormat('EEEE, d MMMM').format(d);
  static String weekdayMonthDay(DateTime d) =>
      DateFormat('EEEE, MMM d').format(d);
  static String shortWeekdayDayMonth(DateTime d) =>
      DateFormat('EEE, d MMM').format(d);
  static String monthYear(DateTime d) => DateFormat('MMMM yyyy').format(d);
  static String shortMonthYear(DateTime d) => DateFormat('MMM yyyy').format(d);
  static String monthName(DateTime d) => DateFormat('MMMM').format(d);
}
