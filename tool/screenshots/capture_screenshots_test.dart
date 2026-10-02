// Renders README screenshots from the real app with demo data.
//
//   flutter test --update-goldens tool/screenshots/capture_screenshots_test.dart
//
// Lives outside test/ so the regular suite never runs it. Output goes to
// docs/screenshots/ (390 × 844 logical px at 3×).
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/localization/app_locale.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/theme/app_typography.dart';
import 'package:taqadum/features/profile/data/profile_repository.dart';

import '../../test/helpers/pump_app.dart';
import '../../test/helpers/test_env.dart';

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    final bytes = File(file).readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

String _packageRoot(String name) {
  final config = jsonDecode(
    File('.dart_tool/package_config.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final entry = (config['packages'] as List)
      .cast<Map<String, dynamic>>()
      .firstWhere((p) => p['name'] == name);
  final root = Uri.parse(entry['rootUri'] as String);
  return (root.isAbsolute
          ? root
          : Uri.directory('${Directory.current.path}/.dart_tool/')
                .resolveUri(root))
      .toFilePath();
}

const _shots = [
  ('01_today', AppRoutes.today),
  ('02_quran', AppRoutes.quran),
  ('03_work', AppRoutes.work),
  ('04_finance', AppRoutes.finance),
  ('05_goals', AppRoutes.goals),
  ('06_goal_detail', null),
  ('07_progress', AppRoutes.progress),
  ('08_progress_calendar', AppRoutes.calendar),
  ('09_weekly_review', AppRoutes.weeklyReview),
  ('10_profile', AppRoutes.profile),
];

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

  Future<(ProviderContainer, TestEnv)> boot(
    WidgetTester tester, {
    Map<String, Object> prefs = const {},
  }) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(
      session: readySession,
      now: DateTime(2026, 10, 22, 9, 30),
      prefs: prefs,
    );
    final c = await pumpApp(
      tester,
      env,
      seed: (c) async {
        await c
            .read(profileRepositoryProvider)
            .create(id: 'user-1', name: 'Amina Benali');
        await c
            .read(profileRepositoryProvider)
            .update(
              id: 'user-1',
              role: () => 'Founder',
              intention: () => 'Build a balanced year with faith, meaningful work and family.',
            );
        await c.read(demoDataSeederProvider).seed();
      },
    );
    return (c, env);
  }

  testWidgets('English showcase', (tester) async {
    final (c, env) = await boot(tester);
    for (final (name, route) in _shots) {
      var location = route;
      if (location == null) {
        final goals = await tester.runAsync(
          () => env.db.select(env.db.goals).get(),
        );
        location = AppRoutes.goal(goals!.firstWhere((g) => g.isPrimary).id);
      }
      await goTo(tester, c, location);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../docs/screenshots/$name.png'),
      );
    }
  });

  testWidgets('Arabic showcase', (tester) async {
    final (c, _) = await boot(tester, prefs: {'pref.locale': 'ar'});
    await goTo(tester, c, AppRoutes.today);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../docs/screenshots/11_today_arabic.png'),
    );
  });
}
