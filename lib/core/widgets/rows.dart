import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';
import '../utilities/bidi.dart';

class CircleCheck extends StatelessWidget {
  const CircleCheck({
    super.key,
    required this.checked,
    this.onTap,
    this.size = 22,
    this.square = false,
    this.color = AppColors.primaryStrong,
    this.semanticLabel,
  });

  final bool checked;
  final VoidCallback? onTap;
  final double size;
  final bool square;
  final Color color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final box = AnimatedContainer(
      duration: AppMotion.of(context, AppMotion.small),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: checked ? color : AppColors.surface,
        shape: square ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: square ? BorderRadius.circular(6) : null,
        border: Border.all(
          color: checked ? color : AppColors.borderStrong,
          width: 1.5,
        ),
      ),
      child: checked
          ? Icon(
              Symbols.check,
              size: size * 0.68,
              color: Colors.white,
              weight: 700,
            )
          : null,
    );
    return Semantics(
      checked: checked,
      label: semanticLabel,
      button: onTap != null,
      child: onTap == null
          ? box
          : InkResponse(
              onTap: onTap,
              radius: 22,
              child: SizedBox.square(
                dimension: AppSpacing.minTouch,
                child: Center(child: box),
              ),
            ),
    );
  }
}

class TaskRow extends StatelessWidget {
  const TaskRow({
    super.key,
    required this.title,
    required this.done,
    required this.onToggle,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    this.highlight = false,
    this.dense = false,
  });

  final String title;
  final bool done;
  final VoidCallback? onToggle;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool highlight;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.md,
      padding: EdgeInsetsDirectional.only(
        start: 4,
        end: AppSpacing.md,
        top: dense ? 2 : 4,
        bottom: dense ? 2 : 4,
      ),
      onTap: onTap ?? onToggle,
      borderColor: highlight ? AppColors.primaryStrong : AppColors.border,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Row(
          children: [
            CircleCheck(checked: done, onTap: onToggle, semanticLabel: title),
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bidiSafe(title),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(
                      color: done ? AppColors.textMuted : AppColors.textPrimary,
                      decoration: done ? TextDecoration.lineThrough : null,
                      decorationColor: AppColors.textMuted,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      bidiSafe(subtitle!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class ActivityRow extends StatelessWidget {
  const ActivityRow({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    required this.title,
    this.subtitle,
    this.trailing,
    this.trailingTop,
    this.trailingTopColor,
    this.onTap,
    this.showChevron = false,
    this.dotColor,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final String title;
  final String? subtitle;
  final String? trailing;
  final String? trailingTop;
  final Color? trailingTopColor;
  final VoidCallback? onTap;
  final bool showChevron;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            IconTile(
              icon: icon,
              color: color,
              background: background,
              size: 40,
              iconSize: 20,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          bidiSafe(title),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (dotColor != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      bidiSafe(subtitle!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption,
                    ),
                  ],
                ],
              ),
            ),
            if (trailingTop != null || trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (trailingTop != null)
                    Text(
                      trailingTop!,
                      style: AppTypography.label.tabular.copyWith(
                        color: trailingTopColor ?? AppColors.textPrimary,
                      ),
                    ),
                  if (trailing != null)
                    Text(trailing!, style: AppTypography.caption.tabular),
                ],
              ),
            ],
            if (showChevron) ...[
              const SizedBox(width: 4),
              const Icon(
                Symbols.chevron_right,
                size: 18,
                color: AppColors.textMuted,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class TransactionRow extends StatelessWidget {
  const TransactionRow({
    super.key,
    required this.icon,
    required this.title,
    required this.meta,
    required this.amount,
    required this.amountColor,
    this.tag,
    this.onTap,
    this.iconColor = AppColors.finance,
    this.iconBackground = AppColors.financeSoft,
  });

  final IconData icon;
  final String title;
  final String meta;
  final String amount;
  final Color amountColor;
  final Widget? tag;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            IconTile(
              icon: icon,
              color: iconColor,
              background: iconBackground,
              size: 40,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bidiSafe(title),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          bidiSafe(meta),
                          style: AppTypography.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (tag != null) ...[const SizedBox(width: 6), tag!],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              amount,
              style: AppTypography.bodyMedium.tabular.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 4,
              end: 4,
              bottom: AppSpacing.sm,
            ),
            child: Text(title!.toUpperCase(), style: AppTypography.overline),
          ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0)
                  const Divider(indent: AppSpacing.lg, endIndent: 0, height: 1),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.onTap,
    this.trailing,
    this.iconColor = AppColors.textBody,
    this.iconBackground = AppColors.surfaceMuted,
    this.titleColor,
    this.showChevron = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color iconColor;
  final Color iconBackground;
  final Color? titleColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              IconTile(
                icon: icon,
                color: iconColor,
                background: iconBackground,
                size: 36,
                iconSize: 20,
                radius: 10,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyMedium.copyWith(
                        color: titleColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption,
                      ),
                    ],
                  ],
                ),
              ),
              if (value != null) ...[
                const SizedBox(width: AppSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: Text(
                    value!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.sm),
                trailing!,
              ] else if (showChevron && onTap != null) ...[
                const SizedBox(width: 4),
                const Icon(
                  Symbols.chevron_right,
                  size: 20,
                  color: AppColors.textMuted,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
