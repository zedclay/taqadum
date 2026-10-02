import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// The single bottom navigation bar: Today · Progress · (+) · Goals · Profile.
///
/// The row follows the ambient [Directionality], so RTL mirrors the order.
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

  /// How far the Quick Add circle overhangs the top edge of the bar.
  static const fabRise = 10.0;

  /// Width of the Quick Add slot between the four destinations.
  static const quickAddSlot = 60.0;

  /// Labels stop growing past this text scale, like platform tab bars.
  static const maxLabelScale = 1.2;

  static const _pressedScale = 0.97;
  static const _pressDuration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final items = [
      (Symbols.home, l.navToday),
      (Symbols.monitoring, l.navProgress),
      (Symbols.adjust, l.navGoals),
      (Symbols.person, l.navProfile),
    ];
    return _RisingStack(
      rise: fabRise,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.border.withValues(alpha: 0.8)),
            ),
          ),
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: SizedBox(
              height: AppSpacing.navBarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final slot =
                        (constraints.maxWidth - quickAddSlot) / items.length;
                    final scaler = _labelScaler(context, [
                      for (final item in items) item.$2,
                    ], slot - AppSpacing.xs);
                    Widget tab(int index) => Expanded(
                      child: _NavItem(
                        icon: items[index].$1,
                        label: items[index].$2,
                        selected: currentIndex == index,
                        textScaler: scaler,
                        onTap: () => onTabSelected(index),
                      ),
                    );
                    return Row(
                      children: [
                        tab(0),
                        tab(1),
                        const SizedBox(width: quickAddSlot),
                        tab(2),
                        tab(3),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -fabRise,
          left: 0,
          right: 0,
          child: Center(child: _QuickAddButton(onTap: onQuickAdd)),
        ),
      ],
    );
  }
}

TextStyle _labelStyle({required bool selected}) => AppTypography.caption
    .copyWith(fontWeight: selected ? FontWeight.w600 : FontWeight.w500);

/// One text scale for all four labels: the system scale capped at
/// [AppBottomNavigation.maxLabelScale], reduced just enough for the widest
/// label to fit [maxWidth] on one line.
TextScaler _labelScaler(
  BuildContext context,
  List<String> labels,
  double maxWidth,
) {
  final scaler = MediaQuery.textScalerOf(context)
      .clamp(maxScaleFactor: AppBottomNavigation.maxLabelScale);
  final style = _labelStyle(selected: true);
  var widest = 0.0;
  for (final label in labels) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: style),
      textDirection: Directionality.of(context),
      textScaler: scaler,
      maxLines: 1,
    )..layout();
    widest = math.max(widest, painter.width);
    painter.dispose();
  }
  if (maxWidth <= 0 || widest <= maxWidth) return scaler;
  final fontSize = style.fontSize!;
  return TextScaler.linear(
    scaler.scale(fontSize) / fontSize * maxWidth / widest,
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.textScaler,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final TextScaler textScaler;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        highlightColor: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: selected ? 1 : 0),
          duration: AppMotion.of(context, AppMotion.small),
          curve: AppMotion.curve,
          builder: (context, t, _) {
            final color = Color.lerp(
              AppColors.textSecondary,
              AppColors.brand,
              t,
            )!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24, fill: t, color: color),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textScaler: textScaler,
                  style: _labelStyle(selected: selected).copyWith(color: color),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _QuickAddButton extends StatefulWidget {
  const _QuickAddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_QuickAddButton> createState() => _QuickAddButtonState();
}

class _QuickAddButtonState extends State<_QuickAddButton> {
  var _pressed = false;

  void _setPressed(bool pressed) {
    if (_pressed != pressed) setState(() => _pressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.navQuickAdd,
      onTap: widget.onTap,
      excludeSemantics: true,
      child: GestureDetector(
        key: const Key('quick-add-button'),
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: SizedBox(
          width: AppBottomNavigation.quickAddSlot,
          height: AppSpacing.navBarHeight + AppBottomNavigation.fabRise,
          child: Align(
            alignment: Alignment.topCenter,
            child: AnimatedScale(
              scale: _pressed ? AppBottomNavigation._pressedScale : 1,
              duration: AppMotion.of(
                context,
                AppBottomNavigation._pressDuration,
              ),
              curve: AppMotion.curve,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.brand,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.fabShadow,
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox.square(
                  dimension: AppSpacing.fabSize,
                  child: Icon(Symbols.add, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A [Stack] that also accepts hits up to [rise] above its top edge, where the
/// Quick Add circle overhangs the bar. Hits there only land on children.
class _RisingStack extends Stack {
  const _RisingStack({required this.rise, super.children})
    : super(clipBehavior: Clip.none);

  final double rise;

  @override
  RenderStack createRenderObject(BuildContext context) => _RenderRisingStack(
    rise: rise,
    textDirection: Directionality.maybeOf(context),
  );

  @override
  void updateRenderObject(BuildContext context, RenderStack renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _RenderRisingStack).rise = rise;
  }
}

class _RenderRisingStack extends RenderStack {
  _RenderRisingStack({required this.rise, super.textDirection})
    : super(clipBehavior: Clip.none);

  double rise;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final area = Rect.fromLTRB(0, -rise, size.width, size.height);
    if (!area.contains(position) ||
        !hitTestChildren(result, position: position)) {
      return false;
    }
    result.add(BoxHitTestEntry(this, position));
    return true;
  }
}
