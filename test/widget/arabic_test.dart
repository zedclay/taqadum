import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/domain/enums.dart';
import 'package:taqadum/core/localization/app_locale.dart';
import 'package:taqadum/core/routing/app_router.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/core/theme/app_typography.dart';
import 'package:taqadum/core/widgets/app_bottom_navigation.dart';
import 'package:taqadum/features/goals/data/goals_repository.dart';
import 'package:taqadum/features/settings/data/preferences.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

const _routes = [
  AppRoutes.today,
  AppRoutes.morningCheckIn,
  AppRoutes.plan,
  AppRoutes.nightReview,
  AppRoutes.quran,
  AppRoutes.work,
  AppRoutes.finance,
  AppRoutes.health,
  AppRoutes.learning,
  AppRoutes.goals,
  AppRoutes.newGoal,
  AppRoutes.progress,
  AppRoutes.calendar,
  AppRoutes.weeklyReview,
  AppRoutes.monthlyReview,
  AppRoutes.activity,
  AppRoutes.notifications,
  AppRoutes.profile,
  AppRoutes.settings,
];

const _quickAddKinds = ['task', 'quran', 'money', 'work', 'habit', 'note'];

/// Latin text that is intentionally shown in the Arabic UI: ISO currency
/// codes and export format names.
const _allowedLatin = ['DZD', 'JSON', 'CSV'];

/// Whole strings kept in Latin on purpose: the English switch on the sign-in
/// screen and the email placeholder.
const _allowedTexts = {'عربي  |  EN', 'name@example.com'};

final _latinWord = RegExp('[A-Za-z]{2,}');
final _isolated = RegExp('\u2068[^\u2069]*\u2069');

const _arabicPrefs = {'pref.locale': 'ar'};

/// Visible Latin words that are not user content (user content is isolated
/// with bidi marks) and not on the allow list.
List<String> _leftoverEnglish(WidgetTester tester) {
  final texts = [
    for (final e in find.byType(RichText).evaluate())
      (e.widget as RichText).text.toPlainText(),
    for (final e in find.byType(Tooltip).evaluate())
      (e.widget as Tooltip).message ?? '',
  ];
  return [
    for (final text in texts)
      if (!_allowedTexts.contains(text))
        for (final m in _latinWord.allMatches(text.replaceAll(_isolated, '')))
          if (!_allowedLatin.contains(m.group(0))) text,
  ];
}

String _path(dynamic c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path
        as String;

void main() {
  tearDown(() {
    AppLocale.apply(AppLanguages.english);
    AppTypography.useArabic(false);
  });

  testWidgets('launches in Arabic with RTL and Arabic navigation', (
    tester,
  ) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(
      session: readySession,
      prefs: _arabicPrefs,
    );
    await pumpApp(tester, env);

    final today = find.byKey(const Key('quick-add-button'));
    expect(Directionality.of(tester.element(today)), TextDirection.rtl);
    expect(
      Localizations.localeOf(tester.element(today)),
      const Locale('ar', 'DZ'),
    );
    Finder nav(String text) => find.descendant(
      of: find.byType(AppBottomNavigation),
      matching: find.text(text),
    );
    for (final label in ['اليوم', 'التقدّم', 'الأهداف', 'الملف الشخصي']) {
      expect(nav(label), findsOneWidget, reason: label);
    }
    expect(nav('Today'), findsNothing);
    expect(find.textContaining('صباح الخير'), findsWidgets);
    expect(find.textContaining('الأربعاء، 10 مارس'), findsWidgets);
    expect(AppTypography.body.fontFamily, AppTypography.arabicFamily);
  });

  for (final (width, scale) in [(360.0, 1.0), (430.0, 1.0), (360.0, 1.35)]) {
    testWidgets('every screen fits in Arabic at ${width}px x$scale', (
      tester,
    ) async {
      setPhoneSize(tester, width: width);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final env = await TestEnv.create(
        session: readySession,
        prefs: _arabicPrefs,
      );
      final c = await pumpApp(
        tester,
        env,
        seed: (c) => c.read(demoDataSeederProvider).seed(),
      );
      for (final route in _routes) {
        await goTo(tester, c, route);
        expect(tester.takeException(), isNull, reason: route);
      }
      final goals = await tester.runAsync(
        () => env.db.select(env.db.goals).get(),
      );
      await goTo(tester, c, AppRoutes.goal(goals!.first.id));
      expect(tester.takeException(), isNull);
      await goTo(tester, c, AppRoutes.editGoal(goals.first.id));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('no system text is left in English', (tester) async {
    setPhoneSize(tester);
    // A tall viewport renders whole screens, not only what fits on a phone.
    tester.view.physicalSize = const Size(390 * 3, 4000 * 3);
    final env = await TestEnv.create(
      session: readySession,
      prefs: _arabicPrefs,
    );
    final c = await pumpApp(
      tester,
      env,
      seed: (c) => c.read(demoDataSeederProvider).seed(),
    );
    final leftovers = <String, List<String>>{};
    for (final route in _routes) {
      await goTo(tester, c, route);
      final found = _leftoverEnglish(tester);
      if (found.isNotEmpty) leftovers[route] = found;
    }
    await goTo(tester, c, AppRoutes.today);
    for (final kind in _quickAddKinds) {
      await tester.tap(find.byKey(const Key('quick-add-button')));
      await settle(tester);
      await tester.tap(find.byKey(Key('quick-$kind')));
      await settle(tester);
      final found = _leftoverEnglish(tester);
      if (found.isNotEmpty) leftovers['quick-$kind'] = found;
      await tester.tapAt(const Offset(20, 20));
      await settle(tester);
    }
    expect(leftovers, isEmpty);
  });

  testWidgets('Arabic onboarding and goal setup complete', (tester) async {
    setPhoneSize(tester, width: 360);
    tester.platformDispatcher.textScaleFactorTestValue = 1.35;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final env = await TestEnv.create(prefs: _arabicPrefs);
    final c = await pumpApp(tester, env);

    Future<void> tap(Key key) async {
      final target = find.byKey(key);
      if (target.evaluate().isEmpty) {
        await tester.scrollUntilVisible(
          target,
          200,
          scrollable: find.byType(Scrollable).first,
        );
      }
      await tester.ensureVisible(target);
      await tester.pump();
      await tester.tap(target);
      await settle(tester);
    }

    expect(_path(c), AppRoutes.auth);
    expect(_leftoverEnglish(tester), isEmpty);
    await tap(const Key('continue-on-device'));
    await tester.enterText(
      find.byKey(const Key('device-profile-name')),
      'سارة',
    );
    await tester.pump();
    await tap(const Key('device-profile-start'));
    expect(_path(c), AppRoutes.onboarding);
    expect(find.textContaining('تحسينه'), findsWidgets);

    for (var i = 0; i < 6 && _path(c) == AppRoutes.onboarding; i++) {
      expect(_leftoverEnglish(tester), isEmpty, reason: 'onboarding step $i');
      await tap(const Key('onboarding-continue'));
      expect(tester.takeException(), isNull);
    }
    expect(_path(c), AppRoutes.goalSetup);
    expect(_leftoverEnglish(tester), isEmpty);

    await tester.enterText(find.byKey(const Key('goal-title')), 'حفظ جزء عمّ');
    await tester.enterText(find.byKey(const Key('goal-target')), '30');
    await tester.pump();
    await tap(const Key('goal-save'));
    await tap(const Key('goal-setup-finish'));
    expect(_path(c), AppRoutes.today);
    expect(tester.takeException(), isNull);

    final goals = await tester.runAsync(
      () => env.db.select(env.db.goals).get(),
    );
    expect(goals!.single.title, 'حفظ جزء عمّ');
  });

  testWidgets('a mixed English goal title renders intact', (tester) async {
    setPhoneSize(tester, width: 360);
    final env = await TestEnv.create(
      session: readySession,
      prefs: _arabicPrefs,
    );
    final c = await pumpApp(tester, env);
    await tester.runAsync(
      () => c
          .read(goalsRepositoryProvider)
          .save(
            const GoalDraft(
              title: 'Read Atomic Habits (2nd time).',
              area: LifeArea.learning,
              type: GoalType.target,
              targetValue: 300,
              unit: 'pages',
            ),
          ),
    );
    await goTo(tester, c, AppRoutes.goals);
    expect(
      find.textContaining('\u2068Read Atomic Habits (2nd time).\u2069'),
      findsWidgets,
    );
    expect(find.textContaining('صفحة'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Arabic finance and settings use Arabic labels', (tester) async {
    setPhoneSize(tester, width: 360);
    final env = await TestEnv.create(
      session: readySession,
      prefs: _arabicPrefs,
    );
    final c = await pumpApp(
      tester,
      env,
      seed: (c) => c.read(demoDataSeederProvider).seed(),
    );
    await goTo(tester, c, AppRoutes.finance);
    expect(find.text('المال'), findsWidgets);
    expect(find.textContaining('دج'), findsWidgets);

    await goTo(tester, c, AppRoutes.settings);
    expect(find.text('التفضيلات'), findsOneWidget);
    expect(find.text('العربية'), findsOneWidget);
  });

  testWidgets('switching language from settings applies immediately', (
    tester,
  ) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(
      session: readySession,
      prefs: _arabicPrefs,
    );
    final c = await pumpApp(
      tester,
      env,
      seed: (c) => c.read(demoDataSeederProvider).seed(),
    );
    final goalsBefore = await tester.runAsync(
      () => env.db.select(env.db.goals).get(),
    );
    await goTo(tester, c, AppRoutes.settings);

    await tester.tap(find.byKey(const Key('settings-language')));
    await settle(tester);
    expect(find.text('Français'), findsOneWidget);
    await tester.tap(find.text('English'));
    await settle(tester);

    expect(env.prefs.getString(PrefKeys.locale), 'en');
    expect(find.text('PREFERENCES'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.text('PREFERENCES'))),
      TextDirection.ltr,
    );
    expect(AppTypography.body.fontFamily, AppTypography.latinFamily);
    await goTo(tester, c, AppRoutes.today);
    expect(
      find.descendant(
        of: find.byType(AppBottomNavigation),
        matching: find.text('Today'),
      ),
      findsOneWidget,
    );
    final goalsAfter = await tester.runAsync(
      () => env.db.select(env.db.goals).get(),
    );
    expect(
      goalsAfter!.map((g) => g.toJson()).toList(),
      goalsBefore!.map((g) => g.toJson()).toList(),
    );

    await goTo(tester, c, AppRoutes.settings);
    await tester.tap(find.byKey(const Key('settings-language')));
    await settle(tester);
    await tester.tap(find.text('العربية'));
    await settle(tester);
    expect(find.text('التفضيلات'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
