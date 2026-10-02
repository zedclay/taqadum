import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/providers.dart';
import '../../history/data/activity_repository.dart';
import 'tasks_repository.dart';
import '../../../core/database/activity_fallback.dart';

class NightReviewDraft {
  const NightReviewDraft({
    required this.dayKey,
    required this.rating,
    this.wentWellTags = const [],
    this.wentWellNote,
    this.betterTags = const [],
    this.betterNote,
    this.biggestWin,
    this.moveToTomorrow = const [],
  });

  final String dayKey;
  final int rating;
  final List<String> wentWellTags;
  final String? wentWellNote;
  final List<String> betterTags;
  final String? betterNote;
  final String? biggestWin;
  final List<Task> moveToTomorrow;
}

class DailyRepository {
  DailyRepository(this._db, this._tasks, this._activity);

  final AppDatabase _db;
  final TasksRepository _tasks;
  final ActivityRepository _activity;

  Stream<MorningCheckIn?> watchCheckIn(String dayKey) => (_db.select(
    _db.morningCheckIns,
  )..where((t) => t.dayKey.equals(dayKey))).watchSingleOrNull();

  Stream<NightReview?> watchNightReview(String dayKey) => (_db.select(
    _db.nightReviews,
  )..where((t) => t.dayKey.equals(dayKey))).watchSingleOrNull();

  Stream<List<MorningCheckIn>> watchCheckIns(PeriodRange range) =>
      (_db.select(_db.morningCheckIns)..where(
            (t) =>
                t.dayKey.isBiggerOrEqualValue(range.startKey) &
                t.dayKey.isSmallerOrEqualValue(range.endKeyInclusive),
          ))
          .watch();

  Stream<List<NightReview>> watchNightReviews(PeriodRange range) =>
      (_db.select(_db.nightReviews)..where(
            (t) =>
                t.dayKey.isBiggerOrEqualValue(range.startKey) &
                t.dayKey.isSmallerOrEqualValue(range.endKeyInclusive),
          ))
          .watch();

  /// Saves the check-in and the day's priorities atomically. New custom
  /// priority titles become tasks for the day.
  Future<void> saveCheckIn({
    required String dayKey,
    required Energy energy,
    required Capacity capacity,
    String? intention,
    required List<String> priorityTaskIds,
    List<(String, LifeArea)> newPriorities = const [],
  }) => _db.transaction(() async {
    final ids = [...priorityTaskIds];
    for (final (title, area) in newPriorities) {
      ids.add(
        await _tasks.add(TaskDraft(title: title, area: area, dayKey: dayKey)),
      );
    }
    await _tasks.setPriorities(dayKey, ids);
    final existing = await (_db.select(
      _db.morningCheckIns,
    )..where((t) => t.dayKey.equals(dayKey))).getSingleOrNull();
    await _db
        .into(_db.morningCheckIns)
        .insertOnConflictUpdate(
          MorningCheckInsCompanion.insert(
            dayKey: dayKey,
            energy: energy,
            capacity: capacity,
            intention: Value(
              intention == null || intention.trim().isEmpty
                  ? null
                  : intention.trim(),
            ),
            createdAt: DateTime.now().toUtc(),
          ),
        );
    if (existing == null) {
      await _activity.record(
        type: ActivityType.reviewed,
        title: ActivityFallback.checkIn,
        subtitle: ActivityFallback.priorities(ids.length),
        entityType: 'checkin',
        entityId: dayKey,
        facts: {'count': ids.length},
      );
    }
  });

  Future<void> saveNightReview(NightReviewDraft d) => _db.transaction(() async {
    final tomorrow = dayKeyOf(addDays(dateOfKey(d.dayKey), 1));
    for (final task in d.moveToTomorrow) {
      await _tasks.reschedule(task, dayKey: tomorrow);
    }
    final existing = await (_db.select(
      _db.nightReviews,
    )..where((t) => t.dayKey.equals(d.dayKey))).getSingleOrNull();
    await _db
        .into(_db.nightReviews)
        .insertOnConflictUpdate(
          NightReviewsCompanion.insert(
            dayKey: d.dayKey,
            rating: d.rating,
            wentWellTags: Value(jsonEncode(d.wentWellTags)),
            wentWellNote: Value(_clean(d.wentWellNote)),
            betterTags: Value(jsonEncode(d.betterTags)),
            betterNote: Value(_clean(d.betterNote)),
            biggestWin: Value(_clean(d.biggestWin)),
            createdAt: DateTime.now().toUtc(),
          ),
        );
    if (existing == null) {
      await _activity.record(
        type: ActivityType.reviewed,
        title: ActivityFallback.nightReview,
        subtitle: ActivityFallback.dayRated(d.rating),
        entityType: 'nightReview',
        entityId: d.dayKey,
        facts: {'rating': d.rating},
      );
    }
  });

  static String? _clean(String? v) =>
      v == null || v.trim().isEmpty ? null : v.trim();
}

final dailyRepositoryProvider = Provider<DailyRepository>(
  (ref) => DailyRepository(
    ref.watch(databaseProvider),
    ref.watch(tasksRepositoryProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final checkInProvider = StreamProvider.family<MorningCheckIn?, String>(
  (ref, dayKey) => ref.watch(dailyRepositoryProvider).watchCheckIn(dayKey),
);

final nightReviewProvider = StreamProvider.family<NightReview?, String>(
  (ref, dayKey) => ref.watch(dailyRepositoryProvider).watchNightReview(dayKey),
);

final checkInsInRangeProvider =
    StreamProvider.family<List<MorningCheckIn>, PeriodRange>(
      (ref, range) => ref.watch(dailyRepositoryProvider).watchCheckIns(range),
    );

List<String> decodeTags(String raw) => (jsonDecode(raw) as List).cast<String>();
