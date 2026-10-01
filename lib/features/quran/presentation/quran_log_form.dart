import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/segmented.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_link_field.dart';
import '../data/quran_repository.dart';
import '../domain/surahs.dart';

String quranKindLabel(BuildContext context, QuranKind kind) {
  final l = context.l10n;
  return switch (kind) {
    QuranKind.reading => l.quranReading,
    QuranKind.memorization => l.quranMemorization,
    QuranKind.revision => l.quranRevision,
  };
}

Future<void> showQuranLogSheet(
  BuildContext context, {
  QuranKind kind = QuranKind.reading,
  double? pages,
  String? surah,
}) => showAppSheet<void>(
  context,
  builder: (_) => QuranLogForm(kind: kind, pages: pages, surah: surah),
);

class QuranLogForm extends ConsumerStatefulWidget {
  const QuranLogForm({
    super.key,
    this.kind = QuranKind.reading,
    this.pages,
    this.surah,
    this.onBack,
    this.onSaved,
  });

  final QuranKind kind;
  final double? pages;
  final String? surah;
  final VoidCallback? onBack;
  final VoidCallback? onSaved;

  @override
  ConsumerState<QuranLogForm> createState() => _QuranLogFormState();
}

class _QuranLogFormState extends ConsumerState<QuranLogForm> {
  late QuranKind _kind = widget.kind;
  late double _pages = widget.pages ?? _defaultPages(widget.kind);
  int _minutes = 15;
  late int? _surah = surahNumberOf(widget.surah);
  final _portion = TextEditingController();
  String? _goalChoice;
  bool _saving = false;

  static double _defaultPages(QuranKind k) => switch (k) {
    QuranKind.reading => 6,
    QuranKind.memorization => 0.25,
    QuranKind.revision => 0,
  };

  @override
  void dispose() {
    _portion.dispose();
    super.dispose();
  }

  bool get _valid => switch (_kind) {
    QuranKind.revision => _minutes > 0,
    _ => _pages > 0,
  };

  Future<void> _pickSurah() async {
    final picked = await showAppSheet<int>(
      context,
      builder: (_) => _SurahPicker(selected: _surah),
    );
    if (picked != null) setState(() => _surah = picked);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final goals = ref.read(goalsProvider).value ?? const <Goal>[];
    final goal = resolveLinkedGoal(
      goals.where((g) => g.status == GoalStatus.active).toList(),
      LifeArea.quran,
      _goalChoice,
    );
    final portion = _portion.text.trim();
    final parts = [
      if (_surah != null) surahLabel(_surah!),
      if (portion.isNotEmpty) portion,
    ];
    await ref
        .read(quranRepositoryProvider)
        .add(
          kind: _kind,
          pages: _kind == QuranKind.revision ? 0 : _pages,
          minutes: _kind == QuranKind.reading ? (_pages * 2).round() : _minutes,
          surah: parts.isEmpty ? null : parts.join(' · '),
          goal: goal,
        );
    if (!mounted) return;
    widget.onSaved?.call();
    if (widget.onSaved == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final saveLabel = switch (_kind) {
      QuranKind.reading => l.quranSaveReading,
      QuranKind.memorization => l.quranSaveMemorization,
      QuranKind.revision => l.quranSaveRevision,
    };
    return AppBottomSheet(
      title: l.quranLogTitle,
      leading: widget.onBack == null
          ? null
          : SheetBackButton(onPressed: widget.onBack!),
      showClose: widget.onBack == null,
      action: PrimaryButton(
        key: const Key('quran-save'),
        label: saveLabel,
        icon: Symbols.check,
        color: AppColors.quran,
        loading: _saving,
        onPressed: !_valid || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedPills<QuranKind>(
            values: QuranKind.values,
            selected: _kind,
            labelOf: (k) => quranKindLabel(context, k),
            onChanged: (k) => setState(() {
              _kind = k;
              _pages = _defaultPages(k);
            }),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.quranSurah, trailing: l.commonOptional),
          AppSpacing.gap8,
          Material(
            color: AppColors.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.inputAll,
              side: BorderSide(color: AppColors.borderStrong),
            ),
            child: InkWell(
              key: const Key('quran-surah'),
              customBorder: const RoundedRectangleBorder(
                borderRadius: AppRadius.inputAll,
              ),
              onTap: _pickSurah,
              child: SizedBox(
                height: AppSpacing.inputHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _surah == null
                              ? l.quranPickSurah
                              : surahLabel(_surah!),
                          style: AppTypography.bodyLarge.copyWith(
                            fontSize: 15,
                            color: _surah == null
                                ? AppColors.textMuted
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const Icon(
                        Symbols.expand_more,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.gap20,
          if (_kind != QuranKind.revision) ...[
            FieldLabel(
              label: _kind == QuranKind.reading
                  ? l.quranPagesRead
                  : l.quranPagesMemorized,
            ),
            AppSpacing.gap8,
            NumberStepper(
              value: _pages,
              step: _kind == QuranKind.reading ? 1 : 0.25,
              min: _kind == QuranKind.reading ? 1 : 0.25,
              max: 604,
              format: QuranRepository.pagesLabel,
              onChanged: (v) => setState(() => _pages = v),
            ),
            if (_kind == QuranKind.reading)
              Center(
                child: Text(
                  l.quranApproxMinutes((_pages * 2).round()),
                  style: AppTypography.caption,
                ),
              ),
          ] else ...[
            FieldLabel(label: l.quranMinutes),
            AppSpacing.gap8,
            NumberStepper(
              value: _minutes.toDouble(),
              step: 5,
              min: 5,
              max: 600,
              onChanged: (v) => setState(() => _minutes = v.round()),
            ),
            AppSpacing.gap16,
            AppTextField(
              label: l.quranPortion,
              trailingLabel: l.commonOptional,
              hint: l.quranPortionHint,
              controller: _portion,
            ),
          ],
          if (_kind == QuranKind.memorization) ...[
            AppSpacing.gap16,
            FieldLabel(label: l.quranMinutes, trailing: l.commonOptional),
            AppSpacing.gap8,
            NumberStepper(
              value: _minutes.toDouble(),
              step: 5,
              min: 5,
              max: 600,
              onChanged: (v) => setState(() => _minutes = v.round()),
            ),
          ],
          AppSpacing.gap20,
          GoalLinkField(
            area: LifeArea.quran,
            choice: _goalChoice,
            onChanged: (c) => setState(() => _goalChoice = c),
          ),
        ],
      ),
    );
  }
}

class _SurahPicker extends StatefulWidget {
  const _SurahPicker({this.selected});

  final int? selected;

  @override
  State<_SurahPicker> createState() => _SurahPickerState();
}

class _SurahPickerState extends State<_SurahPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final q = _query.toLowerCase();
    final matches = [
      for (var i = 1; i <= surahNames.length; i++)
        if (q.isEmpty ||
            surahNames[i - 1].toLowerCase().contains(q) ||
            '$i' == q)
          i,
    ];
    return AppBottomSheet(
      title: l.quranPickSurah,
      scrollable: false,
      child: Column(
        children: [
          AppTextField(
            hint: l.quranSurah,
            prefixIcon: const Icon(Symbols.search, color: AppColors.textMuted),
            onChanged: (v) => setState(() => _query = v.trim()),
            textCapitalization: TextCapitalization.none,
          ),
          AppSpacing.gap8,
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final n = matches[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  leading: SizedBox(
                    width: 32,
                    child: Text('$n', style: AppTypography.caption.tabular),
                  ),
                  title: Text(
                    surahNames[n - 1],
                    style: AppTypography.bodyMedium,
                  ),
                  trailing: n == widget.selected
                      ? const Icon(
                          Symbols.check_circle,
                          color: AppColors.quran,
                          fill: 1,
                        )
                      : null,
                  onTap: () => Navigator.of(context).pop(n),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
