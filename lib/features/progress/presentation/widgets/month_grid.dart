import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/localization/app_locale.dart';

String strengthLabel(BuildContext context, DayStrength s) {
  final l = context.l10n;
  return switch (s) {
    DayStrength.strong => l.progressStrong,
    DayStrength.steady => l.progressSteady,
    DayStrength.light => l.progressLight,
    DayStrength.none => l.progressNotLogged,
    DayStrength.future => l.calFutureDay,
  };
}

Color strengthFill(DayStrength s) => switch (s) {
  DayStrength.strong => AppColors.primaryStrong,
  DayStrength.steady => AppColors.brand.withValues(alpha: 0.55),
  DayStrength.light => AppColors.brand.withValues(alpha: 0.2),
  DayStrength.none || DayStrength.future => AppColors.surfaceMuted,
};

/// Weekday header labels starting at [weekStart]. Arabic has no short
/// weekday forms, so it always uses the one-letter calendar labels.
List<String> weekdayHeaders(int weekStart, {String pattern = 'EEEEE'}) {
  final effective = AppLocale.isArabic ? 'EEEEE' : pattern;
  // 2024-01-01 was a Monday.
  return [
    for (var i = 0; i < 7; i++)
      DateFormat(effective)
          .format(DateTime(2024, 1, 1 + (weekStart - 1 + i) % 7)),
  ];
}

/// Calendar month of day cells colored by [strengthOf].
class MonthGrid extends StatelessWidget {
  const MonthGrid({
    super.key,
    required this.month,
    required this.weekStart,
    required this.today,
    required this.strengthOf,
    this.selected,
    this.onTap,
    this.detailed = false,
  });

  final DateTime month;
  final int weekStart;
  final DateTime today;
  final DayStrength Function(DateTime day) strengthOf;
  final DateTime? selected;
  final ValueChanged<DateTime>? onTap;

  /// Detailed cells show a dot marker and include days of adjacent months.
  final bool detailed;

  @override
  Widget build(BuildContext context) {
    final range = PeriodRange.month(month);
    final lead = (range.start.weekday - weekStart + 7) % 7;
    final first = addDays(range.start, -lead);
    final total = ((lead + range.lengthInDays + 6) ~/ 7) * 7;
    final days = [for (var i = 0; i < total; i++) addDays(first, i)];
    final headers = weekdayHeaders(
      weekStart,
      pattern: detailed ? 'EEE' : 'EEEEE',
    );
    return Column(
      children: [
        Row(
          children: [
            for (final h in headers)
              Expanded(
                child: Center(
                  child: Text(
                    detailed ? h.toUpperCase() : h,
                    style: AppTypography.captionSmall,
                  ),
                ),
              ),
          ],
        ),
        AppSpacing.gap8,
        for (var row = 0; row < days.length; row += 7)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                for (final d in days.sublist(row, row + 7))
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: range.contains(d)
                          ? _Cell(
                              day: d,
                              strength: strengthOf(d),
                              isToday: d == today,
                              selected: selected == d,
                              detailed: detailed,
                              onTap: onTap == null ? null : () => onTap!(d),
                            )
                          : AspectRatio(
                              aspectRatio: 1,
                              child: detailed
                                  ? Center(
                                      child: Text(
                                        '${d.day}',
                                        style: AppTypography.caption.copyWith(
                                          color: AppColors.textMuted.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.day,
    required this.strength,
    required this.isToday,
    required this.selected,
    required this.detailed,
    this.onTap,
  });

  final DateTime day;
  final DayStrength strength;
  final bool isToday;
  final bool selected;
  final bool detailed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final strong = strength == DayStrength.strong;
    final fill = selected
        ? AppColors.primaryStrong
        : detailed
        ? switch (strength) {
            DayStrength.strong => AppColors.brand.withValues(alpha: 0.28),
            DayStrength.steady => AppColors.brand.withValues(alpha: 0.14),
            DayStrength.light => AppColors.surfaceMuted,
            _ => Colors.transparent,
          }
        : strengthFill(strength);
    final textColor = selected || (!detailed && strong)
        ? Colors.white
        : strength == DayStrength.future
        ? AppColors.textMuted
        : AppColors.textPrimary;
    final dot = switch (strength) {
      DayStrength.strong => AppColors.primaryStrong,
      DayStrength.steady => AppColors.brand,
      DayStrength.light => AppColors.brand.withValues(alpha: 0.4),
      _ => null,
    };
    return Semantics(
      button: onTap != null,
      selected: selected,
      label:
          '${DateFormat.MMMd().format(day)}, ${strengthLabel(context, strength)}',
      child: AspectRatio(
        aspectRatio: detailed ? 0.85 : 1,
        child: Material(
          color: fill,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(detailed ? 10 : 6),
            side: isToday && !selected
                ? const BorderSide(color: AppColors.primaryStrong, width: 1.5)
                : BorderSide.none,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(detailed ? 10 : 6),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${day.day}',
                  style: AppTypography.caption.copyWith(
                    color: textColor,
                    fontWeight: selected || isToday
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
                if (detailed) ...[
                  const SizedBox(height: 3),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? Colors.white
                          : dot ?? Colors.transparent,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Legend row for day strengths.
class StrengthLegend extends StatelessWidget {
  const StrengthLegend({super.key, this.includeRest = true});

  final bool includeRest;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final items = [
      (AppColors.primaryStrong, l.progressStrong),
      (AppColors.brand, l.progressSteady),
      (AppColors.brand.withValues(alpha: 0.35), l.progressLight),
      (
        AppColors.surfaceMuted,
        includeRest ? l.progressRest : l.progressNotLogged,
      ),
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSpacing.lg,
      runSpacing: 4,
      children: [
        for (final (color, label) in items)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: color == AppColors.surfaceMuted
                      ? Border.all(color: AppColors.border)
                      : null,
                ),
              ),
              const SizedBox(width: 6),
              Text(label, style: AppTypography.captionSmall),
            ],
          ),
      ],
    );
  }
}
