import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double input = 14;
  static const double button = 16;
  static const double card = 16;
  static const double hero = 20;
  static const double sheet = 24;
  static const double pill = 999;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const inputAll = BorderRadius.all(Radius.circular(input));
  static const buttonAll = BorderRadius.all(Radius.circular(button));
  static const cardAll = BorderRadius.all(Radius.circular(card));
  static const heroAll = BorderRadius.all(Radius.circular(hero));
  static const pillAll = BorderRadius.all(Radius.circular(pill));
  static const sheetTop = BorderRadius.vertical(top: Radius.circular(sheet));
}
