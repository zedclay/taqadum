import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/l10n.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../data/preferences.dart';

Future<void> showLanguageSheet(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final code = await showOptionSheet<String>(
    context,
    title: l.langTitle,
    selected: ref.read(preferencesProvider).localeCode,
    footnote: l.langFootnote,
    options: [
      SheetOption(value: 'en', label: l.langEnglish),
      SheetOption(
        value: 'ar',
        label: l.langArabic,
        subtitle: l.langComingSoon,
        enabled: false,
      ),
      SheetOption(
        value: 'fr',
        label: l.langFrench,
        subtitle: l.langComingSoon,
        enabled: false,
      ),
    ],
  );
  if (code != null) {
    await ref.read(preferencesProvider.notifier).setLocale(code);
  }
}
