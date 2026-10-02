import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/area_style.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/input_sheets.dart';
import '../../../core/widgets/progress.dart';
import '../../../core/widgets/rows.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/states.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_mini_card.dart';
import '../../goals/presentation/widgets/goal_widgets.dart';
import '../../progress/data/progress_providers.dart';
import '../../settings/data/preferences.dart';
import '../../settings/data/settings_store.dart';
import '../../settings/presentation/settings_sheets.dart';
import '../data/profile_repository.dart';
import '../../../core/utilities/bidi.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final profile = ref.watch(profileProvider);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: AsyncView<UserProfile?>(
          value: profile,
          builder: (p) => ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.huge,
            ),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(l.profileTitle, style: AppTypography.pageTitle),
                  ),
                  CircleIconButton(
                    key: const Key('profile-settings'),
                    icon: Symbols.settings,
                    tooltip: l.profileSettings,
                    onPressed: () => context.push(AppRoutes.settings),
                  ),
                ],
              ),
              AppSpacing.gap16,
              if (p != null) _ProfileCard(profile: p),
              AppSpacing.gap28,
              const _CurrentFocus(),
              AppSpacing.gap28,
              const _YearProgress(),
              AppSpacing.gap28,
              const _LifeAreas(),
              if (p != null) ...[AppSpacing.gap28, _Intention(profile: p)],
              AppSpacing.gap28,
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 4,
                  bottom: AppSpacing.sm,
                ),
                child: OverlineLabel(l.profileYourTaqaddum),
              ),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SettingsRow(
                      icon: Symbols.history,
                      title: l.profileActivity,
                      subtitle: l.profileActivityBody,
                      onTap: () => context.push(AppRoutes.activity),
                    ),
                    const Divider(height: 1, indent: AppSpacing.lg),
                    SettingsRow(
                      icon: Symbols.event_available,
                      title: l.profileWeekly,
                      subtitle: l.profileWeeklyBody,
                      onTap: () => context.push(AppRoutes.weeklyReview),
                    ),
                    const Divider(height: 1, indent: AppSpacing.lg),
                    SettingsRow(
                      icon: Symbols.calendar_view_month,
                      title: l.profileMonthly,
                      subtitle: l.profileMonthlyBody,
                      onTap: () => context.push(AppRoutes.monthlyReview),
                    ),
                    const Divider(height: 1, indent: AppSpacing.lg),
                    SettingsRow(
                      icon: Symbols.notifications_active,
                      title: l.profileNotifications,
                      subtitle: l.profileNotificationsBody,
                      onTap: () => context.push(AppRoutes.notifications),
                    ),
                    const Divider(height: 1, indent: AppSpacing.lg),
                    SettingsRow(
                      icon: Symbols.settings,
                      title: l.profileSettings,
                      subtitle: l.profileSettingsBody,
                      onTap: () => context.push(AppRoutes.settings),
                    ),
                  ],
                ),
              ),
              AppSpacing.gap16,
              Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      key: const Key('profile-export'),
                      label: l.profileExport,
                      icon: Symbols.sync_alt,
                      onPressed: () => showExportSheet(context, ref),
                    ),
                  ),
                  Expanded(
                    child: AppTextButton(
                      label: l.profileBackup,
                      icon: Symbols.lock,
                      color: AppColors.textSecondary,
                      onPressed: () => showPrivacySheet(context),
                    ),
                  ),
                ],
              ),
              AppSpacing.gap16,
              if (p != null)
                Center(
                  child: Text(
                    l.profileFooter(
                      appVersion,
                      Fmt.monthYear(p.createdAt.toLocal()),
                    ),
                    style: AppTypography.captionSmall,
                  ),
                ),
              AppSpacing.gap4,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Symbols.shield,
                    size: 14,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(l.profilePrivate, style: AppTypography.captionSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: AppColors.brandSoft,
            child: Text(
              initialsOf(profile.name),
              style: AppTypography.headline.copyWith(
                color: AppColors.primaryStrong,
              ),
            ),
          ),
          AppSpacing.gap16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bidiSafe(profile.name),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.headline,
                ),
                if (profile.role != null)
                  Text(profile.role!, style: AppTypography.bodyMedium),
                const SizedBox(height: 2),
                Text(l.profileMember, style: AppTypography.captionSmall),
              ],
            ),
          ),
          CircleIconButton(
            key: const Key('profile-edit'),
            icon: Symbols.edit,
            tooltip: l.profileEdit,
            background: AppColors.surfaceMuted,
            size: 40,
            iconSize: 18,
            onPressed: () => showEditProfileSheet(context, profile),
          ),
        ],
      ),
    );
  }
}

class _CurrentFocus extends ConsumerWidget {
  const _CurrentFocus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final now = ref.watch(clockProvider)();
    final weekStart = ref.watch(preferencesProvider.select((p) => p.weekStart));
    final views = ref.watch(goalViewsProvider).value ?? const <GoalView>[];
    final actions = ref.watch(goalActionsProvider).value ?? const [];
    final primary = views
        .where((v) => v.goal.isPrimary && v.goal.status == GoalStatus.active)
        .firstOrNull;
    final header = Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 4,
        bottom: AppSpacing.sm,
      ),
      child: OverlineLabel(l.profileCurrentFocus),
    );
    if (primary == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          EmptyState(
            icon: Symbols.adjust,
            title: l.profileNoFocus,
            message: l.profileNoFocusBody,
            actionLabel: l.profileChooseFocus,
            onAction: () => context.go(AppRoutes.goals),
          ),
        ],
      );
    }
    final g = primary.goal;
    final p = primary.progress;
    final next = nextActionOf(
      actions.where((a) => a.goalId == g.id).toList(),
      now,
      weekStart: weekStart,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        AppCard(
          color: AppColors.brandSoft,
          borderColor: AppColors.brandSoft,
          onTap: () => context.push(AppRoutes.goal(g.id)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Pill(
                    label: l.profilePrimaryFocus,
                    dot: true,
                    foreground: AppColors.primaryStrong,
                    background: AppColors.surface,
                    dense: true,
                  ),
                  const Spacer(),
                  Text(
                    '${p.percent}%',
                    style: AppTypography.sectionTitle.copyWith(
                      color: AppColors.primaryStrong,
                    ),
                  ),
                ],
              ),
              AppSpacing.gap12,
              Text(bidiSafe(g.title), style: AppTypography.headline),
              if (g.description != null) ...[
                const SizedBox(height: 2),
                Text(g.description!, style: AppTypography.caption),
              ],
              AppSpacing.gap12,
              AppProgressBar(value: p.ratio, trackColor: AppColors.surface),
              AppSpacing.gap8,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      g.type == GoalType.target
                          ? l.profileTarget(goalValue(l, g, g.targetValue))
                          : goalProgressLine(context, primary),
                      style: AppTypography.captionSmall,
                    ),
                  ),
                  Text(
                    l.profileInitiated(Fmt.monthYear(g.createdAt.toLocal())),
                    style: AppTypography.captionSmall,
                  ),
                ],
              ),
              if (next != null) ...[
                AppSpacing.gap12,
                Material(
                  color: AppColors.surface,
                  borderRadius: AppRadius.mdAll,
                  child: InkWell(
                    borderRadius: AppRadius.mdAll,
                    onTap: () => context.push(AppRoutes.goal(g.id)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(
                            Symbols.radio_button_checked,
                            size: 18,
                            color: AppColors.primaryStrong,
                          ),
                          AppSpacing.gap8,
                          Expanded(
                            child: Text(
                              l.profileNext(bidiSafe(next.title)),
                              style: AppTypography.label,
                            ),
                          ),
                          const Icon(
                            Symbols.chevron_right,
                            size: 18,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _YearProgress extends ConsumerWidget {
  const _YearProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final today = ref.watch(currentDayProvider);
    final year = ref
        .watch(periodSummaryProvider(PeriodRange.year(today)))
        .value;
    final month = ref
        .watch(periodSummaryProvider(PeriodRange.month(today)))
        .value;
    final goals = (ref.watch(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.createdAt.toLocal().year == today.year)
        .where((g) => g.status != GoalStatus.archived)
        .toList();
    final active = goals.where((g) => g.status == GoalStatus.active).length;
    final done = goals.where((g) => g.status == GoalStatus.completed).length;
    final overall = year?.overall ?? 0;
    final (status, tone) = overall >= 0.6
        ? (l.profileOnSchedule, StatusTone.success)
        : overall >= 0.35
        ? (l.profileSteady, StatusTone.warning)
        : (l.profileBuilding, StatusTone.neutral);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 4,
            bottom: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: OverlineLabel(l.profileYearProgress('${today.year}')),
              ),
              Text(l.profileAnnual, style: AppTypography.captionSmall),
            ],
          ),
        ),
        AppCard(
          onTap: () => context.go(AppRoutes.progress),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Fmt.percent(overall),
                          style: AppTypography.display,
                        ),
                        Text(l.profileAlignment, style: AppTypography.caption),
                      ],
                    ),
                  ),
                  StatusChip(label: status, tone: tone),
                ],
              ),
              AppSpacing.gap12,
              AppProgressBar(value: overall),
              AppSpacing.gap16,
              Row(
                children: [
                  Expanded(
                    child: _MiniStat(
                      icon: Symbols.calendar_month,
                      label: l.profileActiveConsistency,
                      value:
                          '${month?.activeDays ?? 0} / ${month?.elapsedDays ?? 0}',
                      caption: l.profileActiveThisMonth,
                    ),
                  ),
                  AppSpacing.gap8,
                  Expanded(
                    child: _MiniStat(
                      icon: Symbols.flag,
                      label: l.profileYearGoals,
                      value: l.profileGoalsSummary(active, done),
                      caption: l.profileGoalsTotal(goals.length),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.caption,
  });

  final IconData icon;
  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.captionSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(value, style: AppTypography.label.tabular),
          Text(caption, style: AppTypography.captionSmall),
        ],
      ),
    );
  }
}

class _LifeAreas extends ConsumerWidget {
  const _LifeAreas();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final focus = ref.watch(focusAreasProvider).toSet();
    const areas = LifeArea.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l.profileLifeAreas,
          subtitle: l.profileLifeAreasSub(focus.length),
          trailingText: l.profileEditAreas,
          onTrailingTap: () => showLifeAreasSheet(context),
        ),
        for (var i = 0; i < areas.length; i += 2) ...[
          if (i > 0) AppSpacing.gap8,
          Row(
            children: [
              for (final (j, area) in areas.skip(i).take(2).indexed) ...[
                if (j > 0) AppSpacing.gap8,
                Expanded(
                  child: _AreaTile(area: area, active: focus.contains(area)),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _AreaTile extends StatelessWidget {
  const _AreaTile({required this.area, required this.active});

  final LifeArea area;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final route = area.route;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      onTap: route == null ? null : () => context.push(route),
      child: Opacity(
        opacity: active ? 1 : 0.5,
        child: Row(
          children: [
            IconTile(
              icon: area.icon,
              color: area.color,
              background: area.soft,
              size: 32,
              iconSize: 16,
            ),
            AppSpacing.gap8,
            Expanded(
              child: Text(
                area.label(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label,
              ),
            ),
            Text(
              active ? l.profileAreaActive : l.profileAreaOff,
              style: AppTypography.captionSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Intention extends ConsumerWidget {
  const _Intention({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final year = ref.watch(currentDayProvider).year;
    final intention = profile.intention;

    Future<void> edit() async {
      final text = await showTextSheet(
        context,
        title: l.profileIntention('$year'),
        hint: l.profileIntentionHint,
        initial: intention,
      );
      if (text == null) return;
      final clean = text.trim();
      await ref
          .read(profileRepositoryProvider)
          .update(
            id: profile.id,
            intention: () => clean.isEmpty ? null : clean,
          );
    }

    if (intention == null) {
      return AddRowButton(
        key: const Key('profile-add-intention'),
        label: l.profileAddIntention,
        icon: Symbols.format_quote,
        onTap: edit,
      );
    }
    return AppCard(
      color: AppColors.infoSoft,
      borderColor: AppColors.infoSoft,
      onTap: edit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.format_quote,
                size: 18,
                color: AppColors.primaryStrong,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: OverlineLabel(
                  l.profileIntention('$year'),
                  color: AppColors.primaryStrong,
                ),
              ),
              Icon(
                Symbols.edit,
                size: 16,
                color: AppColors.textMuted,
                semanticLabel: l.profileEditIntention,
              ),
            ],
          ),
          AppSpacing.gap12,
          Text(
            '“$intention”',
            style: AppTypography.cardTitle.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
