import 'package:flutter/services.dart';

/// Parses user-entered numbers such as "600,000" or "1.5".
double? parseNumber(String? input) {
  if (input == null) return null;
  final cleaned = input.replaceAll(RegExp(r'[\s,]'), '');
  if (cleaned.isEmpty) return null;
  return double.tryParse(cleaned);
}

/// Allows digits with grouping commas and a single decimal point.
final numberInputFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
];

String editableNumber(double value) =>
    value == value.roundToDouble() ? value.round().toString() : '$value';
