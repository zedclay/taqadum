import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Type scale. English uses Inter; Arabic uses IBM Plex Sans Arabic with zero
/// letter spacing (tracking breaks joined Arabic letters). Both families are
/// bundled in `assets/fonts/` at weights 400–700.
abstract final class AppTypography {
  static const latinFamily = 'Inter';
  static const arabicFamily = 'IBMPlexSansArabic';

  static _TypeScale _scale = _TypeScale(arabic: false);

  static bool get isArabic => _scale.arabic;
  static String get fontFamily => _scale.family;
  static List<String> get fontFallback => _scale.fallback;

  /// Switches every style to the script of the active language.
  static void useArabic(bool arabic) {
    if (_scale.arabic != arabic) _scale = _TypeScale(arabic: arabic);
  }

  static TextStyle get display => _scale.display;
  static TextStyle get pageTitle => _scale.pageTitle;
  static TextStyle get headline => _scale.headline;
  static TextStyle get sectionTitle => _scale.sectionTitle;
  static TextStyle get cardTitle => _scale.cardTitle;
  static TextStyle get bodyLarge => _scale.bodyLarge;
  static TextStyle get body => _scale.body;
  static TextStyle get bodyMedium => _scale.bodyMedium;
  static TextStyle get label => _scale.label;
  static TextStyle get caption => _scale.caption;
  static TextStyle get captionSmall => _scale.captionSmall;
  static TextStyle get overline => _scale.overline;
  static TextStyle get button => _scale.button;
  static TextStyle get metric => _scale.metric;

  static TextTheme textTheme() => TextTheme(
    displayLarge: display,
    displayMedium: display,
    displaySmall: pageTitle,
    headlineLarge: pageTitle,
    headlineMedium: headline,
    headlineSmall: sectionTitle,
    titleLarge: sectionTitle,
    titleMedium: cardTitle,
    titleSmall: bodyMedium,
    bodyLarge: bodyLarge,
    bodyMedium: body.copyWith(color: AppColors.textPrimary),
    bodySmall: caption,
    labelLarge: button,
    labelMedium: label,
    labelSmall: captionSmall,
  );
}

class _TypeScale {
  _TypeScale({required this.arabic});

  final bool arabic;

  static const _tabular = [FontFeature.tabularFigures()];

  String get family =>
      arabic ? AppTypography.arabicFamily : AppTypography.latinFamily;
  List<String> get fallback => [
    arabic ? AppTypography.latinFamily : AppTypography.arabicFamily,
  ];

  double _tracking(double latin) => arabic ? 0 : latin;

  late final TextStyle _base = TextStyle(
    fontFamily: family,
    fontFamilyFallback: fallback,
    color: AppColors.textPrimary,
    leadingDistribution: TextLeadingDistribution.even,
  );

  late final TextStyle display = _base.copyWith(
    fontSize: 32,
    height: 38 / 32,
    fontWeight: FontWeight.w700,
    letterSpacing: _tracking(-0.6),
    fontFeatures: _tabular,
  );

  late final TextStyle pageTitle = _base.copyWith(
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w700,
    letterSpacing: _tracking(-0.5),
  );

  late final TextStyle headline = _base.copyWith(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    letterSpacing: _tracking(-0.3),
  );

  late final TextStyle sectionTitle = _base.copyWith(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    letterSpacing: _tracking(-0.2),
  );

  late final TextStyle cardTitle = _base.copyWith(
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
  );

  late final TextStyle bodyLarge = _base.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  late final TextStyle body = _base.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  late final TextStyle bodyMedium = _base.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
  );

  late final TextStyle label = _base.copyWith(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
  );

  late final TextStyle caption = _base.copyWith(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  late final TextStyle captionSmall = _base.copyWith(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  late final TextStyle overline = _base.copyWith(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w600,
    letterSpacing: _tracking(0.8),
    color: AppColors.textSecondary,
  );

  late final TextStyle button = _base.copyWith(
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
  );

  late final TextStyle metric = _base.copyWith(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
    fontFeatures: _tabular,
  );
}

extension TabularText on TextStyle {
  TextStyle get tabular =>
      copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}
