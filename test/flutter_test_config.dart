import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _symbolsFamily =
    'packages/material_symbols_icons/MaterialSymbolsOutlined';

/// Loads the bundled fonts so widget tests lay text out with real metrics and
/// goldens show real icon glyphs.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  const families = {
    'Inter': ['Regular', 'Medium', 'SemiBold', 'Bold'],
    'IBMPlexSansArabic': ['Regular', 'Medium', 'SemiBold', 'Bold'],
  };
  for (final MapEntry(key: family, value: weights) in families.entries) {
    final loader = FontLoader(family);
    for (final weight in weights) {
      final bytes = File('assets/fonts/$family-$weight.ttf').readAsBytesSync();
      loader.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }
  await (FontLoader(_symbolsFamily)..addFont(
        rootBundle.load(
          'packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf',
        ),
      ))
      .load();
  await testMain();
}
