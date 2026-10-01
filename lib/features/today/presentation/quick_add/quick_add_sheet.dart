import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/period.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/providers.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../finance/presentation/transaction_form.dart';
import '../../../health/presentation/habit_form.dart';
import '../../../quran/data/quran_repository.dart';
import '../../../quran/presentation/quran_log_form.dart';
import '../../../settings/data/settings_store.dart';
import '../../../work/data/work_repository.dart';
import '../../../work/presentation/work_log_form.dart';
import '../../data/daily_repository.dart';
import '../widgets/task_form.dart';
import 'note_form.dart';

Future<void> showQuickAddSheet(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);
  final router = GoRouter.of(context);
  final l = context.l10n;
  final result = await showAppSheet<_QuickResult>(
    context,
    builder: (_) => const QuickAddSheet(),
  );
  switch (result) {
    case _Logged(:final message):
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message ?? l.loggedToast)));
    case _Navigate(:final location):
      router.push(location);
    case null:
      break;
  }
}

sealed class _QuickResult {
  const _QuickResult();
}

class _Logged extends _QuickResult {
  const _Logged([this.message]);
  final String? message;
}

class _Navigate extends _QuickResult {
  const _Navigate(this.location);
  final String location;
}

enum QuickKind { task, quran, money, work, habit, note }

class _Draft {
  const _Draft(this.kind, {this.quranPages, this.workKind, this.moneyType});

  final QuickKind kind;
  final double? quranPages;
  final WorkKind? workKind;
  final TransactionType? moneyType;
}

class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key});

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> {
  _Draft? _draft;

  void _open(_Draft draft) => setState(() => _draft = draft);

  void _back() => setState(() => _draft = null);

  void _saved([String? message]) => Navigator.of(context).pop(_Logged(message));

  Widget _form(_Draft draft) {
    final l = context.l10n;
    return switch (draft.kind) {
      QuickKind.task => TaskForm(
        dayKey: ref.read(todayKeyProvider),
        onBack: _back,
        onSaved: _saved,
      ),
      QuickKind.quran => QuranLogForm(
        pages: draft.quranPages,
        onBack: _back,
        onSaved: _saved,
      ),
      QuickKind.money => TransactionForm(
        type: draft.moneyType ?? TransactionType.expense,
        onBack: _back,
        onSaved: _saved,
      ),
      QuickKind.work => WorkLogForm(
        kind: draft.workKind ?? WorkKind.deepWork,
        onBack: _back,
        onSaved: _saved,
      ),
      QuickKind.habit => HabitForm(onBack: _back, onSaved: _saved),
      QuickKind.note => NoteForm(
        onBack: _back,
        onSaved: () => _saved(l.noteSaved),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    return AnimatedSize(
      duration: AppMotion.of(context, AppMotion.page),
      curve: AppMotion.curve,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: AppMotion.of(context, AppMotion.small),
        child: draft == null
            ? _Menu(
                key: const ValueKey('menu'),
                onPick: _open,
                onNavigate: (location) =>
                    Navigator.of(context).pop(_Navigate(location)),
              )
            : KeyedSubtree(key: ValueKey(draft.kind), child: _form(draft)),
      ),
    );
  }
}

class _Suggestion {
  const _Suggestion(this.label, this.color, {this.draft, this.location});

  final String label;
  final Color color;
  final _Draft? draft;
  final String? location;
}

class _Menu extends ConsumerWidget {
  const _Menu({super.key, required this.onPick, required this.onNavigate});

  final ValueChanged<_Draft> onPick;
  final ValueChanged<String> onNavigate;

  List<_Suggestion> _suggestions(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final now = ref.watch(clockProvider)();
    final today = ref.watch(currentDayProvider);
    final dayKey = dayKeyOf(today);
    final range = PeriodRange.day(today);
    final focus = ref.watch(focusAreasProvider);
    final targets = ref.watch(dailyTargetsProvider);
    final checkIn = ref.watch(checkInProvider(dayKey));
    final review = ref.watch(nightReviewProvider(dayKey));
    final quranLogs =
        ref.watch(quranLogsInRangeProvider(range)).value ?? const [];
    final work = ref.watch(workInRangeProvider(range)).value ?? const [];

    final readToday = quranLogs
        .where((q) => q.kind == QuranKind.reading)
        .fold<double>(0, (s, q) => s + q.pages);
    final leadsToday = work.where((w) => w.kind == WorkKind.lead).length;

    return [
      if (now.hour < 12 && checkIn.hasValue && checkIn.value == null)
        _Suggestion(
          l.quickSuggestCheckIn,
          AppColors.brand,
          location: AppRoutes.morningCheckIn,
        ),
      if (now.hour >= 18 && review.hasValue && review.value == null)
        _Suggestion(
          l.quickSuggestNightReview,
          AppColors.brand,
          location: AppRoutes.nightReview,
        ),
      if (focus.contains(LifeArea.quran) && readToday < targets.quranPages)
        _Suggestion(
          l.quickSuggestQuran((targets.quranPages - readToday).ceil()),
          AppColors.quran,
          draft: _Draft(
            QuickKind.quran,
            quranPages: (targets.quranPages - readToday).ceilToDouble(),
          ),
        ),
      if (focus.contains(LifeArea.finance))
        _Suggestion(
          l.quickSuggestExpense,
          AppColors.finance,
          draft: const _Draft(
            QuickKind.money,
            moneyType: TransactionType.expense,
          ),
        ),
      if (focus.contains(LifeArea.work) && leadsToday < targets.leads)
        _Suggestion(
          l.quickSuggestLeads,
          AppColors.work,
          draft: const _Draft(QuickKind.work, workKind: WorkKind.lead),
        ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final suggestions = _suggestions(context, ref);
    final tiles = [
      (
        QuickKind.task,
        l.quickTask,
        l.quickTaskHint,
        Symbols.check_circle,
        AppColors.brand,
        AppColors.brandSoft,
      ),
      (
        QuickKind.quran,
        l.quickQuran,
        l.quickQuranHint,
        Symbols.menu_book,
        AppColors.quran,
        AppColors.quranSoft,
      ),
      (
        QuickKind.money,
        l.quickMoney,
        l.quickMoneyHint,
        Symbols.account_balance_wallet,
        AppColors.finance,
        AppColors.financeSoft,
      ),
      (
        QuickKind.work,
        l.quickWork,
        l.quickWorkHint,
        Symbols.business_center,
        AppColors.work,
        AppColors.workSoft,
      ),
      (
        QuickKind.habit,
        l.quickHabit,
        l.quickHabitHint,
        Symbols.autorenew,
        AppColors.health,
        AppColors.healthSoft,
      ),
      (
        QuickKind.note,
        l.quickNote,
        l.quickNoteHint,
        Symbols.edit_note,
        AppColors.learning,
        AppColors.learningSoft,
      ),
    ];
    return AppBottomSheet(
      title: l.quickAddTitle,
      subtitle: l.quickAddSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var row = 0; row < tiles.length; row += 2) ...[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, t) in tiles.sublist(row, row + 2).indexed) ...[
                    if (i > 0) AppSpacing.gap12,
                    Expanded(
                      child: _QuickTile(
                        key: Key('quick-${t.$1.name}'),
                        title: t.$2,
                        hint: t.$3,
                        icon: t.$4,
                        color: t.$5,
                        soft: t.$6,
                        onTap: () => onPick(_Draft(t.$1)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            AppSpacing.gap12,
          ],
          if (suggestions.isNotEmpty) ...[
            AppSpacing.gap12,
            Text(l.quickSuggested.toUpperCase(), style: AppTypography.overline),
            AppSpacing.gap12,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  for (final (i, s) in suggestions.indexed) ...[
                    if (i > 0) AppSpacing.gap8,
                    _SuggestionPill(
                      suggestion: s,
                      onTap: () {
                        if (s.draft != null) {
                          onPick(s.draft!);
                        } else if (s.location != null) {
                          onNavigate(s.location!);
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.color,
    required this.soft,
    required this.onTap,
  });

  final String title;
  final String hint;
  final IconData icon;
  final Color color;
  final Color soft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceMuted,
      borderRadius: AppRadius.cardAll,
      child: InkWell(
        borderRadius: AppRadius.cardAll,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: soft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              AppSpacing.gap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.cardTitle),
                    const SizedBox(height: 2),
                    Text(hint, style: AppTypography.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionPill extends StatelessWidget {
  const _SuggestionPill({required this.suggestion, required this.onTap});

  final _Suggestion suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceMuted,
      shape: const StadiumBorder(),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: suggestion.color,
                    shape: BoxShape.circle,
                  ),
                ),
                AppSpacing.gap8,
                Text(suggestion.label, style: AppTypography.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
