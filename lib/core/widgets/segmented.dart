import 'package:flutter/material.dart';

import '../domain/period.dart';
import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

/// Segmented control on a muted rail (Week/Month/Year, Target/Routine/Milestone…).
class SegmentedPills<T> extends StatelessWidget {
  const SegmentedPills({
    super.key,
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onChanged,
    this.height = 40,
    this.compact = false,
  });

  final List<T> values;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;
  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(compact ? 10 : AppRadius.md),
      ),
      child: Row(
        mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
        children: [
          for (final value in values)
            _wrap(
              Semantics(
                selected: value == selected,
                button: true,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(value),
                  child: AnimatedContainer(
                    duration: AppMotion.of(context, AppMotion.small),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 8),
                    decoration: BoxDecoration(
                      color: value == selected
                          ? AppColors.surface
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        compact ? 8 : AppRadius.sm + 2,
                      ),
                      boxShadow: value == selected
                          ? const [
                              BoxShadow(
                                color: AppColors.cardShadow,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      labelOf(value),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          (compact
                                  ? AppTypography.caption
                                  : AppTypography.bodyMedium)
                              .copyWith(
                                color: value == selected
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                                fontWeight: value == selected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _wrap(Widget child) =>
      compact ? Flexible(child: child) : Expanded(child: child);
}

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    this.kinds = const [PeriodKind.week, PeriodKind.month, PeriodKind.year],
  });

  final PeriodKind selected;
  final ValueChanged<PeriodKind> onChanged;
  final List<PeriodKind> kinds;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SegmentedPills<PeriodKind>(
      values: kinds,
      selected: selected,
      onChanged: onChanged,
      labelOf: (k) => switch (k) {
        PeriodKind.day => l.commonToday,
        PeriodKind.week => l.commonWeek,
        PeriodKind.month => l.commonMonth,
        PeriodKind.year => l.commonYear,
      },
    );
  }
}
