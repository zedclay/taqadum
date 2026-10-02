import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/progress.dart';
import '../data/onboarding_service.dart';
import '../domain/onboarding_draft.dart';
import 'onboarding_steps.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  static const steps = 4;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _step = 0;
  OnboardingDraft _draft = const OnboardingDraft();
  bool _busy = false;

  void _update(OnboardingDraft draft) => setState(() => _draft = draft);

  Future<void> _next() async {
    if (_step == 0 && _draft.areas.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.onbAreasError)));
      return;
    }
    if (_step < OnboardingScreen.steps - 1) {
      setState(() => _step++);
      return;
    }
    setState(() => _busy = true);
    try {
      await ref
          .read(onboardingServiceProvider)
          .complete(_draft, starterTargetsFor(context.l10n));
    } catch (_) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.commonSomethingWrong)),
        );
      }
    }
  }

  Future<void> _skip() async {
    setState(() => _busy = true);
    await ref.read(onboardingServiceProvider).skip();
  }

  void _back() {
    if (_step > 0) setState(() => _step--);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final last = _step == OnboardingScreen.steps - 1;
    final body = switch (_step) {
      0 => AreasStep(draft: _draft, onChanged: _update),
      1 => TargetsStep(draft: _draft, onChanged: _update),
      2 => PaceStep(draft: _draft, onChanged: _update),
      _ => ReadyStep(draft: _draft),
    };
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.sm,
                  AppSpacing.sm,
                  AppSpacing.sm,
                  0,
                ),
                child: Row(
                  children: [
                    if (_step > 0)
                      CircleIconButton(
                        icon: Symbols.arrow_back,
                        tooltip: l.commonBack,
                        background: Colors.transparent,
                        onPressed: _back,
                      )
                    else
                      const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        l.onbStep(_step + 1, OnboardingScreen.steps),
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    if (!last)
                      AppTextButton(
                        key: const Key('onboarding-skip'),
                        label: l.commonSkip,
                        onPressed: _busy ? null : _skip,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screen,
                  vertical: AppSpacing.sm,
                ),
                child: AppProgressBar(
                  value: (_step + 1) / OnboardingScreen.steps,
                  color: AppColors.brand,
                  trackColor: AppColors.border,
                  height: 6,
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppMotion.of(context, AppMotion.page),
                  switchInCurve: AppMotion.curve,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0.04, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: KeyedSubtree(key: ValueKey(_step), child: body),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.screen,
                  AppSpacing.sm,
                  AppSpacing.screen,
                  AppSpacing.lg,
                ),
                child: PrimaryButton(
                  key: const Key('onboarding-continue'),
                  label: last ? l.onbFinish : l.commonContinue,
                  icon: Symbols.arrow_forward,
                  color: AppColors.brand,
                  loading: _busy,
                  onPressed: _busy ? null : _next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
