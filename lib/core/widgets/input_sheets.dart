import 'package:flutter/material.dart';

import '../localization/l10n.dart';
import '../utilities/number_input.dart';
import 'app_bottom_sheet.dart';
import 'app_text_field.dart';
import 'buttons.dart';

/// Single numeric input in a sheet. Returns null when dismissed.
Future<double?> showNumberSheet(
  BuildContext context, {
  required String title,
  String? hint,
  double? initial,
  String? suffix,
  bool allowZero = true,
}) => showAppSheet<double>(
  context,
  builder: (_) => _NumberSheet(
    title: title,
    hint: hint,
    initial: initial,
    suffix: suffix,
    allowZero: allowZero,
  ),
);

class _NumberSheet extends StatefulWidget {
  const _NumberSheet({
    required this.title,
    this.hint,
    this.initial,
    this.suffix,
    this.allowZero = true,
  });

  final String title;
  final String? hint;
  final double? initial;
  final String? suffix;
  final bool allowZero;

  @override
  State<_NumberSheet> createState() => _NumberSheetState();
}

class _NumberSheetState extends State<_NumberSheet> {
  late final _controller = TextEditingController(
    text: widget.initial == null ? '' : editableNumber(widget.initial!),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? get _value {
    final v = parseNumber(_controller.text);
    if (v == null || v < 0 || (!widget.allowZero && v == 0)) return null;
    return v;
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: widget.title,
      subtitle: widget.hint,
      action: PrimaryButton(
        label: context.l10n.commonSave,
        onPressed: _value == null
            ? null
            : () => Navigator.of(context).pop(_value),
      ),
      child: AppTextField(
        controller: _controller,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: numberInputFormatters,
        suffixIcon: widget.suffix == null || widget.suffix!.isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(widthFactor: 1, child: Text(widget.suffix!)),
              ),
      ),
    );
  }
}

/// Single-line text input in a sheet. Returns trimmed text or null.
Future<String?> showTextSheet(
  BuildContext context, {
  required String title,
  String? hint,
  String? initial,
  String? actionLabel,
}) => showAppSheet<String>(
  context,
  builder: (_) => _TextSheet(
    title: title,
    hint: hint,
    initial: initial,
    actionLabel: actionLabel,
  ),
);

class _TextSheet extends StatefulWidget {
  const _TextSheet({
    required this.title,
    this.hint,
    this.initial,
    this.actionLabel,
  });

  final String title;
  final String? hint;
  final String? initial;
  final String? actionLabel;

  @override
  State<_TextSheet> createState() => _TextSheetState();
}

class _TextSheetState extends State<_TextSheet> {
  late final _controller = TextEditingController(text: widget.initial ?? '');

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: widget.title,
      action: PrimaryButton(
        label: widget.actionLabel ?? context.l10n.commonSave,
        onPressed: _controller.text.trim().isEmpty ? null : _submit,
      ),
      child: AppTextField(
        controller: _controller,
        hint: widget.hint,
        autofocus: true,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}
