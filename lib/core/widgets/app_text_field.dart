import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../localization/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.trailingLabel,
    this.controller,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.sentences,
    this.onSubmitted,
    this.autofocus = false,
    this.enabled = true,
    this.style,
    this.fieldKey,
  });

  final String? label;
  final String? trailingLabel;
  final TextEditingController? controller;
  final String? hint;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool enabled;
  final TextStyle? style;
  final Key? fieldKey;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscure;

  @override
  Widget build(BuildContext context) {
    Widget? suffix = widget.suffixIcon;
    if (widget.obscure) {
      suffix = IconButton(
        tooltip: _obscured
            ? context.l10n.authShowPassword
            : context.l10n.authHidePassword,
        onPressed: () => setState(() => _obscured = !_obscured),
        icon: Icon(
          _obscured ? Symbols.visibility : Symbols.visibility_off,
          color: AppColors.textSecondary,
          size: 22,
        ),
      );
    }
    final field = TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      initialValue: widget.controller == null ? widget.initialValue : null,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscured,
      maxLines: widget.obscure ? 1 : widget.maxLines,
      minLines: widget.minLines,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
      onFieldSubmitted: widget.onSubmitted,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      style: widget.style ?? AppTypography.bodyLarge.copyWith(fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: suffix,
        prefixIcon: widget.prefixIcon,
        constraints: widget.maxLines == 1
            ? const BoxConstraints(minHeight: AppSpacing.inputHeight)
            : null,
      ),
    );
    if (widget.label == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        FieldLabel(label: widget.label!, trailing: widget.trailingLabel),
        const SizedBox(height: AppSpacing.sm),
        field,
      ],
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label, this.trailing});

  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: AppTypography.caption.copyWith(color: AppColors.textMuted),
          ),
      ],
    );
  }
}

class NumberStepper extends StatelessWidget {
  const NumberStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.step = 1,
    this.min = 0,
    this.max = 9999,
    this.format,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final double step;
  final double min;
  final double max;
  final String Function(double)? format;

  @override
  Widget build(BuildContext context) {
    final text = format?.call(value) ?? _trim(value);
    Widget button(IconData icon, double next, String label) => Material(
      color: AppColors.surfaceMuted,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: next < min || next > max ? null : () => onChanged(next),
        child: SizedBox.square(
          dimension: AppSpacing.minTouch,
          child: Icon(
            icon,
            size: 22,
            color: AppColors.textPrimary,
            semanticLabel: label,
          ),
        ),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        button(Symbols.remove, value - step, context.l10n.commonDecrease),
        Text(text, style: AppTypography.display.copyWith(fontSize: 28)),
        button(Symbols.add, value + step, context.l10n.commonIncrease),
      ],
    );
  }

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(2);
}
