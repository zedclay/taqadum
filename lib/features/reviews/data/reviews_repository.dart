import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../history/data/activity_repository.dart';

class ReviewPriority {
  const ReviewPriority({required this.title, required this.area, this.goal});

  factory ReviewPriority.fromJson(Map<String, dynamic> json) => ReviewPriority(
    title: json['title'] as String,
    area: LifeArea.values.byName(json['area'] as String),
    goal: json['goal'] as String?,
  );

  final String title;
  final LifeArea area;
  final String? goal;

  Map<String, dynamic> toJson() => {
    'title': title,
    'area': area.name,
    'goal': goal,
  };
}

List<ReviewPriority> decodePriorities(String raw) => (jsonDecode(raw) as List)
    .map((e) => ReviewPriority.fromJson(e as Map<String, dynamic>))
    .toList();

String encodeList(List<Object> items) => jsonEncode(items);

class ReviewsRepository {
  ReviewsRepository(this._db, this._activity);

  final AppDatabase _db;
  final ActivityRepository _activity;

  Stream<WeeklyReview?> watchWeekly(String weekStart) => (_db.select(
    _db.weeklyReviews,
  )..where((t) => t.weekStart.equals(weekStart))).watchSingleOrNull();

  Stream<MonthlyReview?> watchMonthly(String monthKey) => (_db.select(
    _db.monthlyReviews,
  )..where((t) => t.monthKey.equals(monthKey))).watchSingleOrNull();

  Stream<List<WeeklyReview>> watchAllWeekly() => (_db.select(
    _db.weeklyReviews,
  )..orderBy([(t) => OrderingTerm.desc(t.weekStart)])).watch();

  Stream<List<MonthlyReview>> watchAllMonthly() => (_db.select(
    _db.monthlyReviews,
  )..orderBy([(t) => OrderingTerm.desc(t.monthKey)])).watch();

  Future<void> saveWeekly({
    required String weekStart,
    required List<String> wentWellTags,
    String? wentWellNote,
    required List<String> changeTags,
    String? changeNote,
    String? biggestWin,
    required List<ReviewPriority> priorities,
    required bool complete,
    required String rangeLabel,
  }) => _db.transaction(() async {
    final existing = await (_db.select(
      _db.weeklyReviews,
    )..where((t) => t.weekStart.equals(weekStart))).getSingleOrNull();
    final now = DateTime.now().toUtc();
    await _db
        .into(_db.weeklyReviews)
        .insertOnConflictUpdate(
          WeeklyReviewsCompanion.insert(
            weekStart: weekStart,
            wentWellTags: Value(jsonEncode(wentWellTags)),
            wentWellNote: Value(_clean(wentWellNote)),
            changeTags: Value(jsonEncode(changeTags)),
            changeNote: Value(_clean(changeNote)),
            biggestWin: Value(_clean(biggestWin)),
            priorities: Value(
              jsonEncode(priorities.map((p) => p.toJson()).toList()),
            ),
            completedAt: Value(complete ? now : existing?.completedAt),
            updatedAt: now,
          ),
        );
    if (complete && existing?.completedAt == null) {
      await _activity.record(
        type: ActivityType.reviewed,
        title: 'Weekly review completed',
        subtitle: rangeLabel,
        entityType: 'weeklyReview',
        entityId: weekStart,
      );
    }
  });

  Future<void> saveMonthly({
    required String monthKey,
    required List<String> proudTags,
    String? proudNote,
    required List<String> heldBackTags,
    String? heldBackNote,
    required List<String> differentTags,
    String? differentNote,
    String? lesson,
    required List<ReviewPriority> priorities,
    required bool complete,
    required String monthLabel,
  }) => _db.transaction(() async {
    final existing = await (_db.select(
      _db.monthlyReviews,
    )..where((t) => t.monthKey.equals(monthKey))).getSingleOrNull();
    final now = DateTime.now().toUtc();
    await _db
        .into(_db.monthlyReviews)
        .insertOnConflictUpdate(
          MonthlyReviewsCompanion.insert(
            monthKey: monthKey,
            proudTags: Value(jsonEncode(proudTags)),
            proudNote: Value(_clean(proudNote)),
            heldBackTags: Value(jsonEncode(heldBackTags)),
            heldBackNote: Value(_clean(heldBackNote)),
            differentTags: Value(jsonEncode(differentTags)),
            differentNote: Value(_clean(differentNote)),
            lesson: Value(_clean(lesson)),
            priorities: Value(
              jsonEncode(priorities.map((p) => p.toJson()).toList()),
            ),
            completedAt: Value(complete ? now : existing?.completedAt),
            updatedAt: now,
          ),
        );
    if (complete && existing?.completedAt == null) {
      await _activity.record(
        type: ActivityType.reviewed,
        title: 'Monthly review completed',
        subtitle: monthLabel,
        entityType: 'monthlyReview',
        entityId: monthKey,
      );
    }
  });

  static String? _clean(String? v) =>
      v == null || v.trim().isEmpty ? null : v.trim();
}

final reviewsRepositoryProvider = Provider<ReviewsRepository>(
  (ref) => ReviewsRepository(
    ref.watch(databaseProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final weeklyReviewProvider = StreamProvider.family<WeeklyReview?, String>(
  (ref, weekStart) =>
      ref.watch(reviewsRepositoryProvider).watchWeekly(weekStart),
);

final monthlyReviewProvider = StreamProvider.family<MonthlyReview?, String>(
  (ref, monthKey) =>
      ref.watch(reviewsRepositoryProvider).watchMonthly(monthKey),
);

final allWeeklyReviewsProvider = StreamProvider<List<WeeklyReview>>(
  (ref) => ref.watch(reviewsRepositoryProvider).watchAllWeekly(),
);

final allMonthlyReviewsProvider = StreamProvider<List<MonthlyReview>>(
  (ref) => ref.watch(reviewsRepositoryProvider).watchAllMonthly(),
);
