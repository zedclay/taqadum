import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/area_style.dart';
import '../../data/goals_repository.dart';
import '../../domain/goal_progress.dart';
import '../../../../core/utilities/bidi.dart';

/// Resolves the goal a log should count toward: the explicit choice, or the
/// default active goal for [area]. An empty string means "no goal".
Goal? resolveLinkedGoal(List<Goal> goals, LifeArea area, String? choice) {
  if (choice == '') return null;
  if (choice != null) return goals.where((g) => g.id == choice).firstOrNull;
  return GoalContribution.defaultGoal(goals, area);
}

class GoalLinkField extends ConsumerWidget {
  const GoalLinkField({
    super.key,
    required this.area,
    required this.choice,
    required this.onChanged,
  });

  final LifeArea area;

  /// null = automatic default, '' = none, otherwise a goal id.
  final String? choice;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final goals = (ref.watch(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    if (goals.isEmpty) return const SizedBox.shrink();
    final linked = resolveLinkedGoal(goals, area, choice);
    return Material(
      color: AppColors.surfaceMuted,
      borderRadius: AppRadius.cardAll,
      child: InkWell(
        key: const Key('goal-link-field'),
        borderRadius: AppRadius.cardAll,
        onTap: () async {
          final sorted = [...goals]
            ..sort(
              (a, b) =>
                  (b.area == area ? 1 : 0).compareTo(a.area == area ? 1 : 0),
            );
          final picked = await showOptionSheet<String>(
            context,
            title: l.commonLinkedGoal,
            selected: linked?.id ?? '',
            options: [
              SheetOption(value: '', label: l.commonNoLinkedGoal),
              for (final g in sorted)
                SheetOption(
                  value: g.id,
                  label: bidiSafe(g.title),
                  subtitle: g.area.label(context),
                ),
            ],
          );
          if (picked != null) onChanged(picked);
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 12, 10),
          child: Row(
            children: [
              Icon(
                Symbols.track_changes,
                size: 20,
                color: linked == null ? AppColors.textMuted : area.color,
              ),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.commonLinkedGoal, style: AppTypography.caption),
                    Text(
                      linked == null
                          ? l.commonNoLinkedGoal
                          : bidiSafe(linked.title),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Symbols.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
