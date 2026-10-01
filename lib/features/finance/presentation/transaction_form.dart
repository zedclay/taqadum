import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/number_input.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/input_sheets.dart';
import '../../../core/widgets/pickers.dart';
import '../../../core/widgets/segmented.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_link_field.dart';
import '../../settings/data/preferences.dart';
import '../data/finance_repository.dart';

String transactionTypeLabel(BuildContext context, TransactionType t) {
  final l = context.l10n;
  return switch (t) {
    TransactionType.expense => l.moneyExpense,
    TransactionType.income => l.moneyIncome,
    TransactionType.saving => l.moneySaving,
  };
}

List<String> categoriesFor(BuildContext context, TransactionType type) {
  final l = context.l10n;
  return switch (type) {
    TransactionType.expense => [
      l.catFood,
      l.catTransport,
      l.catHome,
      l.catBills,
      l.catFamily,
      l.catHealth,
      l.catEducation,
      l.catBusiness,
      l.catShopping,
    ],
    TransactionType.income => [
      l.catSalary,
      l.catClientPayment,
      l.catBusiness,
      l.catFreelance,
      l.catGift,
    ],
    TransactionType.saving => [
      l.catEmergency,
      l.catSavingsGoal,
      l.catInvestment,
    ],
  };
}

Future<void> showTransactionSheet(
  BuildContext context, {
  TransactionType type = TransactionType.expense,
}) => showAppSheet<void>(context, builder: (_) => TransactionForm(type: type));

class TransactionForm extends ConsumerStatefulWidget {
  const TransactionForm({
    super.key,
    this.type = TransactionType.expense,
    this.onBack,
    this.onSaved,
  });

  final TransactionType type;
  final VoidCallback? onBack;
  final VoidCallback? onSaved;

  @override
  ConsumerState<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<TransactionForm> {
  late TransactionType _type = widget.type;
  final _amount = TextEditingController();
  final _note = TextEditingController();
  String? _category;
  final List<String> _customCategories = [];
  MoneyTag _tag = MoneyTag.personal;
  DateTime _date = DateTime.now();
  String? _goalChoice;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _amount.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  double? get _value {
    final v = parseNumber(_amount.text);
    return v == null || v <= 0 ? null : v;
  }

  Future<void> _customCategory() async {
    final l = context.l10n;
    final text = await showTextSheet(
      context,
      title: l.moneyCustomCategory,
      hint: l.moneyCustomHint,
      actionLabel: l.commonAdd,
    );
    if (text == null) return;
    setState(() {
      _customCategories.add(text);
      _category = text;
    });
  }

  Future<void> _pickDate() async {
    final date = await pickDate(context, initial: _date, last: DateTime.now());
    if (date == null) return;
    final now = DateTime.now();
    setState(
      () => _date = DateTime(
        date.year,
        date.month,
        date.day,
        now.hour,
        now.minute,
      ),
    );
  }

  Future<void> _save(List<String> categories) async {
    final value = _value;
    if (value == null) return;
    setState(() => _saving = true);
    final goals = (ref.read(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    final goal = _goalChoice == null && _type != TransactionType.saving
        ? null
        : resolveLinkedGoal(goals, LifeArea.finance, _goalChoice);
    await ref
        .read(financeRepositoryProvider)
        .add(
          type: _type,
          amountMinor: Fmt.majorToMinor(value),
          category: _category ?? categories.first,
          note: _note.text,
          tag: _tag,
          goal: goal,
          at: _date,
          currency: ref.read(preferencesProvider).currency,
        );
    if (!mounted) return;
    widget.onSaved?.call();
    if (widget.onSaved == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final currency = ref.watch(preferencesProvider.select((p) => p.currency));
    final categories = [...categoriesFor(context, _type), ..._customCategories];
    final color = switch (_type) {
      TransactionType.expense => AppColors.danger,
      TransactionType.income => AppColors.success,
      TransactionType.saving => AppColors.finance,
    };
    final isToday = DateUtils.isSameDay(_date, DateTime.now());
    return AppBottomSheet(
      title: l.moneyTitle,
      leading: widget.onBack == null
          ? null
          : SheetBackButton(onPressed: widget.onBack!),
      showClose: widget.onBack == null,
      action: PrimaryButton(
        key: const Key('money-save'),
        label: l.moneySave,
        icon: Symbols.check,
        loading: _saving,
        onPressed: _value == null || _saving ? null : () => _save(categories),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedPills<TransactionType>(
            values: TransactionType.values,
            selected: _type,
            labelOf: (t) => transactionTypeLabel(context, t),
            onChanged: (t) => setState(() {
              _type = t;
              _category = null;
            }),
          ),
          AppSpacing.gap20,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.cardAll,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.moneyAmount, style: AppTypography.caption),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        key: const Key('money-amount'),
                        controller: _amount,
                        autofocus: true,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: numberInputFormatters,
                        style: AppTypography.display.copyWith(color: color),
                        decoration: const InputDecoration(
                          hintText: '0',
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Text(
                      currency,
                      style: AppTypography.sectionTitle.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.moneyCategory),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final c in categories)
                ChoiceTag(
                  label: c,
                  selected: (_category ?? categories.first) == c,
                  color: AppColors.finance,
                  soft: AppColors.financeSoft,
                  onTap: () => setState(() => _category = c),
                ),
              ChoiceTag(
                label: l.moneyOther,
                selected: false,
                onTap: _customCategory,
              ),
            ],
          ),
          AppSpacing.gap20,
          Row(
            children: [
              Expanded(
                child: SegmentedPills<MoneyTag>(
                  values: MoneyTag.values,
                  selected: _tag,
                  compact: true,
                  labelOf: (t) => t == MoneyTag.personal
                      ? l.moneyPersonal
                      : l.moneyBusiness,
                  onChanged: (t) => setState(() => _tag = t),
                ),
              ),
              AppSpacing.gap12,
              ActionChip(
                avatar: const Icon(Symbols.calendar_today, size: 16),
                label: Text(isToday ? l.commonToday : Fmt.dayMonth(_date)),
                onPressed: _pickDate,
              ),
            ],
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.moneyNote,
            trailingLabel: l.commonOptional,
            hint: l.commonNotePlaceholder,
            controller: _note,
          ),
          if (_type == TransactionType.saving || _goalChoice != null) ...[
            AppSpacing.gap16,
            GoalLinkField(
              area: LifeArea.finance,
              choice: _goalChoice,
              onChanged: (c) => setState(() => _goalChoice = c),
            ),
          ] else if ((ref.watch(goalsProvider).value ?? const <Goal>[]).any(
            (g) => g.status == GoalStatus.active,
          )) ...[
            AppSpacing.gap8,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppTextButton(
                label: l.commonLinkedGoal,
                icon: Symbols.track_changes,
                onPressed: () => setState(() => _goalChoice = ''),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
