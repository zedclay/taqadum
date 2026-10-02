import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'buttons.dart';

/// Compact header used by sub-screens and focused flows.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.title,
    this.subtitle,
    this.actions = const [],
    this.showBack = true,
    this.onBack,
    this.centerTitle = false,
    this.closeIcon = false,
  });

  final String? title;
  final String? subtitle;
  final List<Widget> actions;
  final bool showBack;
  final VoidCallback? onBack;
  final bool centerTitle;
  final bool closeIcon;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final titleWidget = title == null
        ? const SizedBox.shrink()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: centerTitle
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sectionTitle,
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption,
                ),
            ],
          );
    return Material(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                if (showBack)
                  CircleIconButton(
                    icon: closeIcon ? Symbols.close : Symbols.arrow_back,
                    tooltip: closeIcon
                        ? context.l10n.commonClose
                        : context.l10n.commonBack,
                    background: Colors.transparent,
                    iconSize: 22,
                    onPressed: onBack ?? () => _pop(context),
                  )
                else
                  const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: centerTitle
                      ? Center(child: titleWidget)
                      : Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: titleWidget,
                          ),
                        ),
                ),
                ...actions,
                if (centerTitle && actions.isEmpty && showBack)
                  const SizedBox(width: AppSpacing.minTouch),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/today');
    }
  }
}

/// Large page title block used at the top of main and module screens.
class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.badge,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSpacing.sm,
                runSpacing: 4,
                children: [
                  Text(title, style: AppTypography.pageTitle),
                  ?badge,
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: AppTypography.body),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
