import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import 'surahs.dart';

class QuranTotals {
  const QuranTotals({
    this.readPages = 0,
    this.memorizedPages = 0,
    this.revisionMinutes = 0,
  });

  final double readPages;
  final double memorizedPages;
  final int revisionMinutes;
}

class CurrentMemorization {
  const CurrentMemorization({
    required this.surah,
    required this.memorizedPages,
    required this.totalPages,
  });

  final int surah;
  final double memorizedPages;
  final int totalPages;

  double get ratio => (memorizedPages / totalPages).clamp(0.0, 1.0);
}

class RevisionItem {
  const RevisionItem({
    required this.title,
    required this.lastReviewed,
    required this.due,
    this.surah,
  });

  final String title;
  final DateTime lastReviewed;
  final bool due;
  final int? surah;
}

enum ConsistencyNote { start, returned, streak, steady }

abstract final class QuranStats {
  /// Portions not revised for this many days are suggested for review.
  static const reviewAfterDays = 3;

  static QuranTotals totals(Iterable<QuranLog> logs) {
    var read = 0.0;
    var memo = 0.0;
    var revision = 0;
    for (final log in logs) {
      switch (log.kind) {
        case QuranKind.reading:
          read += log.pages;
        case QuranKind.memorization:
          memo += log.pages;
        case QuranKind.revision:
          revision += log.minutes;
      }
    }
    return QuranTotals(
      readPages: read,
      memorizedPages: memo,
      revisionMinutes: revision,
    );
  }

  /// The surah of the most recent memorization entry, with pages memorized
  /// in it across all entries. Entries beyond the surah's length (re-logged
  /// portions) count it as complete rather than exceeding it.
  static CurrentMemorization? currentMemorization(List<QuranLog> logs) {
    final memo =
        logs
            .where(
              (l) =>
                  l.kind == QuranKind.memorization &&
                  surahNumberOf(l.surah) != null,
            )
            .toList()
          ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    if (memo.isEmpty) return null;
    final surah = surahNumberOf(memo.first.surah)!;
    final pages = memo
        .where((l) => surahNumberOf(l.surah) == surah)
        .fold<double>(0, (s, l) => s + l.pages);
    final total = surahPageCount(surah);
    return CurrentMemorization(
      surah: surah,
      memorizedPages: pages.clamp(0, total).toDouble(),
      totalPages: total,
    );
  }

  /// Strips the "(Surah n)" suffix: "Al-Baqarah (Surah 2) · Pages 18–21"
  /// becomes "Al-Baqarah · Pages 18–21".
  static String displayTitle(String label) =>
      label.replaceAll(RegExp(r'\s*\(Surah \d+\)'), '').trim();

  /// Memorized and revised portions with when they were last touched; the
  /// ones not reviewed recently come first.
  static List<RevisionItem> revisionSchedule(
    List<QuranLog> logs,
    DateTime now,
  ) {
    final latest = <String, QuranLog>{};
    for (final log in logs) {
      if (log.kind == QuranKind.reading) continue;
      final label = log.surah?.trim();
      if (label == null || label.isEmpty) continue;
      final key = displayTitle(label);
      final seen = latest[key];
      if (seen == null || log.occurredAt.isAfter(seen.occurredAt)) {
        latest[key] = log;
      }
    }
    final today = startOfDay(now);
    final items = [
      for (final MapEntry(:key, :value) in latest.entries)
        RevisionItem(
          title: key,
          lastReviewed: value.occurredAt.toLocal(),
          due:
              today.difference(startOfDay(value.occurredAt)).inDays >=
              reviewAfterDays,
          surah: surahNumberOf(value.surah),
        ),
    ];
    items.sort((a, b) {
      if (a.due != b.due) return a.due ? -1 : 1;
      return a.lastReviewed.compareTo(b.lastReviewed);
    });
    return items;
  }

  static Set<String> activeDays(Iterable<QuranLog> logs) => {
    for (final l in logs) dayKeyOf(l.occurredAt),
  };

  /// Consecutive active days ending today (or yesterday if today is empty).
  static int streak(Set<String> active, DateTime today) {
    var day = startOfDay(today);
    if (!active.contains(dayKeyOf(day))) day = addDays(day, -1);
    var count = 0;
    while (active.contains(dayKeyOf(day))) {
      count++;
      day = addDays(day, -1);
    }
    return count;
  }

  static ConsistencyNote note(Set<String> active, DateTime today) {
    if (active.isEmpty) return ConsistencyNote.start;
    final t = dayKeyOf(today);
    final y = dayKeyOf(addDays(today, -1));
    final before = dayKeyOf(addDays(today, -2));
    if (active.contains(t) && !active.contains(y) && active.contains(before)) {
      return ConsistencyNote.returned;
    }
    return streak(active, today) >= 2
        ? ConsistencyNote.streak
        : ConsistencyNote.steady;
  }
}
