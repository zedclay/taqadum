import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/domain/period.dart';

void main() {
  group('day keys', () {
    test('format and parse round trip', () {
      final date = DateTime(2027, 3, 7, 18, 30);
      expect(dayKeyOf(date), '2027-03-07');
      expect(monthKeyOf(date), '2027-03');
      expect(dateOfKey('2027-03-07'), DateTime(2027, 3, 7));
      expect(dateOfKey('2027-03'), DateTime(2027, 3));
    });

    test('addDays crosses month and year boundaries', () {
      expect(addDays(DateTime(2027, 12, 31), 1), DateTime(2028));
      expect(addDays(DateTime(2027, 3, 1), -1), DateTime(2027, 2, 28));
    });
  });

  group('PeriodRange', () {
    final wednesday = DateTime(2027, 3, 10, 9);

    test('week honours the configured first weekday', () {
      final monday = PeriodRange.week(wednesday);
      expect(monday.start, DateTime(2027, 3, 8));
      expect(monday.end, DateTime(2027, 3, 15));

      final saturday = PeriodRange.week(
        wednesday,
        weekStart: DateTime.saturday,
      );
      expect(saturday.start, DateTime(2027, 3, 6));
      expect(saturday.lengthInDays, 7);

      final sunday = PeriodRange.week(wednesday, weekStart: DateTime.sunday);
      expect(sunday.start, DateTime(2027, 3, 7));
    });

    test('month is half open and knows its length', () {
      final feb = PeriodRange.month(DateTime(2028, 2, 14));
      expect(feb.lengthInDays, 29);
      expect(feb.contains(DateTime(2028, 2, 29, 23, 59)), isTrue);
      expect(feb.contains(DateTime(2028, 3)), isFalse);
      expect(feb.endKeyInclusive, '2028-02-29');
    });

    test('previous and next shift by whole periods', () {
      final jan = PeriodRange.month(DateTime(2027, 1, 20));
      expect(jan.previous.startKey, '2026-12-01');
      expect(jan.next.startKey, '2027-02-01');

      final week = PeriodRange.week(wednesday);
      expect(week.previous.start, DateTime(2027, 3, 1));

      final year = PeriodRange.year(wednesday);
      expect(year.previous.start, DateTime(2026));
    });

    test('trailing covers N days ending today', () {
      final range = PeriodRange.trailing(wednesday, 7);
      expect(range.lengthInDays, 7);
      expect(range.startKey, '2027-03-04');
      expect(range.endKeyInclusive, '2027-03-10');
      expect(range.previous.endKeyInclusive, '2027-03-03');
    });

    test('elapsedDays excludes the future', () {
      final week = PeriodRange.week(wednesday);
      expect(week.elapsedDays(wednesday).length, 3);
      expect(week.containsKey('2027-03-14'), isTrue);
      expect(week.containsKey('2027-03-15'), isFalse);
    });

    test('equality is by kind and bounds', () {
      expect(
        PeriodRange.month(DateTime(2027, 5, 1)),
        PeriodRange.month(DateTime(2027, 5, 31)),
      );
    });
  });
}
