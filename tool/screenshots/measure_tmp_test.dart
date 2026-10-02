import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

void main() {
  test('measure', () async {
    for (final family in ['Inter', 'IBMPlexSansArabic']) {
      await _loadFont(family, [
        for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold'])
          'assets/fonts/$family-$w.ttf',
      ]);
    }
    for (final (family, labels) in [
      ('Inter', ['Today', 'Progress', 'Goals', 'Profile']),
      ('IBMPlexSansArabic', ['اليوم', 'التقدّم', 'الأهداف', 'الملف الشخصي']),
    ]) {
      for (final scale in [1.0, 1.2, 1.35]) {
        for (final w in [FontWeight.w500, FontWeight.w600]) {
          final widths = [
            for (final l in labels)
              (TextPainter(
                text: TextSpan(
                  text: l,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: w,
                  ),
                ),
                textDirection: TextDirection.ltr,
                textScaler: TextScaler.linear(scale),
              )..layout()).size,
          ];
          // ignore: avoid_print
          print('$family x$scale $w: $widths');
        }
      }
    }
  });
}
