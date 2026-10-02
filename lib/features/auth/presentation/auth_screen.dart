import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/segmented.dart';
import '../../settings/presentation/language_sheet.dart';
import '../data/session_controller.dart';
import '../domain/validators.dart';
import 'auth_sheets.dart';

enum _AuthTab { signIn, create }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, this.createMode = false});

  final bool createMode;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _signInKey = GlobalKey<FormState>();
  final _createKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late _AuthTab _tab;
  bool _remember = true;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final hasAccount = ref.read(sessionProvider).hasAccount;
    _tab = widget.createMode && !hasAccount ? _AuthTab.create : _AuthTab.signIn;
    _email.text = ref.read(sessionProvider).email ?? '';
    _password.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(AuthScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.createMode != oldWidget.createMode && widget.createMode) {
      setState(() => _tab = _AuthTab.create);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _switchTab(_AuthTab tab) => setState(() {
    _tab = tab;
    _error = null;
  });

  String _messageFor(AuthError code) {
    final l = context.l10n;
    return switch (code) {
      AuthError.accountExists => l.authErrExists,
      AuthError.noAccount => l.authErrNoAccount,
      AuthError.wrongCredentials => l.authErrWrong,
      AuthError.passwordRequired => l.authErrPasswordRequired,
      AuthError.nameRequired => l.authErrName,
    };
  }

  Future<void> _run(Future<void> Function() action) async {
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = _messageFor(e.code));
    } catch (_) {
      if (mounted) setState(() => _error = context.l10n.commonSomethingWrong);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signIn() async {
    if (!_signInKey.currentState!.validate()) return;
    await _run(
      () => ref
          .read(sessionProvider.notifier)
          .signIn(
            email: _email.text,
            password: _password.text,
            remember: _remember,
          ),
    );
  }

  Future<void> _create() async {
    if (!_createKey.currentState!.validate()) return;
    await _run(
      () => ref
          .read(sessionProvider.notifier)
          .createAccount(
            name: _name.text,
            email: _email.text,
            password: _password.text,
          ),
    );
  }

  Future<void> _continueOnDevice() async {
    final session = ref.read(sessionProvider);
    if (session.hasAccount && session.hasPassword) {
      setState(() {
        _tab = _AuthTab.signIn;
        _error = context.l10n.authErrPasswordRequired;
      });
      return;
    }
    if (session.hasAccount) {
      await _run(() => ref.read(sessionProvider.notifier).continueOnDevice());
      return;
    }
    final name = await showDeviceProfileSheet(context);
    if (name == null || !mounted) return;
    await _run(
      () => ref.read(sessionProvider.notifier).continueOnDevice(name: name),
    );
  }

  Future<void> _forgot() async {
    final erased = await showResetSheet(context, ref);
    if (erased == true && mounted) {
      _email.clear();
      _password.clear();
      _switchTab(_AuthTab.create);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.authResetDone)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final creating = _tab == _AuthTab.create;
    return Scaffold(
      body: SafeArea(
        child: AutofillGroup(
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.sm,
              AppSpacing.screen,
              AppSpacing.xxl,
            ),
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: _LanguagePill(
                  onTap: () => showLanguageSheet(context, ref),
                ),
              ),
              AppSpacing.gap8,
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  width: 116,
                  semanticLabel: l.appName,
                ),
              ),
              AppSpacing.gap20,
              Text(
                creating ? l.authWelcomeCreate : l.authWelcomeBack,
                textAlign: TextAlign.center,
                style: AppTypography.headline.copyWith(fontSize: 24),
              ),
              AppSpacing.gap8,
              Text(
                creating ? l.authCreateSubtitle : l.authSubtitle,
                textAlign: TextAlign.center,
                style: AppTypography.body,
              ),
              AppSpacing.gap24,
              SegmentedPills<_AuthTab>(
                values: _AuthTab.values,
                selected: _tab,
                height: 48,
                labelOf: (t) =>
                    t == _AuthTab.signIn ? l.authTabSignIn : l.authTabCreate,
                onChanged: _switchTab,
              ),
              AppSpacing.gap24,
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: creating ? _createForm() : _signInForm(),
              ),
              if (_error != null) ...[
                AppSpacing.gap16,
                _ErrorBanner(message: _error!),
              ],
              AppSpacing.gap20,
              PrimaryButton(
                key: Key(creating ? 'create-account-submit' : 'sign-in-submit'),
                label: creating ? l.authTabCreate : l.authTabSignIn,
                icon: creating ? Symbols.person_add : Symbols.arrow_forward,
                loading: _busy,
                onPressed: _busy ? null : (creating ? _create : _signIn),
              ),
              AppSpacing.gap24,
              _OrDivider(label: l.authOrContinue),
              AppSpacing.gap16,
              SecondaryButton(
                key: const Key('continue-on-device'),
                label: l.authContinueDevice,
                leadingIcon: Symbols.smartphone,
                onPressed: _busy ? null : _continueOnDevice,
              ),
              AppSpacing.gap24,
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    creating ? l.authHaveAccount : l.authNoAccount,
                    style: AppTypography.body,
                  ),
                  AppTextButton(
                    label: creating ? l.authSignInLink : l.authCreateLink,
                    color: AppColors.textPrimary,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () => _switchTab(
                      creating ? _AuthTab.signIn : _AuthTab.create,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInForm() {
    final l = context.l10n;
    return Form(
      key: _signInKey,
      child: Column(
        key: const ValueKey('sign-in'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('auth-email'),
            label: l.authEmail,
            hint: l.authEmailHint,
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            autofillHints: const [AutofillHints.email],
            suffixIcon: const Icon(
              Symbols.mail,
              color: AppColors.textSecondary,
            ),
            validator: (v) => isValidEmail(v ?? '') ? null : l.authErrEmail,
          ),
          AppSpacing.gap16,
          AppTextField(
            fieldKey: const Key('auth-password'),
            label: l.authPassword,
            hint: '••••••••',
            controller: _password,
            obscure: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => _signIn(),
            validator: (v) => (v ?? '').isEmpty ? l.authErrPasswordEmpty : null,
          ),
          AppSpacing.gap8,
          Row(
            children: [
              SizedBox(
                width: 32,
                height: AppSpacing.minTouch,
                child: Checkbox(
                  value: _remember,
                  onChanged: (v) => setState(() => _remember = v ?? true),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _remember = !_remember),
                child: Text(l.authRememberMe, style: AppTypography.bodyMedium),
              ),
              const Spacer(),
              AppTextButton(
                label: l.authForgot,
                color: AppColors.primaryStrong,
                onPressed: _forgot,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createForm() {
    final l = context.l10n;
    final password = _password.text;
    return Form(
      key: _createKey,
      child: Column(
        key: const ValueKey('create'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('auth-name'),
            label: l.authFullName,
            hint: l.authNameHint,
            controller: _name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.name],
            validator: (v) => (v ?? '').trim().isEmpty ? l.authErrName : null,
          ),
          AppSpacing.gap16,
          AppTextField(
            fieldKey: const Key('auth-email'),
            label: l.authEmail,
            hint: l.authEmailHint,
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            autofillHints: const [AutofillHints.email],
            suffixIcon: const Icon(
              Symbols.mail,
              color: AppColors.textSecondary,
            ),
            validator: (v) => isValidEmail(v ?? '') ? null : l.authErrEmail,
          ),
          AppSpacing.gap16,
          AppTextField(
            fieldKey: const Key('auth-password'),
            label: l.authCreatePassword,
            hint: l.authPasswordHint,
            controller: _password,
            obscure: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            onSubmitted: (_) => _create(),
            validator: (v) =>
                isStrongPassword(v ?? '') ? null : l.authErrPassword,
          ),
          AppSpacing.gap12,
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.sm,
            children: [
              _Rule(label: l.authRuleLength, met: passwordHasLength(password)),
              _Rule(label: l.authRuleMix, met: passwordHasMix(password)),
            ],
          ),
          AppSpacing.gap16,
          Text.rich(
            TextSpan(
              style: AppTypography.caption,
              children: [
                TextSpan(text: l.authTermsPrefix),
                _link(
                  l.authTerms,
                  () => InfoSheet.show(
                    context,
                    title: l.authTermsTitle,
                    paragraphs: [l.authTermsP1, l.authTermsP2, l.authTermsP3],
                  ),
                ),
                TextSpan(text: l.authAnd),
                _link(
                  l.authPrivacy,
                  () => InfoSheet.show(
                    context,
                    title: l.authPrivacyTitle,
                    paragraphs: [
                      l.authPrivacyP1,
                      l.authPrivacyP2,
                      l.authPrivacyP3,
                    ],
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _link(String text, VoidCallback onTap) => TextSpan(
    text: text,
    style: AppTypography.caption.copyWith(
      color: AppColors.primaryStrong,
      fontWeight: FontWeight.w600,
    ),
    recognizer: TapGestureRecognizer()..onTap = onTap,
  );
}

class _Rule extends StatelessWidget {
  const _Rule({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final color = met ? AppColors.success : AppColors.textMuted;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Symbols.check_circle, size: 16, color: color, fill: met ? 1 : 0),
        const SizedBox(width: 6),
        Text(label, style: AppTypography.caption.copyWith(color: color)),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.dangerSoft,
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Symbols.error, color: AppColors.danger, size: 20),
          AppSpacing.gap8,
          Expanded(
            child: Text(
              message,
              style: AppTypography.body.copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(label.toUpperCase(), style: AppTypography.overline),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _LanguagePill extends StatelessWidget {
  const _LanguagePill({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.langTitle,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.pillAll,
        child: Container(
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouch),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context.isArabic ? 'عربي' : 'EN',
                  style: AppTypography.label.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: context.isArabic ? '  |  EN' : '  |  عربي',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textMuted,
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
