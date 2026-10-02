import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../domain/enums.dart';
import 'legacy_text_migration.dart';
import 'tables.dart';

export '../domain/enums.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    Goals,
    GoalActions,
    GoalMilestones,
    GoalProgressEvents,
    Tasks,
    MorningCheckIns,
    NightReviews,
    QuranLogs,
    WorkActivities,
    FinanceTransactions,
    Habits,
    HabitLogs,
    WorkoutLogs,
    WalkingLogs,
    SleepLogs,
    LearningResources,
    LearningSessions,
    Notes,
    WeeklyReviews,
    MonthlyReviews,
    Reminders,
    ActivityEvents,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'taqaddum'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _createIndexes();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(habits, habits.templateId);
        await m.addColumn(activityEvents, activityEvents.facts);
        await LegacyTextMigration(this).run();
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _createIndexes() async {
    const statements = [
      'CREATE INDEX IF NOT EXISTS idx_tasks_day ON tasks (day_key)',
      'CREATE INDEX IF NOT EXISTS idx_tasks_goal ON tasks (goal_id)',
      'CREATE INDEX IF NOT EXISTS idx_events_goal ON goal_progress_events (goal_id, occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_quran_time ON quran_logs (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_work_time ON work_activities (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_finance_time ON finance_transactions (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_habit_logs_day ON habit_logs (day_key)',
      'CREATE INDEX IF NOT EXISTS idx_workouts_time ON workout_logs (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_walks_time ON walking_logs (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_learning_time ON learning_sessions (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_activity_time ON activity_events (occurred_at)',
      'CREATE INDEX IF NOT EXISTS idx_activity_entity ON activity_events (entity_type, entity_id)',
    ];
    for (final sql in statements) {
      await customStatement(sql);
    }
  }

  /// Removes every user record while keeping the schema.
  Future<void> wipeAllData() => transaction(() async {
    for (final table in allTables.toList().reversed) {
      await delete(table).go();
    }
  });
}
