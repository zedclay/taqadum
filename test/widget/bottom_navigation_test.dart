import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/localization/l10n.dart';
import 'package:taqadum/core/theme/app_colors.dart';
import 'package:taqadum/core/theme/app_spacing.dart';
import 'package:taqadum/core/theme/app_typography.dart';
import 'package:taqadum/core/widgets/app_bottom_navigation.dart';

import '../helpers/pump_app.dart';

const _english = ['Today', 'Progress', 'Goals', 'Profile'];
const _arabic = ['اليوم', 'التقدّم', 'الأهداف', 'الملف الشخصي'];
const _quickAdd = Key('quick-add-button');

class _Calls {
  final tabs = <int>[];
  var quickAdd = 0;
}

Future<_Calls> _pumpNav(
  WidgetTester tester, {
  bool arabic = false,
  int index = 0,
  double width = 390,
  double scale = 1,
  double bottomInset = 0,
}) async {
  setPhoneSize(tester, width: width);
  tester.view.padding = FakeViewPadding(bottom: bottomInset * 3);
  tester.view.viewPadding = FakeViewPadding(bottom: bottomInset * 3);
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  AppTypography.useArabic(arabic);
  final calls = _Calls();
  await tester.pumpWidget(
    MaterialApp(
      locale: arabic ? const Locale('ar', 'DZ') : const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('ar', 'DZ')],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: const SizedBox.expand(),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: index,
          onTabSelected: calls.tabs.add,
          onQuickAdd: () => calls.quickAdd++,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return calls;
}

Finder _label(String text) => find.descendant(
  of: find.byType(AppBottomNavigation),
  matching: find.text(text),
);

double _x(WidgetTester tester, Finder finder) => tester.getCenter(finder).dx;

Rect _bar(WidgetTester tester) =>
    tester.getRect(find.byType(AppBottomNavigation));

Rect _fabCircle(WidgetTester tester) => tester.getRect(
  find.descendant(
    of: find.byKey(_quickAdd),
    matching: find.byType(DecoratedBox),
  ),
);

void main() {
  tearDown(() => AppTypography.useArabic(false));

  testWidgets('English reads Today, Progress, +, Goals, Profile', (
    tester,
  ) async {
    await _pumpNav(tester);
    final xs = [
      _x(tester, _label('Today')),
      _x(tester, _label('Progress')),
      _x(tester, find.byKey(_quickAdd)),
      _x(tester, _label('Goals')),
      _x(tester, _label('Profile')),
    ];
    expect(xs, orderedEquals([...xs]..sort()));
    expect(_x(tester, find.byKey(_quickAdd)), closeTo(195, 0.5));
  });

  testWidgets('Arabic mirrors the order through Directionality', (
    tester,
  ) async {
    await _pumpNav(tester, arabic: true);
    expect(
      Directionality.of(tester.element(find.byKey(_quickAdd))),
      TextDirection.rtl,
    );
    final xs = [
      _x(tester, _label('الملف الشخصي')),
      _x(tester, _label('الأهداف')),
      _x(tester, find.byKey(_quickAdd)),
      _x(tester, _label('التقدّم')),
      _x(tester, _label('اليوم')),
    ];
    expect(xs, orderedEquals([...xs]..sort()));
    expect(
      tester.widget<Text>(_label('اليوم')).style?.fontFamily,
      AppTypography.arabicFamily,
    );
  });

  testWidgets('only the active destination is orange and selected', (
    tester,
  ) async {
    await _pumpNav(tester, index: 1);
    Color? color(String label) =>
        tester.widget<Text>(_label(label)).style?.color;
    expect(color('Progress'), AppColors.brand);
    for (final label in ['Today', 'Goals', 'Profile']) {
      expect(color(label), AppColors.textSecondary, reason: label);
    }
    expect(
      tester.getSemantics(_label('Progress')),
      isSemantics(
        label: 'Progress',
        isButton: true,
        isSelected: true,
        hasTapAction: true,
      ),
    );
    expect(
      tester.getSemantics(_label('Today')),
      isSemantics(label: 'Today', isSelected: false),
    );
    expect(
      tester.getSemantics(find.byKey(_quickAdd)),
      isSemantics(label: 'Quick Add', isButton: true, hasTapAction: true),
    );
  });

  testWidgets('tabs report their index and + calls Quick Add', (tester) async {
    final calls = await _pumpNav(tester);
    for (final label in _english) {
      await tester.tap(_label(label));
    }
    expect(calls.tabs, [0, 1, 2, 3]);
    expect(calls.quickAdd, 0);

    await tester.tap(find.byKey(_quickAdd));
    expect(calls.quickAdd, 1);
    expect(calls.tabs, [0, 1, 2, 3]);
  });

  testWidgets('the part of + above the bar is tappable; elsewhere passes '
      'through', (tester) async {
    final calls = await _pumpNav(tester);
    final bar = _bar(tester);
    final fab = _fabCircle(tester);
    expect(fab.width, AppSpacing.fabSize);
    expect(fab.top, closeTo(bar.top - AppBottomNavigation.fabRise, 0.5));

    await tester.tapAt(Offset(fab.center.dx, bar.top - 4));
    expect(calls.quickAdd, 1);

    await tester.tapAt(Offset(_x(tester, _label('Today')), bar.top - 4));
    expect(calls.tabs, isEmpty);
  });

  testWidgets('tap targets meet the minimum sizes', (tester) async {
    await _pumpNav(tester, width: 360);
    final fab = tester.getSize(find.byKey(_quickAdd));
    expect(fab.width, greaterThanOrEqualTo(56));
    expect(fab.height, greaterThanOrEqualTo(56));
    final items = tester.widgetList(find.byType(InkResponse)).length;
    expect(items, 4);
    final sizes = [
      for (final e in find.byType(InkResponse).evaluate())
        tester.getSize(find.byWidget(e.widget)),
    ];
    for (final size in sizes) {
      expect(size.width, greaterThanOrEqualTo(AppSpacing.minTouch));
      expect(size.height, greaterThanOrEqualTo(AppSpacing.minTouch));
      expect(size, sizes.first);
    }
  });

  testWidgets('sits above the bottom safe area without guessing it', (
    tester,
  ) async {
    await _pumpNav(tester, bottomInset: 34);
    final bar = _bar(tester);
    expect(bar.bottom, 844);
    expect(bar.height, AppSpacing.navBarHeight + 34);
    for (final label in _english) {
      expect(tester.getRect(_label(label)).bottom, lessThan(844 - 34));
    }
  });

  testWidgets('keeps breathing room when there is no safe area', (
    tester,
  ) async {
    await _pumpNav(tester);
    final bar = _bar(tester);
    expect(bar.height, AppSpacing.navBarHeight + AppSpacing.xs);
    for (final label in _english) {
      expect(
        tester.getRect(_label(label)).bottom,
        lessThanOrEqualTo(844 - AppSpacing.sm),
      );
    }
  });

  for (final arabic in [false, true]) {
    for (final width in [360.0, 390.0, 430.0]) {
      for (final scale in [1.0, 1.35]) {
        final name = arabic ? 'Arabic' : 'English';
        testWidgets('$name labels fit on one line at ${width}px x$scale', (
          tester,
        ) async {
          await _pumpNav(tester, arabic: arabic, width: width, scale: scale);
          expect(tester.takeException(), isNull);
          final bar = _bar(tester);
          final labels = arabic ? _arabic : _english;
          final sizes = <double>{};
          for (final label in labels) {
            final paragraph = tester.renderObject<RenderParagraph>(
              _label(label),
            );
            expect(paragraph.didExceedMaxLines, isFalse, reason: label);
            final rect = tester.getRect(_label(label));
            expect(rect.left, greaterThanOrEqualTo(0), reason: label);
            expect(rect.right, lessThanOrEqualTo(width), reason: label);
            expect(rect.bottom, lessThanOrEqualTo(bar.bottom), reason: label);
            sizes.add(paragraph.textScaler.scale(12));
          }
          expect(sizes, hasLength(1), reason: 'labels share one size');
          expect(sizes.single, greaterThanOrEqualTo(11));
        });
      }
    }
  }
}
