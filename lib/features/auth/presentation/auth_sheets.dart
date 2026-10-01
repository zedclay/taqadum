import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../data/session_controller.dart';

/// Asks for a display name for a passwordless on-device profile.
Future<String?> showDeviceProfileSheet(BuildContext context) =>
    showAppSheet<String>(context, builder: (_) => const _DeviceProfileSheet());

class _DeviceProfileSheet extends StatefulWidget {
  const _DeviceProfileSheet();

  @override
  State<_DeviceProfileSheet> createState() => _DeviceProfileSheetState();
}

class _DeviceProfileSheetState extends State<_DeviceProfileSheet> {
  final _name = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.authDeviceTitle,
      subtitle: l.authDeviceBody,
      action: PrimaryButton(
        key: const Key('device-profile-start'),
        label: l.authDeviceButton,
        icon: Symbols.arrow_forward,
        onPressed: _name.text.trim().isEmpty ? null : _submit,
      ),
      child: AppTextField(
        fieldKey: const Key('device-profile-name'),
        label: l.authDeviceNameLabel,
        hint: l.authNameHint,
        controller: _name,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}

/// Explains that recovery is local-only and optionally erases the account.
Future<bool?> showResetSheet(BuildContext context, WidgetRef ref) =>
    showAppSheet<bool>(context, builder: (_) => const _ResetSheet());

class _ResetSheet extends ConsumerStatefulWidget {
  const _ResetSheet();

  @override
  ConsumerState<_ResetSheet> createState() => _ResetSheetState();
}

class _ResetSheetState extends ConsumerState<_ResetSheet> {
  final _confirm = TextEditingController();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _confirm.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _erase() async {
    setState(() => _busy = true);
    await ref.read(sessionProvider.notifier).deleteAccount();
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final hasAccount = ref.watch(sessionProvider).hasAccount;
    final confirmed =
        _confirm.text.trim().toUpperCase() == l.authResetKeyword.toUpperCase();
    return AppBottomSheet(
      title: l.authResetTitle,
      subtitle: l.authResetBody,
      action: hasAccount
          ? DestructiveButton(
              label: l.authResetButton,
              icon: Symbols.delete_forever,
              loading: _busy,
              onPressed: confirmed && !_busy ? _erase : null,
            )
          : PrimaryButton(
              label: l.commonDone,
              onPressed: () => Navigator.of(context).pop(),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!hasAccount)
            Text(l.authErrNoAccount, style: AppTypography.body)
          else ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.dangerSoft,
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Symbols.warning,
                    color: AppColors.danger,
                    size: 20,
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: Text(
                      l.authResetWarning,
                      style: AppTypography.body.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gap16,
            AppTextField(
              label: l.authResetConfirmLabel,
              hint: l.authResetKeyword,
              controller: _confirm,
              textCapitalization: TextCapitalization.characters,
            ),
          ],
        ],
      ),
    );
  }
}
