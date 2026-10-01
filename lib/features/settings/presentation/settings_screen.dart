import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/demo/demo_data_seeder.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/top_bar.dart';
import '../../auth/data/session_controller.dart';
import '../../goals/data/goals_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../data/preferences.dart';
import '../data/settings_store.dart';
import 'settings_sheets.dart';

const _languages = [('en', 'English'), ('ar', 'العربية'), ('fr', 'Français')];

String _weekdayName(int weekday) =>
    DateFormat.EEEE().format(DateTime(2024, 1, weekday));

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final prefs = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);
    final session = ref.watch(sessionProvider);
    final profile = ref.watch(profileProvider).value;
    final areas = ref.watch(focusAreasProvider);
    final goals = (ref.watch(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    final primary = goals.where((g) => g.isPrimary).firstOrNull;
    final currencyName = supportedCurrencies
        .where((c) => c.$1 == prefs.currency)
        .map((c) => c.$2)
        .firstOrNull;

    Future<void> update(Future<void> Function() change) async {
      await change();
      if (context.mounted) showSnack(context, l.settingsUpdated);
    }

    return Scaffold(
      appBar: AppTopBar(title: l.settingsTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.sm,
          AppSpacing.screen,
          AppSpacing.huge,
        ),
        children: [
          if (profile != null)
            AppCard(
              onTap: () => showEditProfileSheet(context, profile),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.brandSoft,
                    child: Text(
                      initialsOf(profile.name),
                      style: AppTypography.cardTitle.copyWith(
                        color: AppColors.primaryStrong,
                      ),
                    ),
                  ),
                  AppSpacing.gap12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: AppTypography.sectionTitle),
                        Text(
                          session.email ?? l.profileMember,
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Symbols.chevron_right, color: AppColors.textMuted),
                ],
              ),
            ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsPreferences,
            children: [
              SettingsRow(
                key: const Key('settings-language'),
                icon: Symbols.language,
                title: l.settingsLanguage,
                value: _languages
                    .firstWhere(
                      (e) => e.$1 == prefs.localeCode,
                      orElse: () => _languages.first,
                    )
                    .$2,
                onTap: () async {
                  final code = await showOptionSheet<String>(
                    context,
                    title: l.settingsLanguage,
                    selected: prefs.localeCode,
                    options: [
                      for (final (code, name) in _languages)
                        SheetOption(
                          value: code,
                          label: name,
                          subtitle: code == 'en'
                              ? null
                              : l.settingsLanguagePreview,
                        ),
                    ],
                  );
                  if (code != null && code != prefs.localeCode) {
                    await update(() => notifier.setLocale(code));
                  }
                },
              ),
              SettingsRow(
                icon: Symbols.slow_motion_video,
                title: l.settingsReduceMotion,
                subtitle: l.settingsReduceMotionBody,
                showChevron: false,
                trailing: Switch(
                  key: const Key('settings-reduce-motion'),
                  value: prefs.reduceMotion,
                  onChanged: (v) => update(() => notifier.setReduceMotion(v)),
                ),
              ),
            ],
          ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsPlanning,
            children: [
              SettingsRow(
                key: const Key('settings-week-start'),
                icon: Symbols.calendar_today,
                title: l.settingsWeekStart,
                value: _weekdayName(prefs.weekStart),
                onTap: () async {
                  final day = await showOptionSheet<int>(
                    context,
                    title: l.settingsWeekStart,
                    selected: prefs.weekStart,
                    options: [
                      for (final d in const [
                        DateTime.monday,
                        DateTime.saturday,
                        DateTime.sunday,
                      ])
                        SheetOption(value: d, label: _weekdayName(d)),
                    ],
                  );
                  if (day != null && day != prefs.weekStart) {
                    await update(() => notifier.setWeekStart(day));
                  }
                },
              ),
              SettingsRow(
                key: const Key('settings-currency'),
                icon: Symbols.payments,
                title: l.settingsCurrency,
                value: currencyName == null
                    ? prefs.currency
                    : '${prefs.currency} — $currencyName',
                onTap: () async {
                  final code = await showOptionSheet<String>(
                    context,
                    title: l.settingsCurrency,
                    selected: prefs.currency,
                    options: [
                      for (final (code, name) in supportedCurrencies)
                        SheetOption(value: code, label: '$code — $name'),
                    ],
                  );
                  if (code != null && code != prefs.currency) {
                    await update(() => notifier.setCurrency(code));
                  }
                },
              ),
              SettingsRow(
                key: const Key('settings-time-format'),
                icon: Symbols.schedule,
                title: l.settingsTimeFormat,
                value: prefs.use24h ? l.settings24h : l.settings12h,
                onTap: () async {
                  final v = await showOptionSheet<bool>(
                    context,
                    title: l.settingsTimeFormat,
                    selected: prefs.use24h,
                    options: [
                      SheetOption(value: true, label: l.settings24h),
                      SheetOption(value: false, label: l.settings12h),
                    ],
                  );
                  if (v != null && v != prefs.use24h) {
                    await update(() => notifier.setUse24h(v));
                  }
                },
              ),
            ],
          ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsNotifications,
            children: [
              SettingsRow(
                icon: Symbols.notifications_active,
                iconColor: AppColors.primaryStrong,
                iconBackground: AppColors.brandSoft,
                title: l.profileNotifications,
                subtitle: l.settingsNotificationsBody,
                value: prefs.notificationsOn ? l.settingsOn : l.settingsOff,
                onTap: () => context.push(AppRoutes.notifications),
              ),
            ],
          ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsPersonalization,
            children: [
              SettingsRow(
                key: const Key('settings-life-areas'),
                icon: Symbols.grid_view,
                title: l.settingsLifeAreas,
                subtitle: l.settingsLifeAreasBody,
                value: l.settingsLifeAreasCount(areas.length),
                onTap: () => showLifeAreasSheet(context),
              ),
              SettingsRow(
                icon: Symbols.adjust,
                title: l.settingsPrimaryFocus,
                subtitle: l.settingsPrimaryFocusBody,
                value: primary?.title ?? (goals.isEmpty ? null : '—'),
                onTap: goals.isEmpty
                    ? () => context.push(AppRoutes.newGoal)
                    : () => showPrimaryFocusSheet(context, ref),
                trailing: goals.isEmpty
                    ? Text(l.settingsNoGoals, style: AppTypography.caption)
                    : null,
              ),
            ],
          ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsDataPrivacy,
            children: [
              SettingsRow(
                icon: Symbols.history,
                title: l.settingsActivity,
                subtitle: l.settingsActivityBody,
                onTap: () => context.push(AppRoutes.activity),
              ),
              SettingsRow(
                key: const Key('settings-export'),
                icon: Symbols.download,
                title: l.settingsExport,
                subtitle: l.settingsExportBody,
                value: 'JSON / CSV',
                onTap: () => showExportSheet(context, ref),
              ),
              SettingsRow(
                icon: Symbols.verified_user,
                title: l.settingsPrivacy,
                subtitle: l.settingsPrivacyBody,
                onTap: () => showPrivacySheet(context),
              ),
            ],
          ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsAccount,
            children: [
              if (profile != null)
                SettingsRow(
                  icon: Symbols.account_circle,
                  title: l.settingsAccountProfile,
                  value: profile.name,
                  onTap: () => showEditProfileSheet(context, profile),
                ),
              SettingsRow(
                key: const Key('settings-email'),
                icon: Symbols.mail,
                title: l.settingsEmail,
                value: session.email ?? l.settingsEmailNone,
                onTap: () => showEmailSheet(context),
              ),
              SettingsRow(
                key: const Key('settings-password'),
                icon: Symbols.lock,
                title: l.settingsSecurity,
                value: session.hasPassword
                    ? l.settingsPasswordSet
                    : l.settingsPasswordNone,
                onTap: () => showPasswordSheet(context),
              ),
              SettingsRow(
                key: const Key('settings-logout'),
                icon: Symbols.logout,
                title: l.settingsLogout,
                onTap: () async {
                  final ok = await showConfirmDialog(
                    context,
                    title: l.settingsLogoutTitle,
                    message: session.hasPassword
                        ? l.settingsLogoutBody
                        : '${l.settingsLogoutBody}\n\n${l.settingsLogoutNoPassword}',
                    confirmLabel: l.settingsLogout,
                  );
                  if (ok) await ref.read(sessionProvider.notifier).signOut();
                },
              ),
            ],
          ),
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsSupport,
            children: [
              SettingsRow(
                icon: Symbols.help,
                title: l.settingsHelp,
                onTap: () => InfoSheet.show(
                  context,
                  title: l.settingsHelp,
                  paragraphs: [
                    '${l.settingsHelpQ1}\n${l.settingsHelpA1}',
                    '${l.settingsHelpQ2}\n${l.settingsHelpA2}',
                    '${l.settingsHelpQ3}\n${l.settingsHelpA3}',
                    '${l.settingsHelpQ4}\n${l.settingsHelpA4}',
                  ],
                ),
              ),
              SettingsRow(
                icon: Symbols.info,
                title: l.settingsAbout,
                value: 'v$appVersion',
                showChevron: false,
              ),
              SettingsRow(
                icon: Symbols.description,
                title: l.settingsTerms,
                onTap: () => InfoSheet.show(
                  context,
                  title: l.authTermsTitle,
                  paragraphs: [l.authTermsP1, l.authTermsP2, l.authTermsP3],
                ),
              ),
              SettingsRow(
                icon: Symbols.shield,
                title: l.settingsPrivacyPolicy,
                onTap: () => showPrivacySheet(context),
              ),
              SettingsRow(
                icon: Symbols.code,
                title: l.settingsLicenses,
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: l.appName,
                  applicationVersion: appVersion,
                ),
              ),
            ],
          ),
          if (DemoDataSeeder.enabled) ...[
            AppSpacing.gap24,
            SettingsGroup(
              title: l.settingsDeveloper,
              children: [
                SettingsRow(
                  key: const Key('settings-demo'),
                  icon: Symbols.science,
                  title: l.settingsDemo,
                  subtitle: l.settingsDemoBody,
                  onTap: () async {
                    final ok = await showConfirmDialog(
                      context,
                      title: l.settingsDemo,
                      message: l.settingsDemoConfirm,
                      confirmLabel: l.settingsDemo,
                    );
                    if (!ok) return;
                    await ref.read(demoDataSeederProvider).seed();
                    if (context.mounted) showSnack(context, l.settingsDemoDone);
                  },
                ),
              ],
            ),
          ],
          AppSpacing.gap24,
          SettingsGroup(
            title: l.settingsDanger,
            children: [
              SettingsRow(
                key: const Key('settings-delete'),
                icon: Symbols.delete_forever,
                iconColor: AppColors.danger,
                iconBackground: AppColors.dangerSoft,
                title: l.settingsDelete,
                titleColor: AppColors.danger,
                subtitle: l.settingsDeleteBody,
                onTap: () async {
                  final ok = await showConfirmDialog(
                    context,
                    title: l.settingsDeleteTitle,
                    message: l.settingsDeleteConfirm,
                    confirmLabel: l.settingsDeleteButton,
                    destructive: true,
                  );
                  if (ok) {
                    await ref.read(sessionProvider.notifier).deleteAccount();
                  }
                },
              ),
            ],
          ),
          AppSpacing.gap32,
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Symbols.trending_up,
                      size: 16,
                      color: AppColors.primaryStrong,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l.appName.toUpperCase(),
                      style: AppTypography.overline,
                    ),
                  ],
                ),
                AppSpacing.gap4,
                Text(l.settingsFooter, style: AppTypography.captionSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
