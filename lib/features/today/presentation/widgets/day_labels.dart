import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/localization/l10n.dart';
import '../../domain/today_summary.dart';

String energyLabel(BuildContext context, Energy e) {
  final l = context.l10n;
  return switch (e) {
    Energy.low => l.energyLow,
    Energy.steady => l.energySteady,
    Energy.high => l.energyHigh,
  };
}

IconData energyIcon(Energy e) => switch (e) {
  Energy.low => Symbols.bedtime,
  Energy.steady => Symbols.graphic_eq,
  Energy.high => Symbols.bolt,
};

String capacityLabel(BuildContext context, Capacity c) {
  final l = context.l10n;
  return switch (c) {
    Capacity.light => l.capacityLight,
    Capacity.balanced => l.capacityBalanced,
    Capacity.focused => l.capacityFocused,
  };
}

String dayPartLabel(BuildContext context, DayPart part) {
  final l = context.l10n;
  return switch (part) {
    DayPart.morning => l.planMorning,
    DayPart.afternoon => l.planAfternoon,
    DayPart.evening => l.planEvening,
    DayPart.anytime => l.planAnytime,
  };
}

IconData dayPartIcon(DayPart part) => switch (part) {
  DayPart.morning => Symbols.wb_sunny,
  DayPart.afternoon => Symbols.light_mode,
  DayPart.evening => Symbols.nights_stay,
  DayPart.anytime => Symbols.schedule,
};
