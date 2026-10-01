enum PeriodKind { day, week, month, year }

String dayKeyOf(DateTime date) {
  final d = date.toLocal();
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '${d.year}-$m-$day';
}

String monthKeyOf(DateTime date) {
  final d = date.toLocal();
  return '${d.year}-${d.month.toString().padLeft(2, '0')}';
}

DateTime dateOfKey(String key) {
  final parts = key.split('-').map(int.parse).toList();
  return DateTime(parts[0], parts[1], parts.length > 2 ? parts[2] : 1);
}

DateTime startOfDay(DateTime date) {
  final d = date.toLocal();
  return DateTime(d.year, d.month, d.day);
}

DateTime addDays(DateTime date, int days) =>
    DateTime(date.year, date.month, date.day + days);

/// A half-open local time range `[start, end)` aligned to calendar days.
class PeriodRange {
  const PeriodRange._(this.kind, this.start, this.end);

  factory PeriodRange.day(DateTime date) {
    final s = startOfDay(date);
    return PeriodRange._(PeriodKind.day, s, addDays(s, 1));
  }

  /// [weekStart] uses [DateTime.monday] … [DateTime.sunday].
  factory PeriodRange.week(DateTime date, {int weekStart = DateTime.monday}) {
    final day = startOfDay(date);
    final offset = (day.weekday - weekStart + 7) % 7;
    final s = addDays(day, -offset);
    return PeriodRange._(PeriodKind.week, s, addDays(s, 7));
  }

  factory PeriodRange.month(DateTime date) {
    final d = date.toLocal();
    return PeriodRange._(
      PeriodKind.month,
      DateTime(d.year, d.month),
      DateTime(d.year, d.month + 1),
    );
  }

  factory PeriodRange.year(DateTime date) {
    final d = date.toLocal();
    return PeriodRange._(
      PeriodKind.year,
      DateTime(d.year),
      DateTime(d.year + 1),
    );
  }

  /// The [days] calendar days ending with (and including) [today].
  factory PeriodRange.trailing(DateTime today, int days) {
    final end = addDays(startOfDay(today), 1);
    return PeriodRange._(PeriodKind.day, addDays(end, -days), end);
  }

  factory PeriodRange.of(
    PeriodKind kind,
    DateTime date, {
    int weekStart = DateTime.monday,
  }) => switch (kind) {
    PeriodKind.day => PeriodRange.day(date),
    PeriodKind.week => PeriodRange.week(date, weekStart: weekStart),
    PeriodKind.month => PeriodRange.month(date),
    PeriodKind.year => PeriodRange.year(date),
  };

  final PeriodKind kind;
  final DateTime start;
  final DateTime end;

  int get lengthInDays => days.length;

  bool contains(DateTime moment) {
    final local = moment.toLocal();
    return !local.isBefore(start) && local.isBefore(end);
  }

  bool containsKey(String dayKey) => contains(dateOfKey(dayKey));

  List<DateTime> get days => [
    for (var d = start; d.isBefore(end); d = addDays(d, 1)) d,
  ];

  List<String> get dayKeys => days.map(dayKeyOf).toList();

  /// Days of this period that are not in the future relative to [now].
  List<DateTime> elapsedDays(DateTime now) {
    final today = startOfDay(now);
    return days.where((d) => !d.isAfter(today)).toList();
  }

  String get startKey => dayKeyOf(start);
  String get endKeyInclusive => dayKeyOf(addDays(end, -1));

  PeriodRange get previous => shift(-1);
  PeriodRange get next => shift(1);

  PeriodRange shift(int by) => switch (kind) {
    PeriodKind.day => PeriodRange._(
      kind,
      addDays(start, by * lengthInDays),
      addDays(end, by * lengthInDays),
    ),
    PeriodKind.week => PeriodRange._(
      kind,
      addDays(start, 7 * by),
      addDays(end, 7 * by),
    ),
    PeriodKind.month => PeriodRange.month(
      DateTime(start.year, start.month + by),
    ),
    PeriodKind.year => PeriodRange.year(DateTime(start.year + by)),
  };

  @override
  bool operator ==(Object other) =>
      other is PeriodRange &&
      other.kind == kind &&
      other.start == start &&
      other.end == end;

  @override
  int get hashCode => Object.hash(kind, start, end);

  @override
  String toString() => 'PeriodRange($kind, $startKey → $endKeyInclusive)';
}
