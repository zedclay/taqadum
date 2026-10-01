import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';
import 'buttons.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Symbols.inbox,
    this.actionLabel,
    this.onAction,
    this.card = true,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool card;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTile(
            icon: icon,
            color: AppColors.textSecondary,
            background: AppColors.surfaceMuted,
            size: 44,
            iconSize: 22,
            radius: 22,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: AppTypography.cardTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(message, style: AppTypography.body, textAlign: TextAlign.center),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.md),
            AppTextButton(
              label: actionLabel!,
              onPressed: onAction,
              color: AppColors.primaryStrong,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
    if (!card) return content;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: SizedBox(width: double.infinity, child: content),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return EmptyState(
      icon: Symbols.error,
      title: l.commonSomethingWrong,
      message: l.commonSomethingWrongBody,
      actionLabel: onRetry == null ? null : l.commonRetry,
      onAction: onRetry,
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.height = 160});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}

/// Renders loading / error / data for an [AsyncValue].
class AsyncView<T> extends StatelessWidget {
  const AsyncView({
    super.key,
    required this.value,
    required this.builder,
    this.loadingHeight = 160,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) builder;
  final double loadingHeight;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncData(:final value) => builder(value),
      AsyncError(:final error) => _logged(error, ErrorState(onRetry: onRetry)),
      _ =>
        value.hasValue
            ? builder(value.requireValue)
            : LoadingState(height: loadingHeight),
    };
  }

  Widget _logged(Object error, Widget child) {
    debugPrint('AsyncView error: $error');
    return child;
  }
}
