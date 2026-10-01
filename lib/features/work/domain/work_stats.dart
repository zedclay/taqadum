import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';

class WorkTotals {
  const WorkTotals({
    this.deepMinutes = 0,
    this.leads = 0,
    this.followUps = 0,
    this.meetings = 0,
    this.proposals = 0,
    this.wins = 0,
    this.wonValueMinor = 0,
  });

  final int deepMinutes;
  final int leads;
  final int followUps;
  final int meetings;
  final int proposals;
  final int wins;
  final int wonValueMinor;

  bool get isEmpty =>
      deepMinutes == 0 &&
      leads == 0 &&
      followUps == 0 &&
      meetings == 0 &&
      proposals == 0 &&
      wins == 0;
}

/// A client or company derived from the activities logged against it.
class PipelineLead {
  const PipelineLead({
    required this.name,
    required this.title,
    required this.stage,
    required this.lastActivity,
    this.next,
    this.valueMinor,
  });

  final String name;
  final String title;

  /// Kind of the most recent activity: lead, followUp, meeting or proposal.
  final WorkKind stage;
  final DateTime lastActivity;
  final WorkActivity? next;
  final int? valueMinor;
}

abstract final class WorkStats {
  /// When an activity counts: its scheduled time if set, otherwise when it
  /// was logged.
  static DateTime momentOf(WorkActivity a) =>
      (a.scheduledAt ?? a.occurredAt).toLocal();

  static WorkTotals totals(Iterable<WorkActivity> items, PeriodRange range) {
    var deep = 0, leads = 0, follow = 0, meetings = 0, proposals = 0;
    var wins = 0, won = 0;
    for (final a in items) {
      if (!range.contains(momentOf(a))) continue;
      switch (a.kind) {
        case WorkKind.deepWork:
          deep += a.minutes ?? 0;
        case WorkKind.lead:
          leads++;
        case WorkKind.followUp:
          follow++;
        case WorkKind.meeting:
          meetings++;
        case WorkKind.proposal:
          proposals++;
        case WorkKind.clientWon:
          wins++;
          won += a.valueMinor ?? 0;
      }
    }
    return WorkTotals(
      deepMinutes: deep,
      leads: leads,
      followUps: follow,
      meetings: meetings,
      proposals: proposals,
      wins: wins,
      wonValueMinor: won,
    );
  }

  /// Meetings of [day] that are still ahead of [now].
  static int plannedMeetings(Iterable<WorkActivity> items, DateTime now) {
    final day = PeriodRange.day(now);
    return items
        .where(
          (a) =>
              a.kind == WorkKind.meeting &&
              a.scheduledAt != null &&
              day.contains(a.scheduledAt!) &&
              a.scheduledAt!.isAfter(now),
        )
        .length;
  }

  static List<WorkActivity> upcomingMeetings(
    Iterable<WorkActivity> items,
    DateTime now,
  ) =>
      items
          .where(
            (a) =>
                a.kind == WorkKind.meeting &&
                a.scheduledAt != null &&
                a.scheduledAt!.isAfter(now),
          )
          .toList()
        ..sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));

  static List<WorkActivity> deepWorkOn(
    Iterable<WorkActivity> items,
    PeriodRange day,
  ) =>
      items
          .where(
            (a) => a.kind == WorkKind.deepWork && day.contains(momentOf(a)),
          )
          .toList()
        ..sort((a, b) => momentOf(a).compareTo(momentOf(b)));

  /// Open conversations grouped by counterpart; won clients are excluded.
  static List<PipelineLead> pipeline(
    Iterable<WorkActivity> items,
    DateTime now,
  ) {
    final groups = <String, List<WorkActivity>>{};
    for (final a in items) {
      final name = a.counterpart?.trim();
      if (name == null || name.isEmpty || a.kind == WorkKind.deepWork) continue;
      groups.putIfAbsent(name.toLowerCase(), () => []).add(a);
    }
    final leads = <PipelineLead>[];
    for (final list in groups.values) {
      list.sort((a, b) => a.occurredAt.compareTo(b.occurredAt));
      final past = list.where((a) => !momentOf(a).isAfter(now)).toList();
      final latest = past.isEmpty ? list.last : past.last;
      if (list.any((a) => a.kind == WorkKind.clientWon)) continue;
      final upcoming =
          list
              .where(
                (a) => a.scheduledAt != null && a.scheduledAt!.isAfter(now),
              )
              .toList()
            ..sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));
      final origin = list.firstWhere(
        (a) => a.kind == WorkKind.lead,
        orElse: () => list.first,
      );
      final value = list.reversed
          .map((a) => a.valueMinor)
          .firstWhere((v) => v != null, orElse: () => null);
      leads.add(
        PipelineLead(
          name: latest.counterpart!.trim(),
          title: origin.title,
          stage: latest.kind,
          lastActivity: momentOf(latest),
          next: upcoming.firstOrNull,
          valueMinor: value,
        ),
      );
    }
    leads.sort((a, b) {
      final an = a.next?.scheduledAt, bn = b.next?.scheduledAt;
      if (an != null && bn != null) return an.compareTo(bn);
      if (an != null) return -1;
      if (bn != null) return 1;
      return b.lastActivity.compareTo(a.lastActivity);
    });
    return leads;
  }
}
