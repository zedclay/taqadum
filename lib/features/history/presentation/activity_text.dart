import 'dart:convert';

import '../../../core/database/activity_fallback.dart';
import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utilities/bidi.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/search_text.dart';
import '../../finance/presentation/transaction_form.dart';
import '../../learning/data/learning_repository.dart';
import '../../onboarding/domain/onboarding_draft.dart';
import '../../quran/data/quran_repository.dart';
import '../../quran/domain/surahs.dart';
import '../../work/presentation/work_log_form.dart';

/// Renders activity rows in the active language.
///
/// System rows (check-ins, walks, reviews…) are rebuilt from their structured
/// facts; user-written titles, notes and names are shown verbatim.
class ActivityText {
  ActivityText(this.l, this.event, {this.use24h = true})
    : _facts = _decode(event.facts);

  final AppLocalizations l;
  final ActivityEvent event;
  final bool use24h;
  final Map<String, Object?> _facts;

  bool get _arabic => l.localeName.startsWith('ar');

  static Map<String, Object?> _decode(String? json) {
    if (json == null || json.isEmpty) return const {};
    try {
      final value = jsonDecode(json);
      return value is Map<String, Object?> ? value : const {};
    } on FormatException {
      return const {};
    }
  }

  int? _int(String key) => (_facts[key] as num?)?.toInt();
  double? _num(String key) => (_facts[key] as num?)?.toDouble();
  String? _str(String key) {
    final v = _facts[key];
    return v is String && v.trim().isNotEmpty ? v : null;
  }

  String? _user(String key) {
    final v = _str(key);
    return v == null ? null : bidiSafe(v);
  }

  T? _enum<T extends Enum>(List<T> values, String key) {
    final name = _str(key);
    if (name == null) return null;
    for (final v in values) {
      if (v.name == name) return v;
    }
    return null;
  }

  String? get _template {
    final id = _str('template');
    return id == null ? null : starterTargetLabel(l, id);
  }

  String get title {
    final e = event;
    switch (e.entityType) {
      case 'checkin':
        return l.activityCheckInTitle;
      case 'nightReview':
        return l.activityNightReviewTitle;
      case 'weeklyReview':
        return l.activityWeeklyReviewTitle;
      case 'monthlyReview':
        return l.activityMonthlyReviewTitle;
      case 'habit' || 'habitLog':
        return _template ?? e.title;
      case 'quran':
        final kind = _enum(QuranKind.values, 'kind');
        final pages = _num('pages') ?? 0;
        final minutes = _int('minutes') ?? 0;
        return switch (kind) {
          QuranKind.reading => l.quranReadN(
            pages,
            QuranRepository.pagesLabel(pages),
          ),
          QuranKind.memorization => l.quranMemorizedN(
            pages,
            QuranRepository.pagesLabel(pages),
          ),
          QuranKind.revision => l.quranRevisedN(minutes),
          null => e.title,
        };
      case 'learning':
        final topic = _str('topic');
        return topic == null
            ? e.title
            : l.activityStudySession(bidiSafe(topic));
      case 'finance':
        final category = _str('category');
        if (category == null) return e.title;
        return _str('note') ?? financeCategoryLabel(l, category);
      case 'walk':
        final minutes = _int('minutes');
        return minutes == null
            ? e.title
            : l.activityWalkTitle(Fmt.minutes(minutes));
      case 'sleep':
        final minutes = _int('minutes');
        return minutes == null
            ? e.title
            : l.activitySleepTitle(Fmt.minutes(minutes));
    }
    return e.title;
  }

  String? get subtitle {
    final e = event;
    final stored = e.subtitle;
    switch (e.entityType) {
      case 'checkin':
        final count = _int('count');
        return count == null ? stored : l.activityPrioritiesSet(count);
      case 'nightReview':
        final rating = _int('rating');
        return rating == null ? stored : l.activityDayRated(rating);
      case 'weeklyReview':
        final key = e.entityId;
        if (key == null) return stored;
        final start = dateOfKey(key);
        return l.activityDateRange(
          Fmt.monthDay(start),
          Fmt.monthDay(addDays(start, 6)),
        );
      case 'monthlyReview':
        final key = e.entityId;
        return key == null ? stored : Fmt.monthYear(dateOfKey(key));
      case 'habit':
        return l.activityHabitAdded;
      case 'habitLog':
        return stored == null || stored == ActivityFallback.habit
            ? l.activityHabit
            : stored;
      case 'goal':
        return switch (e.type) {
          ActivityType.created => l.activityGoalCreated,
          ActivityType.completed => l.activityGoalCompleted,
          _ => l.activityGoalUpdated,
        };
      case 'goalProgress':
        return stored == null || stored == ActivityFallback.progressLogged
            ? l.activityProgressLogged
            : stored;
      case 'note':
        return stored == null || stored == ActivityFallback.note
            ? l.activityNote
            : stored;
      case 'task':
        return stored == ActivityFallback.actionCompleted ||
                stored == LearningTaskNote.applied
            ? null
            : stored;
      case 'quran':
        return stored == null
            ? null
            : localizeSurahLabel(stored, arabic: _arabic);
      case 'learning':
        final minutes = _int('minutes');
        if (minutes == null) return stored;
        return [?_user('skill'), Fmt.minutes(minutes)].join(' · ');
      case 'work':
        final kind = _enum(WorkKind.values, 'kind');
        if (kind == null) return stored;
        final minutes = _int('minutes');
        return [
          workKindText(l, kind),
          ?_user('counterpart'),
          if (minutes != null) Fmt.minutes(minutes),
        ].join(' · ');
      case 'finance':
        final type = _enum(TransactionType.values, 'type');
        final category = _str('category');
        if (type == null || category == null) return stored;
        return '${transactionTypeText(l, type)} · '
            '${bidiSafe(financeCategoryLabel(l, category))}';
      case 'workout':
        final minutes = _int('minutes');
        if (minutes == null) return stored;
        return [?_user('detail'), Fmt.minutes(minutes)].join(' · ');
      case 'walk':
        if (_facts.isEmpty) return stored;
        final steps = _int('steps');
        return steps == null ? null : l.activitySteps(steps, Fmt.number(steps));
      case 'sleep':
        final bed = _int('bed');
        final wake = _int('wake');
        if (bed == null || wake == null) return stored;
        return l.activitySleepWindow(
          Fmt.timeOfDay(bed, use24h: use24h),
          Fmt.timeOfDay(wake, use24h: use24h),
        );
    }
    return stored;
  }

  /// Search over what the user actually sees, plus the stored text so
  /// English queries still find rows while the UI is in Arabic.
  bool matches(String query, {String? areaLabel}) => matchesSearch([
    title,
    subtitle,
    areaLabel,
    event.title,
    event.subtitle,
  ], query);
}
