import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'buttons.dart';

Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool useRootNavigator = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: useRootNavigator,
    useSafeArea: true,
    backgroundColor: AppColors.surface,
    barrierColor: AppColors.scrim,
    sheetAnimationStyle: AnimationStyle(
      duration: AppMotion.of(context, AppMotion.sheet),
      reverseDuration: AppMotion.of(context, AppMotion.small),
    ),
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    builder: builder,
  );
}

/// Standard sheet layout: drag handle, title row, scrollable body, sticky CTA.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.action,
    this.leading,
    this.showClose = true,
    this.scrollable = true,
  });

  final String? title;
  final String? subtitle;
  final Widget child;
  final Widget? action;
  final Widget? leading;
  final bool showClose;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.viewInsetsOf(context).bottom;
    final bottomSafe = MediaQuery.paddingOf(context).bottom;
    final body = Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: child,
    );
    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _DragHandle(),
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.lg,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: 4),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title!, style: AppTypography.headline),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(subtitle!, style: AppTypography.body),
                          ],
                        ],
                      ),
                    ),
                    if (showClose)
                      CircleIconButton(
                        icon: Symbols.close,
                        tooltip: context.l10n.commonClose,
                        background: AppColors.surfaceMuted,
                        size: 36,
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                  ],
                ),
              ),
            Flexible(
              child: scrollable ? SingleChildScrollView(child: body) : body,
            ),
            if (action != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  AppSpacing.lg + (insets > 0 ? 0 : bottomSafe),
                ),
                child: action,
              )
            else
              SizedBox(height: insets > 0 ? 0 : bottomSafe),
          ],
        ),
      ),
    );
  }
}

/// Back arrow for sheets that are steps inside another sheet (Quick Add).
class SheetBackButton extends StatelessWidget {
  const SheetBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Symbols.arrow_back,
      tooltip: context.l10n.commonBack,
      background: Colors.transparent,
      size: 36,
      onPressed: onPressed,
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 8),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.borderStrong,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class SheetOption<T> {
  const SheetOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? subtitle;
  final bool enabled;
}

Future<T?> showOptionSheet<T>(
  BuildContext context, {
  required String title,
  required List<SheetOption<T>> options,
  T? selected,
  String? footnote,
}) {
  return showAppSheet<T>(
    context,
    builder: (context) => AppBottomSheet(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final option in options)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              enabled: option.enabled,
              minTileHeight: 52,
              title: Text(option.label, style: AppTypography.bodyMedium),
              subtitle: option.subtitle == null
                  ? null
                  : Text(option.subtitle!, style: AppTypography.caption),
              trailing: option.value == selected
                  ? const Icon(
                      Symbols.check_circle,
                      color: AppColors.primaryStrong,
                      fill: 1,
                    )
                  : null,
              onTap: () => Navigator.of(context).pop(option.value),
            ),
          if (footnote != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(footnote, style: AppTypography.caption),
          ],
        ],
      ),
    ),
  );
}

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message, style: AppTypography.body),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.l10n.commonCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: destructive
                ? AppColors.danger
                : AppColors.primaryStrong,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

class InfoSheet extends StatelessWidget {
  const InfoSheet({super.key, required this.title, required this.paragraphs});

  final String title;
  final List<String> paragraphs;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<String> paragraphs,
  }) => showAppSheet<void>(
    context,
    builder: (_) => InfoSheet(title: title, paragraphs: paragraphs),
  );

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: title,
      action: PrimaryButton(
        label: context.l10n.commonDone,
        onPressed: () => Navigator.of(context).pop(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in paragraphs)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                p,
                style: AppTypography.body.copyWith(color: AppColors.textBody),
              ),
            ),
        ],
      ),
    );
  }
}
