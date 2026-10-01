import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../auth/data/session_controller.dart';
import '../../auth/domain/launch_decider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const holdDuration = Duration(milliseconds: 1400);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final reduce = MediaQuery.disableAnimationsOf(context);
      if (reduce) {
        _controller.value = 1;
      } else {
        _controller.forward();
      }
      _timer = Timer(
        reduce ? const Duration(milliseconds: 500) : SplashScreen.holdDuration,
        _continue,
      );
    });
  }

  void _continue() {
    if (!mounted) return;
    context.go(routeFor(decideLaunch(ref.read(sessionProvider))));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    final scale = Tween(
      begin: 0.94,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: _Glow()),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 5),
                FadeTransition(
                  opacity: fade,
                  child: ScaleTransition(
                    scale: scale,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.logo,
                          width: 168,
                          semanticLabel: l.appName,
                        ),
                        AppSpacing.gap16,
                        Text(
                          l.splashTagline,
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 6),
                FadeTransition(
                  opacity: fade,
                  child: Text(
                    l.splashFooter,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                AppSpacing.gap24,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.6,
          colors: [Color(0x14F85D27), Color(0x06F85D27), Color(0x00F85D27)],
          stops: [0, 0.5, 1],
        ),
      ),
    );
  }
}
