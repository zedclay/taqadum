import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../auth/data/session_controller.dart';
import '../../auth/domain/validators.dart';
import '../../goals/data/goals_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../data/export_service.dart';
import '../data/preferences.dart';
import '../data/settings_store.dart';
import '../../../core/utilities/bidi.dart';

const appVersion = '1.0.0';

void showSnack(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

Future<void> showPrivacySheet(BuildContext context) {
  final l = context.l10n;
  return InfoSheet.show(
    context,
    title: l.settingsPrivacy,
    paragraphs: [
      l.authPrivacyP1,
      l.authPrivacyP2,
      l.authPrivacyP3,
      l.settingsPrivacyP4,
    ],
  );
}

Future<void> showExportSheet(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final format = await showOptionSheet<ExportFormat>(
    context,
    title: l.settingsExport,
    options: [
      SheetOption(
        value: ExportFormat.json,
        label: l.settingsExportJson,
        subtitle: l.settingsExportJsonBody,
      ),
      SheetOption(
        value: ExportFormat.csv,
        label: l.settingsExportCsv,
        subtitle: l.settingsExportCsvBody,
      ),
    ],
  );
  if (format == null) return;
  try {
    await ref
        .read(exportServiceProvider)
        .share(format, currency: ref.read(preferencesProvider).currency);
  } catch (_) {
    if (context.mounted) showSnack(context, l.settingsExportFailed);
  }
}

Future<void> showLifeAreasSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _LifeAreasSheet());

class _LifeAreasSheet extends ConsumerStatefulWidget {
  const _LifeAreasSheet();

  @override
  ConsumerState<_LifeAreasSheet> createState() => _LifeAreasSheetState();
}

class _LifeAreasSheetState extends ConsumerState<_LifeAreasSheet> {
  late final Set<LifeArea> _areas = ref.read(focusAreasProvider).toSet();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.settingsLifeAreas,
      subtitle: l.settingsLifeAreasBody,
      action: PrimaryButton(
        key: const Key('life-areas-save'),
        label: l.commonSave,
        icon: Symbols.check,
        onPressed: _areas.isEmpty
            ? null
            : () async {
                final navigator = Navigator.of(context);
                await ref.read(settingsStoreProvider).setFocusAreas([
                  for (final a in LifeArea.values)
                    if (_areas.contains(a)) a,
                ]);
                navigator.pop();
              },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final area in LifeArea.values)
                ChoiceTag(
                  label: area.longLabel(context),
                  selected: _areas.contains(area),
                  color: area.color,
                  soft: area.soft,
                  onTap: () => setState(() {
                    if (!_areas.remove(area)) _areas.add(area);
                  }),
                ),
            ],
          ),
          if (_areas.isEmpty) ...[
            AppSpacing.gap12,
            Text(
              l.settingsLifeAreasMin,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> showPrimaryFocusSheet(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final goals = (ref.read(goalsProvider).value ?? const <Goal>[])
      .where((g) => g.status == GoalStatus.active)
      .toList();
  final current = goals.where((g) => g.isPrimary).firstOrNull;
  final id = await showOptionSheet<String>(
    context,
    title: l.settingsPrimaryFocus,
    selected: current?.id,
    options: [
      for (final g in goals)
        SheetOption(
          value: g.id,
          label: bidiSafe(g.title),
          subtitle: g.area.label(context),
        ),
    ],
  );
  if (id != null && id != current?.id) {
    await ref.read(goalsRepositoryProvider).setPrimary(id);
  }
}

Future<void> showEditProfileSheet(BuildContext context, UserProfile profile) =>
    showAppSheet<void>(
      context,
      builder: (_) => _EditProfileSheet(profile: profile),
    );

class _EditProfileSheet extends ConsumerStatefulWidget {
  const _EditProfileSheet({required this.profile});

  final UserProfile profile;

  @override
  ConsumerState<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<_EditProfileSheet> {
  late final _name = TextEditingController(text: widget.profile.name);
  late final _role = TextEditingController(text: widget.profile.role);

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _role.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.profileEdit,
      action: PrimaryButton(
        key: const Key('profile-save'),
        label: l.commonSave,
        icon: Symbols.check,
        onPressed: _name.text.trim().isEmpty
            ? null
            : () async {
                final navigator = Navigator.of(context);
                final role = _role.text.trim();
                await ref
                    .read(profileRepositoryProvider)
                    .update(
                      id: widget.profile.id,
                      name: _name.text.trim(),
                      role: () => role.isEmpty ? null : role,
                    );
                navigator.pop();
              },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('profile-name'),
            label: l.profileName,
            controller: _name,
            textCapitalization: TextCapitalization.words,
          ),
          AppSpacing.gap16,
          AppTextField(
            fieldKey: const Key('profile-role'),
            label: l.profileRole,
            hint: l.profileRoleHint,
            controller: _role,
          ),
        ],
      ),
    );
  }
}

Future<void> showEmailSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _EmailSheet());

class _EmailSheet extends ConsumerStatefulWidget {
  const _EmailSheet();

  @override
  ConsumerState<_EmailSheet> createState() => _EmailSheetState();
}

class _EmailSheetState extends ConsumerState<_EmailSheet> {
  late final _email = TextEditingController(
    text: ref.read(sessionProvider).email,
  );

  @override
  void initState() {
    super.initState();
    _email.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final valid = isValidEmail(_email.text);
    return AppBottomSheet(
      title: l.settingsEmail,
      action: PrimaryButton(
        key: const Key('email-save'),
        label: l.commonSave,
        icon: Symbols.check,
        onPressed: !valid
            ? null
            : () async {
                final navigator = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);
                await ref
                    .read(sessionProvider.notifier)
                    .updateEmail(_email.text);
                navigator.pop();
                messenger.showSnackBar(
                  SnackBar(content: Text(l.settingsEmailSaved)),
                );
              },
      ),
      child: AppTextField(
        fieldKey: const Key('email-field'),
        label: l.authEmail,
        hint: l.authEmailHint,
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        autofocus: true,
      ),
    );
  }
}

Future<void> showPasswordSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _PasswordSheet());

class _PasswordSheet extends ConsumerStatefulWidget {
  const _PasswordSheet();

  @override
  ConsumerState<_PasswordSheet> createState() => _PasswordSheetState();
}

class _PasswordSheetState extends ConsumerState<_PasswordSheet> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  bool _obscure = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _current.addListener(() => setState(() => _error = null));
    _next.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    super.dispose();
  }

  Future<void> _save(bool hasPassword) async {
    final l = context.l10n;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    try {
      await ref
          .read(sessionProvider.notifier)
          .setPassword(
            current: hasPassword ? _current.text : null,
            next: _next.text,
          );
      navigator.pop();
      messenger.showSnackBar(SnackBar(content: Text(l.settingsPasswordSaved)));
    } on AuthException {
      setState(() {
        _saving = false;
        _error = l.authErrWrong;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final session = ref.watch(sessionProvider);
    final hasPassword = session.hasPassword;
    final needsEmail = session.email == null;
    final ok =
        isStrongPassword(_next.text) &&
        (!hasPassword || _current.text.isNotEmpty);
    final toggle = IconButton(
      tooltip: _obscure ? l.authShowPassword : l.authHidePassword,
      icon: Icon(
        _obscure ? Symbols.visibility : Symbols.visibility_off,
        size: 20,
      ),
      onPressed: () => setState(() => _obscure = !_obscure),
    );
    if (needsEmail) {
      return AppBottomSheet(
        title: l.settingsPasswordAddTitle,
        action: PrimaryButton(
          label: l.settingsEmail,
          icon: Symbols.arrow_forward,
          onPressed: () {
            Navigator.of(context).pop();
            showEmailSheet(context);
          },
        ),
        child: Text(l.settingsPasswordNeedsEmail, style: AppTypography.body),
      );
    }
    return AppBottomSheet(
      title: hasPassword ? l.settingsPasswordTitle : l.settingsPasswordAddTitle,
      action: PrimaryButton(
        key: const Key('password-save'),
        label: l.commonSave,
        icon: Symbols.check,
        loading: _saving,
        onPressed: ok && !_saving ? () => _save(hasPassword) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasPassword) ...[
            AppTextField(
              fieldKey: const Key('password-current'),
              label: l.settingsPasswordCurrent,
              controller: _current,
              obscure: _obscure,
              textCapitalization: TextCapitalization.none,
              autofillHints: const [AutofillHints.password],
            ),
            AppSpacing.gap16,
          ],
          AppTextField(
            fieldKey: const Key('password-new'),
            label: l.settingsPasswordNew,
            hint: l.authPasswordHint,
            controller: _next,
            obscure: _obscure,
            suffixIcon: toggle,
            textCapitalization: TextCapitalization.none,
            autofillHints: const [AutofillHints.newPassword],
          ),
          AppSpacing.gap12,
          _Rule(label: l.authRuleLength, ok: passwordHasLength(_next.text)),
          AppSpacing.gap4,
          _Rule(label: l.authRuleMix, ok: passwordHasMix(_next.text)),
          if (_error != null) ...[
            AppSpacing.gap12,
            Text(
              _error!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.label, required this.ok});

  final String label;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          ok ? Symbols.check_circle : Symbols.radio_button_unchecked,
          size: 16,
          fill: ok ? 1 : 0,
          color: ok ? AppColors.success : AppColors.textMuted,
        ),
        AppSpacing.gap8,
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
