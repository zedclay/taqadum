import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../auth/data/session_controller.dart';
import '../../health/data/health_repository.dart';
import '../../notifications/data/reminders_repository.dart';
import '../../settings/data/settings_store.dart';
import '../domain/onboarding_draft.dart';

class OnboardingService {
  OnboardingService(this._ref);

  final Ref _ref;

  Future<void> complete(
    OnboardingDraft draft,
    List<StarterTarget> starters,
  ) async {
    final db = _ref.read(databaseProvider);
    final store = _ref.read(settingsStoreProvider);
    final health = _ref.read(healthRepositoryProvider);
    final reminders = _ref.read(remindersRepositoryProvider);
    await db.transaction(() async {
      await store.setFocusAreas(draft.orderedAreas);
      await store.setDayPace(draft.pace);
      for (final target in draft.selectedTargets(starters)) {
        await health.addHabit(name: target.label, area: target.area);
      }
      await reminders.ensureDefaults();
      await reminders.setTime(ReminderIds.morningCheckIn, draft.morningMinute);
      await reminders.setEnabled(ReminderIds.morningCheckIn, draft.morningOn);
      await reminders.setTime(ReminderIds.nightReview, draft.eveningMinute);
      await reminders.setEnabled(ReminderIds.nightReview, draft.eveningOn);
      if (!draft.areas.contains(LifeArea.quran)) {
        await reminders.setEnabled(ReminderIds.quranReading, false);
      }
      if (!draft.areas.contains(LifeArea.work)) {
        await reminders.setEnabled(ReminderIds.workFollowUp, false);
      }
    });
    if (draft.morningOn || draft.eveningOn) {
      try {
        await _ref.read(notificationServiceProvider).requestPermission();
      } catch (_) {
        // Reminders stay configured; permission can be granted later.
      }
    }
    await _ref.read(sessionProvider.notifier).completeOnboarding();
  }

  /// Skipping keeps every area and default reminders.
  Future<void> skip() async {
    await _ref.read(remindersRepositoryProvider).ensureDefaults();
    await _ref.read(sessionProvider.notifier).completeOnboarding();
  }
}

final onboardingServiceProvider = Provider<OnboardingService>(
  OnboardingService.new,
);
