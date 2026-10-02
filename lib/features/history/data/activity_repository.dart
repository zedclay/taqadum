import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/ids.dart';

class ActivityFilter {
  const ActivityFilter({
    this.query = '',
    this.area,
    this.reviewsOnly = false,
    this.type,
    this.range,
  });

  final String query;
  final LifeArea? area;
  final bool reviewsOnly;
  final ActivityType? type;
  final PeriodRange? range;

  ActivityFilter copyWith({
    String? query,
    LifeArea? Function()? area,
    bool? reviewsOnly,
    ActivityType? Function()? type,
    PeriodRange? Function()? range,
  }) => ActivityFilter(
    query: query ?? this.query,
    area: area != null ? area() : this.area,
    reviewsOnly: reviewsOnly ?? this.reviewsOnly,
    type: type != null ? type() : this.type,
    range: range != null ? range() : this.range,
  );

  bool get isDefault =>
      query.isEmpty &&
      area == null &&
      !reviewsOnly &&
      type == null &&
      range == null;

  @override
  bool operator ==(Object other) =>
      other is ActivityFilter &&
      other.query == query &&
      other.area == area &&
      other.reviewsOnly == reviewsOnly &&
      other.type == type &&
      other.range == range;

  @override
  int get hashCode => Object.hash(query, area, reviewsOnly, type, range);
}

class ActivityRepository {
  ActivityRepository(this._db);

  final AppDatabase _db;

  Future<void> record({
    LifeArea? area,
    required ActivityType type,
    required String title,
    String? subtitle,
    int? amountMinor,
    String? entityType,
    String? entityId,
    Map<String, Object?>? facts,
    DateTime? at,
  }) => _db
      .into(_db.activityEvents)
      .insert(
        ActivityEventsCompanion.insert(
          id: newId(),
          area: Value(area),
          type: type,
          title: title,
          subtitle: Value(subtitle),
          amountMinor: Value(amountMinor),
          entityType: Value(entityType),
          entityId: Value(entityId),
          facts: Value(facts == null ? null : jsonEncode(facts)),
          occurredAt: (at ?? DateTime.now()).toUtc(),
        ),
      );

  Future<void> removeFor(
    String entityType,
    String entityId, {
    ActivityType? type,
  }) {
    final q = _db.delete(_db.activityEvents)
      ..where(
        (t) =>
            t.entityType.equals(entityType) &
            t.entityId.equals(entityId) &
            (type == null ? const Constant(true) : t.type.equalsValue(type)),
      );
    return q.go();
  }

  Stream<List<ActivityEvent>> watchRange(PeriodRange range) {
    final q = _db.select(_db.activityEvents)
      ..where(
        (t) =>
            t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
            t.occurredAt.isSmallerThanValue(range.end.toUtc()),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]);
    return q.watch();
  }

  /// Applies every filter except [ActivityFilter.query]; text search runs on
  /// the localized display text (see `ActivityText.matches`).
  Stream<List<ActivityEvent>> watchFiltered(ActivityFilter filter) {
    final q = _db.select(_db.activityEvents);
    q.where((t) {
      Expression<bool> e = const Constant(true);
      if (filter.range != null) {
        e =
            e &
            t.occurredAt.isBiggerOrEqualValue(filter.range!.start.toUtc()) &
            t.occurredAt.isSmallerThanValue(filter.range!.end.toUtc());
      }
      if (filter.reviewsOnly) {
        e = e & t.type.equalsValue(ActivityType.reviewed);
      } else if (filter.area != null) {
        e = e & t.area.equalsValue(filter.area);
      }
      if (filter.type != null) e = e & t.type.equalsValue(filter.type);
      return e;
    });
    q.orderBy([(t) => OrderingTerm.desc(t.occurredAt)]);
    return q.watch();
  }

  Future<ActivityEvent?> earliest() =>
      (_db.select(_db.activityEvents)
            ..orderBy([(t) => OrderingTerm.asc(t.occurredAt)])
            ..limit(1))
          .getSingleOrNull();
}

final activityRepositoryProvider = Provider<ActivityRepository>(
  (ref) => ActivityRepository(ref.watch(databaseProvider)),
);

final activityInRangeProvider =
    StreamProvider.family<List<ActivityEvent>, PeriodRange>(
      (ref, range) => ref.watch(activityRepositoryProvider).watchRange(range),
    );

final filteredActivityProvider =
    StreamProvider.family<List<ActivityEvent>, ActivityFilter>(
      (ref, filter) =>
          ref.watch(activityRepositoryProvider).watchFiltered(filter),
    );
