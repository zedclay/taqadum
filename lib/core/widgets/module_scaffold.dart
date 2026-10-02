import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'top_bar.dart';

/// Layout shared by the life-area module screens: compact top bar, large
/// title block, and a scrolling column of sections.
class ModuleScaffold extends StatelessWidget {
  const ModuleScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.actions = const [],
    this.badge,
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;
  final Widget? badge;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(actions: actions),
      body: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screen,
          AppSpacing.xs,
          AppSpacing.screen,
          AppSpacing.huge,
        ),
        children: [
          PageTitle(title: title, subtitle: subtitle, badge: badge),
          AppSpacing.gap20,
          ...children,
        ],
      ),
    );
  }
}

/// Small bordered metric box used in module summary cards.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    this.caption,
    this.captionColor,
    this.valueColor,
    this.color = AppColors.surface,
  });

  final String label;
  final String value;
  final String? caption;
  final Color? captionColor;
  final Color? valueColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.caption, maxLines: 1),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              value,
              maxLines: 1,
              style: AppTypography.cardTitle
                  .copyWith(fontSize: 18, color: valueColor)
                  .tabular,
            ),
          ),
          if (caption != null)
            Text(
              caption!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionSmall.copyWith(
                color: captionColor ?? AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

/// A row of equally sized widgets with fixed gaps.
class EvenRow extends StatelessWidget {
  const EvenRow({super.key, required this.children, this.gap = AppSpacing.sm});

  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, child) in children.indexed) ...[
            if (i > 0) SizedBox(width: gap),
            Expanded(child: child),
          ],
        ],
      ),
    );
  }
}

/// Soft pill button used for module quick actions ("Log workout").
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.primaryStrong,
    this.background = AppColors.surface,
    this.vertical = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color background;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final content = vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              AppSpacing.gap8,
              Text(label, style: AppTypography.label),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              AppSpacing.gap8,
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          );
    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
        ),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouch),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: vertical ? AppSpacing.md : AppSpacing.sm,
            ),
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}

enum DotState { done, missed, today, future }

/// Seven weekday dots showing which days had activity.
class WeekDots extends StatelessWidget {
  const WeekDots({
    super.key,
    required this.labels,
    required this.states,
    this.color = AppColors.primaryStrong,
    this.large = false,
  });

  final List<String> labels;
  final List<DotState> states;
  final Color color;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final size = large ? 28.0 : 12.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < states.length; i++)
          Column(
            children: [
              Text(labels[i], style: AppTypography.captionSmall),
              const SizedBox(height: 6),
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: switch (states[i]) {
                    DotState.done => color,
                    DotState.today => color.withValues(alpha: 0.18),
                    DotState.missed => AppColors.surfaceMuted,
                    DotState.future => Colors.transparent,
                  },
                  border: states[i] == DotState.future
                      ? Border.all(color: AppColors.border)
                      : null,
                ),
                child: large && states[i] == DotState.done
                    ? const Icon(Symbols.check, size: 16, color: Colors.white)
                    : null,
              ),
            ],
          ),
      ],
    );
  }
}
