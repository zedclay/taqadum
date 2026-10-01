import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Soft full-width "add" row used under editable lists.
class AddRowButton extends StatelessWidget {
  const AddRowButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = Symbols.add_circle,
    this.color = AppColors.primaryStrong,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.brandSoft.withValues(alpha: 0.6),
      borderRadius: AppRadius.cardAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.cardAll,
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              AppSpacing.gap8,
              Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leadingIcon,
    this.loading = false,
    this.height = AppSpacing.buttonHeight,
    this.color = AppColors.primaryStrong,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? leadingIcon;
  final bool loading;
  final double height;
  final Color color;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: Colors.white,
            ),
          )
        : _ButtonContent(
            label: label,
            icon: icon,
            leadingIcon: leadingIcon,
            color: Colors.white,
          );
    final button = FilledButton(
      onPressed: loading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        disabledBackgroundColor: color.withValues(alpha: 0.45),
        disabledForegroundColor: Colors.white,
        minimumSize: Size(expand ? double.infinity : 0, height),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.buttonAll),
        textStyle: AppTypography.button,
        elevation: 0,
      ),
      child: child,
    );
    return Semantics(button: true, label: label, child: button);
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leadingIcon,
    this.height = AppSpacing.buttonHeight,
    this.foreground = AppColors.textPrimary,
    this.background = AppColors.surface,
    this.bordered = true,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? leadingIcon;
  final double height;
  final Color foreground;
  final Color background;
  final bool bordered;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        minimumSize: Size(expand ? double.infinity : 0, height),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        side: bordered
            ? const BorderSide(color: AppColors.border)
            : BorderSide.none,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.buttonAll),
        textStyle: AppTypography.button.copyWith(fontSize: 15),
      ),
      child: _ButtonContent(
        label: label,
        icon: icon,
        leadingIcon: leadingIcon,
        color: foreground,
      ),
    );
  }
}

class DestructiveButton extends StatelessWidget {
  const DestructiveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.soft = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool soft;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (soft) {
      return SecondaryButton(
        label: label,
        onPressed: onPressed,
        leadingIcon: icon,
        foreground: AppColors.danger,
        background: AppColors.dangerSoft,
        bordered: false,
      );
    }
    return PrimaryButton(
      label: label,
      onPressed: onPressed,
      leadingIcon: icon,
      loading: loading,
      color: AppColors.danger,
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.textSecondary,
    this.icon,
    this.style,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final IconData? icon;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        minimumSize: const Size(AppSpacing.minTouch, AppSpacing.minTouch),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        textStyle: style ?? AppTypography.bodyMedium,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      ),
      child: icon == null
          ? Text(label)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
              ],
            ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.background = AppColors.surface,
    this.foreground = AppColors.textPrimary,
    this.size = 40,
    this.iconSize = 20,
    this.badge = false,
    this.bordered = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final Color background;
  final Color foreground;
  final double size;
  final double iconSize;
  final bool badge;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox.square(
        dimension: size < AppSpacing.minTouch ? AppSpacing.minTouch : size,
        child: Center(
          child: Material(
            color: background,
            shape: CircleBorder(
              side: bordered
                  ? const BorderSide(color: AppColors.border)
                  : BorderSide.none,
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: SizedBox.square(
                dimension: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(icon, size: iconSize, color: foreground),
                    if (badge)
                      PositionedDirectional(
                        top: size * 0.24,
                        end: size * 0.26,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.brand,
                            shape: BoxShape.circle,
                            border: Border.all(color: background, width: 1.5),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.color,
    this.icon,
    this.leadingIcon,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 20, color: color),
          const SizedBox(width: AppSpacing.sm),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        if (icon != null) ...[
          const SizedBox(width: AppSpacing.sm),
          Icon(icon, size: 20, color: color),
        ],
      ],
    );
  }
}
