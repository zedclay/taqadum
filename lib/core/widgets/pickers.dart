import 'package:flutter/material.dart';

/// Returns the picked time as minutes since midnight.
Future<int?> pickMinuteOfDay(
  BuildContext context, {
  required int initial,
  required bool use24h,
}) async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initial ~/ 60, minute: initial % 60),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: use24h),
      child: child!,
    ),
  );
  return picked == null ? null : picked.hour * 60 + picked.minute;
}

Future<DateTime?> pickDate(
  BuildContext context, {
  required DateTime initial,
  DateTime? first,
  DateTime? last,
}) {
  final firstDate = first ?? DateTime(initial.year - 5);
  final lastDate = last ?? DateTime(initial.year + 10);
  var start = initial;
  if (start.isBefore(firstDate)) start = firstDate;
  if (start.isAfter(lastDate)) start = lastDate;
  return showDatePicker(
    context: context,
    initialDate: start,
    firstDate: firstDate,
    lastDate: lastDate,
  );
}
