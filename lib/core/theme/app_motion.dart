import 'package:flutter/widgets.dart';

abstract final class AppMotion {
  static const small = Duration(milliseconds: 180);
  static const page = Duration(milliseconds: 240);
  static const progress = Duration(milliseconds: 260);
  static const sheet = Duration(milliseconds: 250);
  static const curve = Curves.easeOutCubic;

  static Duration of(BuildContext context, Duration base) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false
      ? Duration.zero
      : base;
}
