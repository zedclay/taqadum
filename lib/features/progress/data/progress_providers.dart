import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/period.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/async.dart';
import '../../history/data/activity_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../../settings/data/settings_store.dart';
import '../../today/data/tasks_repository.dart';
import '../domain/progress_calculator.dart';

/// Derived summary for [range] (never stored).
final periodSummaryProvider =
    Provider.family<AsyncValue<PeriodSummary>, PeriodRange>((ref, range) {
      final tasks = ref.watch(tasksInRangeProvider(range));
      final events = ref.watch(activityInRangeProvider(range));
      final prevTasks = ref.watch(tasksInRangeProvider(range.previous));
      final prevEvents = ref.watch(activityInRangeProvider(range.previous));
      final profile = ref.watch(profileProvider);
      final areas = ref.watch(focusAreasProvider);
      ref.watch(currentDayProvider);
      final now = ref.watch(clockProvider)();
      return combineAsync(
        [tasks, events, prevTasks, prevEvents],
        () => ProgressCalculator.summarize(
          range: range,
          tasks: tasks.requireValue,
          events: events.requireValue,
          previousTasks: prevTasks.requireValue,
          previousEvents: prevEvents.requireValue,
          now: now,
          areas: areas,
          notBefore: profile.value?.createdAt,
        ),
      );
    });

/// Day scores for every day in [range], used by the calendar.
final dayScoresProvider =
    Provider.family<AsyncValue<Map<String, DayScore>>, PeriodRange>((
      ref,
      range,
    ) {
      final tasks = ref.watch(tasksInRangeProvider(range));
      final events = ref.watch(activityInRangeProvider(range));
      return combineAsync(
        [tasks, events],
        () => ProgressCalculator.dayScores(
          tasks: tasks.requireValue,
          events: events.requireValue,
        ),
      );
    });
