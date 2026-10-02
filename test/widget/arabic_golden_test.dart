import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/localization/app_locale.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/theme/app_typography.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

/// Visual references for the Arabic RTL layout. Regenerate with
/// `flutter test --update-goldens test/widget/arabic_golden_test.dart`.
void main() {
  tearDown(() {
    AppLocale.apply(AppLanguages.english);
    AppTypography.useArabic(false);
  });

  for (final (name, route) in [
    ('today', AppRoutes.today),
    ('finance', AppRoutes.finance),
    ('settings', AppRoutes.settings),
  ]) {
    testWidgets('Arabic $name golden', (tester) async {
      setPhoneSize(tester);
      final env = await TestEnv.create(
        session: readySession,
        prefs: {'pref.locale': 'ar'},
      );
      final c = await pumpApp(
        tester,
        env,
        seed: (c) => c.read(demoDataSeederProvider).seed(),
      );
      await goTo(tester, c, route);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/ar_$name.png'),
      );
    });
  }
}
