import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_locale.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../data/preferences.dart';

/// Language choices shown with their native names. French is visible but
/// disabled until its translation is complete.
List<SheetOption<String>> languageOptions(AppLocalizations l) => [
  SheetOption(
    value: AppLanguages.english,
    label: AppLanguages.nativeNames[AppLanguages.english]!,
  ),
  SheetOption(
    value: AppLanguages.arabic,
    label: AppLanguages.nativeNames[AppLanguages.arabic]!,
  ),
  SheetOption(
    value: AppLanguages.french,
    label: AppLanguages.nativeNames[AppLanguages.french]!,
    subtitle: l.langComingSoon,
    enabled: false,
  ),
];

Future<void> showLanguageSheet(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final current = ref.read(preferencesProvider).localeCode;
  final code = await showOptionSheet<String>(
    context,
    title: l.langTitle,
    selected: current,
    footnote: l.langFootnote,
    options: languageOptions(l),
  );
  if (code != null && code != current) {
    await ref.read(preferencesProvider.notifier).setLocale(code);
  }
}
