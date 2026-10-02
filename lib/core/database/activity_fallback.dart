// l10n-ignore-file: canonical English stored in activity_events.title/subtitle.
import '../utilities/formatters.dart';
import 'app_database.dart';

/// Language-neutral fallback text written with each activity event.
///
/// The UI never shows these strings for system rows: it renders them from the
/// event's structured facts in the active language. They keep exports and
/// rows from older versions readable, and their exact wording is what
/// [LegacyTextMigration] recognises, so it must not change.
abstract final class ActivityFallback {
  static const goalCreated = 'Goal created';
  static const goalUpdated = 'Goal updated';
  static const goalCompleted = 'Goal completed';
  static const progressLogged = 'Progress logged';
  static const habitAdded = 'Habit added';
  static const habit = 'Habit';
  static const note = 'Note';
  static const actionCompleted = 'Action completed';
  static const checkIn = 'Morning check-in';
  static const nightReview = 'Night review completed';
  static const weeklyReview = 'Weekly review completed';
  static const monthlyReview = 'Monthly review completed';

  static final prioritiesPattern = RegExp(r'^(\d+) priorities set$');
  static final ratingPattern = RegExp(r'^Day rated (\d+) of 5$');

  static String priorities(int count) => '$count priorities set';
  static String dayRated(int rating) => 'Day rated $rating of 5';
  static String studySession(String topic) => 'Study session · $topic';
  static String duration(int minutes) =>
      Fmt.inEnglish(() => Fmt.minutes(minutes));
  static String walk(int minutes) => 'Walk · ${duration(minutes)}';
  static String steps(int steps) => '${Fmt.number(steps)} steps';
  static String sleep(int minutes) => 'Sleep · ${duration(minutes)}';
  static String sleepWindow(DateTime bed, DateTime wake) =>
      'Bed ${Fmt.time(bed, use24h: true)} · '
      'Wake ${Fmt.time(wake, use24h: true)}';

  static String quran(QuranKind kind, String pages, int minutes) =>
      switch (kind) {
        QuranKind.reading => 'Read $pages pages',
        QuranKind.memorization => 'Memorized $pages page',
        QuranKind.revision => 'Revised $minutes min',
      };

  static String transactionType(TransactionType type) => switch (type) {
    TransactionType.income => 'Income',
    TransactionType.expense => 'Expense',
    TransactionType.saving => 'Saving',
  };

  static String transaction(TransactionType type, String category) =>
      '${transactionType(type)} · $category';

  static String workKind(WorkKind kind) => switch (kind) {
    WorkKind.deepWork => 'Deep work',
    WorkKind.lead => 'Lead contacted',
    WorkKind.followUp => 'Follow-up',
    WorkKind.meeting => 'Meeting',
    WorkKind.proposal => 'Proposal sent',
    WorkKind.clientWon => 'Client won',
  };
}
