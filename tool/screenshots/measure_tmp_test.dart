import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/localization/app_locale.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/theme/app_typography.dart';

import '../../test/helpers/pump_app.dart';
import '../../test/helpers/test_env.dart';

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

String _packageRoot(String name) {
  final config =
      jsonDecode(File('.dart_tool/package_config.json').readAsStringSync())
          as Map<String, dynamic>;
  final entry = (config['packages'] as List)
      .cast<Map<String, dynamic>>()
      .firstWhere((p) => p['name'] == name);
  final root = Uri.parse(entry['rootUri'] as String);
  return (root.isAbsolute
          ? root
          : Uri.directory(
              '${Directory.current.path}/.dart_tool/',
            ).resolveUri(root))
      .toFilePath();
}

void main() {
  setUpAll(() async {
    for (final family in ['Inter', 'IBMPlexSansArabic']) {
      await _loadFont(family, [
        for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold'])
          'assets/fonts/$family-$w.ttf',
      ]);
    }
    final symbols = _packageRoot('material_symbols_icons');
    await _loadFont('packages/material_symbols_icons/MaterialSymbolsOutlined', [
      '$symbols/lib/fonts/MaterialSymbolsOutlined.ttf',
    ]);
  });

  tearDown(() {
    AppLocale.apply(AppLanguages.english);
    AppTypography.useArabic(false);
  });

  const configs = [
    ('en', 390.0, 1.0, 34.0),
    ('ar', 390.0, 1.0, 34.0),
    ('en', 360.0, 1.0, 0.0),
    ('ar', 360.0, 1.0, 0.0),
    ('en', 430.0, 1.35, 34.0),
    ('ar', 360.0, 1.35, 34.0),
  ];
  const routes = [
    ('today', AppRoutes.today),
    ('progress', AppRoutes.progress),
    ('goals', AppRoutes.goals),
    ('profile', AppRoutes.profile),
    ('quran', AppRoutes.quran),
  ];

  for (final (lang, width, scale, inset) in configs) {
    testWidgets('nav $lang $width x$scale inset $inset', (tester) async {
      setPhoneSize(tester, width: width);
      tester.view.padding = FakeViewPadding(bottom: inset * 3);
      tester.view.viewPadding = FakeViewPadding(bottom: inset * 3);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final env = await TestEnv.create(
        session: readySession,
        now: DateTime(2026, 10, 22, 9, 30),
        prefs: lang == 'ar' ? {'pref.locale': 'ar'} : {},
      );
      final c = await pumpApp(
        tester,
        env,
        seed: (c) => c.read(demoDataSeederProvider).seed(),
      );
      for (final (name, route) in routes) {
        await goTo(tester, c, route);
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            'nav_review/${lang}_${width.toInt()}_${scale}_${name}.png',
          ),
        );
      }
    });
  }
}
