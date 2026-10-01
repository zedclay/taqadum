import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// The single bottom navigation bar: Today · Progress · (+) · Goals · Profile.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onQuickAdd,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onQuickAdd;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final items = [
      (Symbols.home, l.navToday),
      (Symbols.monitoring, l.navProgress),
      (Symbols.adjust, l.navGoals),
      (Symbols.person, l.navProfile),
    ];
    Widget tab(int index) => Expanded(
      child: _NavItem(
        icon: items[index].$1,
        label: items[index].$2,
        selected: currentIndex == index,
        onTap: () => onTabSelected(index),
      ),
    );
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A141B2B),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSpacing.navBarHeight - 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(
              children: [
                tab(0),
                tab(1),
                Expanded(
                  child: Center(child: _QuickAddButton(onTap: onQuickAdd)),
                ),
                tab(2),
                tab(3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.brand : AppColors.textMuted;
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 32,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouch),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: AppMotion.of(context, AppMotion.small),
                child: Icon(
                  icon,
                  key: ValueKey(selected),
                  size: 24,
                  color: color,
                  fill: selected ? 1 : 0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  const _QuickAddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -8),
      child: Semantics(
        button: true,
        label: context.l10n.navQuickAdd,
        excludeSemantics: true,
        child: Container(
          width: AppSpacing.fabSize,
          height: AppSpacing.fabSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.fabShadow,
                blurRadius: 20,
                spreadRadius: -2,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: AppColors.brand,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              key: const Key('quick-add-button'),
              onTap: onTap,
              child: const Icon(Symbols.add, color: Colors.white, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}
