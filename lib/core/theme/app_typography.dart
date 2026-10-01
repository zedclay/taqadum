import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static const fontFamily = 'Inter';
  static const fontFallback = ['IBMPlexSansArabic'];
  static const _tabular = [FontFeature.tabularFigures()];

  static const _base = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallback,
    color: AppColors.textPrimary,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static final display = _base.copyWith(
    fontSize: 32,
    height: 38 / 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    fontFeatures: _tabular,
  );

  static final pageTitle = _base.copyWith(
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static final headline = _base.copyWith(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  );

  static final sectionTitle = _base.copyWith(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  static final cardTitle = _base.copyWith(
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
  );

  static final bodyLarge = _base.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  static final body = _base.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final bodyMedium = _base.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
  );

  static final label = _base.copyWith(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
  );

  static final caption = _base.copyWith(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final captionSmall = _base.copyWith(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static final overline = _base.copyWith(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: AppColors.textSecondary,
  );

  static final button = _base.copyWith(
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
  );

  static final metric = _base.copyWith(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
    fontFeatures: _tabular,
  );

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

extension TabularText on TextStyle {
  TextStyle get tabular =>
      copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}
