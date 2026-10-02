import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/ids.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/domain/goal_progress.dart';
import '../../history/data/activity_repository.dart';
import '../../../core/database/activity_fallback.dart';

class FinanceRepository {
  FinanceRepository(this._db, this._goals, this._activity);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final ActivityRepository _activity;

  Stream<List<FinanceTransaction>> watchRange(PeriodRange range) =>
      (_db.select(_db.financeTransactions)
            ..where(
              (t) =>
                  t.occurredAt.isBiggerOrEqualValue(range.start.toUtc()) &
                  t.occurredAt.isSmallerThanValue(range.end.toUtc()),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<FinanceTransaction>> watchAll() => (_db.select(
    _db.financeTransactions,
  )..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])).watch();

  Future<void> add({
    required TransactionType type,
    required int amountMinor,
    required String category,
    String? note,
    MoneyTag tag = MoneyTag.personal,
    Goal? goal,
    DateTime? at,
    required String currency,
  }) => _db.transaction(() async {
    final id = newId();
    final when = (at ?? DateTime.now()).toUtc();
    await _db
        .into(_db.financeTransactions)
        .insert(
          FinanceTransactionsCompanion.insert(
            id: id,
            type: type,
            amountMinor: amountMinor,
            category: category.trim(),
            note: Value(
              note == null || note.trim().isEmpty ? null : note.trim(),
            ),
            tag: Value(tag),
            goalId: Value(goal?.id),
            occurredAt: when,
          ),
        );
    if (goal != null) {
      await _goals.contribute(
        goalId: goal.id,
        delta: GoalContribution.deltaFor(
          goal,
          money: Fmt.minorToMajor(amountMinor),
        ),
        source: ProgressSource.finance,
        sourceId: id,
        at: when,
      );
    }
    final signed = type == TransactionType.income ? amountMinor : -amountMinor;
    await _activity.record(
      area: LifeArea.finance,
      type: ActivityType.logged,
      title: note?.trim().isNotEmpty == true ? note!.trim() : category.trim(),
      subtitle: ActivityFallback.transaction(type, category.trim()),
      amountMinor: signed,
      entityType: 'finance',
      entityId: id,
      facts: {
        'type': type.name,
        'category': category.trim(),
        'note': note?.trim().isNotEmpty == true ? note!.trim() : null,
      },
      at: when,
    );
  });

  Future<void> delete(FinanceTransaction t) => _db.transaction(() async {
    await _goals.removeContributions(t.id);
    await _activity.removeFor('finance', t.id);
    await (_db.delete(
      _db.financeTransactions,
    )..where((x) => x.id.equals(t.id))).go();
  });
}

final financeRepositoryProvider = Provider<FinanceRepository>(
  (ref) => FinanceRepository(
    ref.watch(databaseProvider),
    ref.watch(goalsRepositoryProvider),
    ref.watch(activityRepositoryProvider),
  ),
);

final transactionsInRangeProvider =
    StreamProvider.family<List<FinanceTransaction>, PeriodRange>(
      (ref, range) => ref.watch(financeRepositoryProvider).watchRange(range),
    );

final allTransactionsProvider = StreamProvider<List<FinanceTransaction>>(
  (ref) => ref.watch(financeRepositoryProvider).watchAll(),
);
