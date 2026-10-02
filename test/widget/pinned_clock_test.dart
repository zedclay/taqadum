import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taqadum/core/demo/demo_data_seeder.dart';
import 'package:taqadum/core/domain/enums.dart';
import 'package:taqadum/core/routing/app_routes.dart';
import 'package:taqadum/features/goals/data/goals_repository.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_env.dart';

/// Screens read "now" from the injected clock, so a pinned app date shows
/// up everywhere instead of the machine's real date.
void main() {
  final pinned = DateTime(2026, 10, 22, 9, 30);

  Future<(dynamic, TestEnv)> boot(
    WidgetTester tester, {
    bool demo = true,
  }) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(session: readySession, now: pinned);
    final c = await pumpApp(
      tester,
      env,
      seed: (c) => c.read(demoDataSeederProvider).seed(),
    );
    return (c, env);
  }

  Iterable<String> texts(WidgetTester tester) => find
      .byType(RichText)
      .evaluate()
      .map((e) => (e.widget as RichText).text.toPlainText());

  testWidgets('Today shows the pinned date', (tester) async {
    await boot(tester);
    expect(find.text('Thursday, 22 October'), findsOneWidget);
  });

  testWidgets('weekly review completion uses the pinned date', (tester) async {
    final (c, _) = await boot(tester);
    await goTo(tester, c, AppRoutes.weeklyReview);
    final completed = texts(tester).where((t) => t.startsWith('Completed '));
    expect(completed, isNotEmpty);
    expect(completed, everyElement(contains('Oct 22')));
  });

  testWidgets('goal history age is counted from the pinned date', (
    tester,
  ) async {
    setPhoneSize(tester);
    final env = await TestEnv.create(session: readySession, now: pinned);
    late String id;
    final c = await pumpApp(
      tester,
      env,
      seed: (c) async {
        final repo = c.read(goalsRepositoryProvider);
        id = await repo.save(
          const GoalDraft(
            title: 'Read 12 books',
            area: LifeArea.learning,
            type: GoalType.target,
            targetValue: 12,
            unit: 'books',
          ),
        );
        await repo.logProgress(
          goal: (await repo.getGoal(id))!,
          delta: 1,
          at: pinned.subtract(const Duration(days: 6)),
        );
      },
    );
    await goTo(tester, c, AppRoutes.goal(id));
    await tester.scrollUntilVisible(find.text('6 days ago'), 300);
    expect(find.text('6 days ago'), findsOneWidget);
  });

  testWidgets('Quran memorization never shows more pages than the surah', (
    tester,
  ) async {
    final (c, _) = await boot(tester);
    await goTo(tester, c, AppRoutes.quran);
    const fractions = {'¼': 0.25, '½': 0.5, '¾': 0.75};
    double parse(String value) {
      final frac = fractions[value.characters.last];
      if (frac == null) return double.parse(value);
      final whole = value.substring(0, value.length - 1);
      return (whole.isEmpty ? 0 : double.parse(whole)) + frac;
    }

    final pattern = RegExp(r'^(\S+) of (\d+) pages?$');
    final matches = [for (final t in texts(tester)) ?pattern.firstMatch(t)];
    expect(matches, hasLength(1));
    final done = parse(matches.single.group(1)!);
    final total = int.parse(matches.single.group(2)!);
    expect(done, greaterThan(0));
    expect(done, lessThanOrEqualTo(total));
  });
}
