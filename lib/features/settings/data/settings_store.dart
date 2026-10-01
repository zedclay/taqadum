import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';

abstract final class SettingKeys {
  static const focusAreas = 'focus.areas';
  static const dayPace = 'day.pace';
  static const quranDailyPages = 'target.quranPages';
  static const deepWorkMinutes = 'target.deepWork';
  static const leadsPerDay = 'target.leads';
  static const followUpsPerDay = 'target.followUps';
  static const walkMinutes = 'target.walk';
  static const sleepMinutes = 'target.sleep';
  static const studyMinutes = 'target.study';
  static const memorizationQuarters = 'target.memoQuarters';
  static const revisionMinutes = 'target.revision';
  static const workoutsPerWeek = 'target.workouts';
  static const learningFocus = 'learning.focus';
}

/// Daily targets used to derive module progress. All editable in-app.
class DailyTargets {
  const DailyTargets({
    this.quranPages = 6,
    this.deepWorkMinutes = 120,
    this.leads = 5,
    this.followUps = 3,
    this.walkMinutes = 30,
    this.sleepMinutes = 450,
    this.studyMinutes = 45,
    this.memorizationQuarters = 1,
    this.revisionMinutes = 10,
    this.workoutsPerWeek = 3,
  });

  final int quranPages;
  final int deepWorkMinutes;
  final int leads;
  final int followUps;
  final int walkMinutes;
  final int sleepMinutes;
  final int studyMinutes;

  /// Daily memorization target in quarter pages (1 = ¼ page).
  final int memorizationQuarters;
  final int revisionMinutes;
  final int workoutsPerWeek;

  double get memorizationPages => memorizationQuarters / 4;
}

class LearningFocus {
  const LearningFocus({
    required this.skill,
    this.description,
    required this.startedOn,
    this.weeks = 4,
    this.nextStep,
  });

  factory LearningFocus.fromJson(Map<String, dynamic> json) => LearningFocus(
    skill: json['skill'] as String,
    description: json['description'] as String?,
    startedOn: DateTime.parse(json['startedOn'] as String),
    weeks: json['weeks'] as int? ?? 4,
    nextStep: json['nextStep'] as String?,
  );

  final String skill;
  final String? description;
  final DateTime startedOn;
  final int weeks;
  final String? nextStep;

  Map<String, dynamic> toJson() => {
    'skill': skill,
    'description': description,
    'startedOn': startedOn.toIso8601String(),
    'weeks': weeks,
    'nextStep': nextStep,
  };
}

class SettingsStore {
  SettingsStore(this._db);

  final AppDatabase _db;

  Stream<Map<String, String>> watchAll() => _db
      .select(_db.appSettings)
      .watch()
      .map((rows) => {for (final r in rows) r.key: r.value});

  Future<String?> get(String key) async {
    final row = await (_db.select(
      _db.appSettings,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> set(String key, String value) => _db
      .into(_db.appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion(key: Value(key), value: Value(value)),
      );

  Future<void> setFocusAreas(List<LifeArea> areas) => set(
    SettingKeys.focusAreas,
    jsonEncode(areas.map((a) => a.name).toList()),
  );

  Future<void> setDayPace(DayPace pace) => set(SettingKeys.dayPace, pace.name);

  Future<void> setInt(String key, int value) => set(key, '$value');

  Future<void> setLearningFocus(LearningFocus focus) =>
      set(SettingKeys.learningFocus, jsonEncode(focus.toJson()));

  static List<LifeArea> parseFocusAreas(Map<String, String> map) {
    final raw = map[SettingKeys.focusAreas];
    if (raw == null) return LifeArea.values;
    final names = (jsonDecode(raw) as List).cast<String>();
    final areas = LifeArea.values.where((a) => names.contains(a.name)).toList();
    return areas.isEmpty ? LifeArea.values : areas;
  }

  static DailyTargets parseTargets(Map<String, String> map) {
    int read(String key, int fallback) =>
        int.tryParse(map[key] ?? '') ?? fallback;
    const d = DailyTargets();
    return DailyTargets(
      quranPages: read(SettingKeys.quranDailyPages, d.quranPages),
      deepWorkMinutes: read(SettingKeys.deepWorkMinutes, d.deepWorkMinutes),
      leads: read(SettingKeys.leadsPerDay, d.leads),
      followUps: read(SettingKeys.followUpsPerDay, d.followUps),
      walkMinutes: read(SettingKeys.walkMinutes, d.walkMinutes),
      sleepMinutes: read(SettingKeys.sleepMinutes, d.sleepMinutes),
      studyMinutes: read(SettingKeys.studyMinutes, d.studyMinutes),
      memorizationQuarters: read(
        SettingKeys.memorizationQuarters,
        d.memorizationQuarters,
      ),
      revisionMinutes: read(SettingKeys.revisionMinutes, d.revisionMinutes),
      workoutsPerWeek: read(SettingKeys.workoutsPerWeek, d.workoutsPerWeek),
    );
  }

  static DayPace parsePace(Map<String, String> map) =>
      DayPace.values.firstWhere(
        (p) => p.name == map[SettingKeys.dayPace],
        orElse: () => DayPace.balanced,
      );

  static LearningFocus? parseLearningFocus(Map<String, String> map) {
    final raw = map[SettingKeys.learningFocus];
    if (raw == null) return null;
    return LearningFocus.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}

final settingsStoreProvider = Provider<SettingsStore>(
  (ref) => SettingsStore(ref.watch(databaseProvider)),
);

final settingsMapProvider = StreamProvider<Map<String, String>>(
  (ref) => ref.watch(settingsStoreProvider).watchAll(),
);

final focusAreasProvider = Provider<List<LifeArea>>((ref) {
  final map = ref.watch(settingsMapProvider).value ?? const {};
  return SettingsStore.parseFocusAreas(map);
});

final dailyTargetsProvider = Provider<DailyTargets>((ref) {
  final map = ref.watch(settingsMapProvider).value ?? const {};
  return SettingsStore.parseTargets(map);
});

final learningFocusProvider = Provider<LearningFocus?>((ref) {
  final map = ref.watch(settingsMapProvider).value ?? const {};
  return SettingsStore.parseLearningFocus(map);
});
