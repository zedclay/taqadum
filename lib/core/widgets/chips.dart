import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../domain/enums.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'area_style.dart';

class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    this.foreground = AppColors.textSecondary,
    this.background = AppColors.surfaceMuted,
    this.icon,
    this.dot = false,
    this.dense = false,
  });

  final String label;
  final Color foreground;
  final Color background;
  final IconData? icon;
  final bool dot;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 6 : AppSpacing.sm,
        vertical: dense ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.pillAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: foreground,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionSmall.tabular.copyWith(
                color: foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.area,
    this.dot = true,
    this.icon = false,
    this.label,
  });

  final LifeArea area;
  final bool dot;
  final bool icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Pill(
      label: label ?? area.label(context),
      foreground: area.color,
      background: area.soft,
      dot: dot && !icon,
      icon: icon ? area.icon : null,
    );
  }
}

enum StatusTone { neutral, success, warning, danger, info, brand }

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    this.tone = StatusTone.neutral,
    this.icon,
    this.dot = false,
  });

  final String label;
  final StatusTone tone;
  final IconData? icon;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = switch (tone) {
      StatusTone.neutral => (AppColors.textSecondary, AppColors.surfaceMuted),
      StatusTone.success => (AppColors.success, AppColors.successSoft),
      StatusTone.warning => (AppColors.warning, AppColors.warningSoft),
      StatusTone.danger => (AppColors.danger, AppColors.dangerSoft),
      StatusTone.info => (AppColors.info, AppColors.infoSoft),
      StatusTone.brand => (AppColors.primaryStrong, AppColors.brandSoft),
    };
    return Pill(
      label: label,
      foreground: fg,
      background: bg,
      icon: icon,
      dot: dot,
    );
  }
}

/// Selectable reflection tag (Night / Weekly / Monthly review).
class ChoiceTag extends StatelessWidget {
  const ChoiceTag({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.color = AppColors.primaryStrong,
    this.soft = AppColors.brandSoft,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  final Color soft;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? soft : AppColors.surfaceMuted,
        shape: StadiumBorder(
          side: BorderSide(color: selected ? color : Colors.transparent),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: AnimatedPadding(
            duration: AppMotion.of(context, AppMotion.small),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTypography.caption.copyWith(
                    color: selected ? color : AppColors.textBody,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (selected) ...[
                  const SizedBox(width: 4),
                  Icon(Symbols.check, size: 14, color: color, weight: 600),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal filter chip used in Activity History / Finance lists.
class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.dotColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.white : AppColors.textBody;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? AppColors.primaryStrong : AppColors.surface,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? AppColors.primaryStrong : AppColors.border,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 34),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (dotColor != null) ...[
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: AppTypography.bodyMedium.copyWith(
                    color: fg,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
