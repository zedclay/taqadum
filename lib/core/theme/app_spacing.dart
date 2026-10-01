import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 28;
  static const double huge = 32;

  static const double screen = 20;
  static const double card = 16;
  static const double heroCard = 20;
  static const double section = 28;

  static const double buttonHeight = 56;
  static const double inputHeight = 54;
  static const double minTouch = 44;
  static const double navBarHeight = 76;
  static const double fabSize = 50;

  static const screenPadding = EdgeInsets.symmetric(horizontal: screen);
  static const cardPadding = EdgeInsets.all(card);
  static const heroPadding = EdgeInsets.all(heroCard);

  static const gap4 = SizedBox(height: xs, width: xs);
  static const gap8 = SizedBox(height: sm, width: sm);
  static const gap12 = SizedBox(height: md, width: md);
  static const gap16 = SizedBox(height: lg, width: lg);
  static const gap20 = SizedBox(height: xl, width: xl);
  static const gap24 = SizedBox(height: xxl, width: xxl);
  static const gap28 = SizedBox(height: xxxl, width: xxxl);
  static const gap32 = SizedBox(height: huge, width: huge);
}
