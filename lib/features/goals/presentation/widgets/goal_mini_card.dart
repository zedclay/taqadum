import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utilities/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/area_style.dart';
import '../../../../core/widgets/progress.dart';
import '../../data/goals_repository.dart';
import '../../domain/goal_progress.dart';
import '../../domain/goal_units.dart';
import '../goal_labels.dart';
import '../../../../core/utilities/bidi.dart';

/// Formats a goal quantity with its unit, e.g. "170,000 DZD" or "0.8 juz".
String goalValue(
  AppLocalizations l,
  Goal goal,
  double value, {
  bool compact = false,
}) {
  final unit = goal.unit.trim();
  final number = compact ? Fmt.compact(value) : Fmt.number(value);
  return unitQuantity(
    l,
    GoalUnits.isCurrency(unit) ? unit.toUpperCase() : unit,
    value,
    number,
  );
}

/// One-line description of where a goal stands.
String goalProgressLine(BuildContext context, GoalView view) {
  final l = context.l10n;
  final g = view.goal;
  final p = view.progress;
  return switch (g.type) {
    GoalType.milestone => l.goalMiniMilestones(
      p.current.round(),
      p.target.round(),
    ),
    GoalType.routine => switch (p.periodLabel) {
      PeriodKind.day => l.goalMiniRoutineDay(
        p.current.round(),
        p.target.round(),
      ),
      PeriodKind.month => l.goalMiniRoutineMonth(
        p.current.round(),
        p.target.round(),
      ),
      _ => l.goalMiniRoutineWeek(p.current.round(), p.target.round()),
    },
    GoalType.target =>
      '${Fmt.number(p.current)} / ${goalValue(l, g, p.target)}',
  };
}

Color goalHealthColor(GoalHealth health) => switch (health) {
  GoalHealth.onTrack => AppColors.success,
  GoalHealth.completed => AppColors.success,
  GoalHealth.needsAttention => AppColors.warning,
  GoalHealth.paused => AppColors.textMuted,
};

/// Compact goal progress card used in module screens.
class GoalMiniCard extends StatelessWidget {
  const GoalMiniCard({super.key, required this.view, this.overline});

  final GoalView view;
  final String? overline;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final g = view.goal;
    final color = g.area.color;
    return AppCard(
      onTap: () => context.push(AppRoutes.goal(g.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (overline != null) ...[
            Text(overline!.toUpperCase(), style: AppTypography.overline),
            AppSpacing.gap4,
          ],
          Row(
            children: [
              Expanded(
                child: Text(
                  bidiSafe(g.title),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
              ),
              AppSpacing.gap8,
              Text(
                '${view.progress.percent}%',
                style: AppTypography.label.copyWith(color: color).tabular,
              ),
            ],
          ),
          AppSpacing.gap12,
          AppProgressBar(value: view.progress.ratio, color: color),
          AppSpacing.gap8,
          Row(
            children: [
              Expanded(
                child: Text(
                  goalProgressLine(context, view),
                  style: AppTypography.caption.tabular,
                ),
              ),
              if (g.targetDate != null)
                Text(
                  l.goalTargetOn(Fmt.monthDay(g.targetDate!.toLocal())),
                  style: AppTypography.caption,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Active goals of [area], or a prompt to create one.
class AreaGoalsSection extends ConsumerWidget {
  const AreaGoalsSection({super.key, required this.area, this.limit = 3});

  final LifeArea area;
  final int limit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final views =
        (ref.watch(goalViewsProvider).value ?? const <GoalView>[])
            .where(
              (v) => v.goal.area == area && v.goal.status == GoalStatus.active,
            )
            .toList()
          ..sort(
            (a, b) =>
                (b.goal.isPrimary ? 1 : 0).compareTo(a.goal.isPrimary ? 1 : 0),
          );
    if (views.isEmpty) {
      return AppCard(
        onTap: () => context.push(AppRoutes.newGoal),
        child: Row(
          children: [
            IconTile(
              icon: Symbols.flag,
              color: area.color,
              background: area.soft,
            ),
            AppSpacing.gap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.goalAddForArea, style: AppTypography.cardTitle),
                  const SizedBox(height: 2),
                  Text(l.goalAddForAreaBody, style: AppTypography.caption),
                ],
              ),
            ),
            const Icon(Symbols.chevron_right, color: AppColors.textMuted),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, v) in views.take(limit).indexed) ...[
          if (i > 0) AppSpacing.gap12,
          GoalMiniCard(view: v),
        ],
      ],
    );
  }
}
