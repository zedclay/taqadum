import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:taqadum/core/database/app_database.dart';
import 'package:taqadum/core/localization/app_locale.dart';
import 'package:taqadum/core/utilities/bidi.dart';
import 'package:taqadum/core/utilities/formatters.dart';
import 'package:taqadum/core/utilities/search_text.dart';
import 'package:taqadum/features/history/presentation/activity_text.dart';
import 'package:taqadum/features/quran/domain/surahs.dart';
import 'package:taqadum/l10n/generated/app_localizations.dart';

ActivityEvent _event({
  required String entityType,
  required String title,
  String? subtitle,
  String? entityId,
  Map<String, Object?>? facts,
  ActivityType type = ActivityType.logged,
}) => ActivityEvent(
  id: 'e1',
  type: type,
  title: title,
  subtitle: subtitle,
  entityType: entityType,
  entityId: entityId,
  facts: facts == null ? null : jsonEncode(facts),
  occurredAt: DateTime.utc(2026, 10, 1, 8),
);

void main() {
  final ar = lookupAppLocalizations(const Locale('ar'));
  final en = lookupAppLocalizations(const Locale('en'));

  setUpAll(() async {
    await initializeDateFormatting('ar');
    await initializeDateFormatting('en');
  });
  setUp(() => AppLocale.apply(AppLanguages.arabic));
  tearDown(() => AppLocale.apply(AppLanguages.english));

  group('locale selection', () {
    test('Arabic maps to ar_DZ with standard date names and French falls back to English', () {
      expect(AppLocale.localeFor('ar'), const Locale('ar', 'DZ'));
      expect(AppLocale.intlLocaleFor('ar'), 'ar');
      expect(AppLanguages.normalize('fr'), 'en');
      expect(AppLanguages.normalize(null), 'en');
      expect(AppLanguages.selectable, isNot(contains('fr')));
    });
  });

  group('Arabic formatting', () {
    test('dates use Arabic names with Latin digits', () {
      final day = DateTime(2026, 10, 1);
      expect(Fmt.weekdayDayMonth(day), 'الخميس، 1 أكتوبر');
      expect(Fmt.dayMonthYear(day), contains('2026'));
      expect(Fmt.monthName(DateTime(2026, 1, 5)), 'يناير');
      expect(Fmt.dayMonthYear(day), isNot(contains('٢')));
    });

    test('money, percent and durations keep Latin digits', () {
      expect(Fmt.money(15000000, 'DZD'), '150,000 دج');
      expect(Fmt.money(500, 'EUR'), '5 EUR');
      expect(Fmt.percent(0.42), '42%');
      expect(Fmt.minutes(45), '45 د');
      expect(Fmt.minutes(90), '1 س 30 د');
      expect(Fmt.timeOfDay(13 * 60 + 5, use24h: false), '1:05 م');
      expect(Fmt.timeOfDay(13 * 60 + 5, use24h: true), '13:05');
      expect(Fmt.compact(2500), '2.5 ألف');
    });

    test('signed values keep their sign beside the number in RTL', () {
      expect(Fmt.signedPercent(-1), '\u2066-100%\u2069');
      expect(Fmt.signedPercent(0), '0%');
      expect(Fmt.money(-5000, 'DZD'), '\u2066-50\u2069 دج');
      AppLocale.apply(AppLanguages.english);
      expect(Fmt.signedPercent(0.12), '+12%');
    });

    test('stored fallback text is always English', () {
      expect(Fmt.inEnglish(() => Fmt.minutes(90)), '1h 30m');
      expect(
        Fmt.inEnglish(() => Fmt.weekdayDayMonth(DateTime(2026, 10, 1))),
        'Thursday, 1 October',
      );
    });

    test('English output is unchanged', () {
      AppLocale.apply(AppLanguages.english);
      expect(Fmt.money(15000000, 'DZD'), '150,000 DZD');
      expect(Fmt.minutes(90), '1h 30m');
      expect(Fmt.timeOfDay(13 * 60 + 5, use24h: false), '1:05 PM');
    });
  });

  group('plurals', () {
    test('Arabic plural forms follow the count', () {
      expect(ar.qtyPages(1, '1'), 'صفحة واحدة');
      expect(ar.qtyPages(2, '2'), 'صفحتان');
      expect(ar.qtyPages(5, '5'), '5 صفحات');
      expect(ar.qtyPages(20, '20'), '20 صفحة');
      expect(ar.goalDaysLeft(11), 'يتبقى 11 يومًا');
      expect(ar.todayActionsLeft(0), 'أنجزت كل شيء');
    });

    test('surah page counts agree with the total', () {
      expect(en.quranPagesOfSurah('½', 1), '½ of 1 page');
      expect(en.quranPagesOfSurah('1½', 2), '1½ of 2 pages');
      expect(ar.quranPagesOfSurah('½', 1), '½ من صفحة واحدة');
      expect(ar.quranPagesOfSurah('1', 2), '1 من صفحتين');
      expect(ar.quranPagesOfSurah('3', 5), '3 من 5 صفحات');
    });
  });

  group('search', () {
    test('Arabic matches ignore diacritics and letter variants', () {
      expect(foldForSearch('إِسْتِثْمَار'), foldForSearch('استثمار'));
      expect(matchesSearch(['المدرسة'], 'مدرسه'), isTrue);
      expect(matchesSearch(['مراجعة المساء'], 'المساء'), isTrue);
      expect(matchesSearch(['مراجعة المساء'], 'الصباح'), isFalse);
    });

    test('English search is case-insensitive', () {
      expect(
        matchesSearch(['Atlas Construction'], 'atlas CONSTRUCTION'),
        isTrue,
      );
    });
  });

  group('bidi', () {
    test('Latin user text is isolated only in the Arabic UI', () {
      expect(bidiSafe('Atlas Construction'), '\u2068Atlas Construction\u2069');
      expect(bidiSafe('حفظ جزء عمّ'), 'حفظ جزء عمّ');
      AppLocale.apply(AppLanguages.english);
      expect(bidiSafe('Atlas Construction'), 'Atlas Construction');
    });
  });

  group('activity text', () {
    test('system rows render from facts in Arabic', () {
      final walk = ActivityText(
        ar,
        _event(
          entityType: 'walk',
          title: 'Walk · 30 min',
          subtitle: '4,000 steps',
          facts: {'minutes': 30, 'steps': 4000},
        ),
      );
      expect(walk.title, 'مشي · 30 د');
      expect(walk.subtitle, '4,000 خطوة');

      final finance = ActivityText(
        ar,
        _event(
          entityType: 'finance',
          title: 'Food',
          subtitle: 'Expense · Food',
          facts: {'type': 'expense', 'category': 'food'},
        ),
      );
      expect(finance.title, 'طعام');
      expect(finance.subtitle, 'مصروف · طعام');

      final night = ActivityText(
        ar,
        _event(
          entityType: 'nightReview',
          title: 'Night review completed',
          subtitle: 'Day rated 4 of 5',
          facts: {'rating': 4},
          type: ActivityType.reviewed,
        ),
      );
      expect(night.title, 'اكتملت مراجعة المساء');
      expect(night.subtitle, 'تقييم اليوم 4 من 5');
    });

    test('user content is never translated', () {
      final finance = ActivityText(
        ar,
        _event(
          entityType: 'finance',
          title: 'Atlas invoice',
          facts: {
            'type': 'income',
            'category': 'Consulting',
            'note': 'Atlas invoice',
          },
        ),
      );
      expect(finance.title, 'Atlas invoice');
      expect(finance.subtitle, 'دخل · \u2068Consulting\u2069');
    });

    test('Arabic and English queries both find a row', () {
      final row = ActivityText(
        ar,
        _event(
          entityType: 'checkin',
          title: 'Morning check-in',
          subtitle: '3 priorities set',
          facts: {'count': 3},
        ),
      );
      expect(row.matches('المراجعه الصباحيه'), isTrue);
      expect(row.matches('morning'), isTrue);
      expect(row.matches('مساء'), isFalse);
      expect(ActivityText(en, row.event).title, 'Morning check-in');
    });

    test('surah labels are shown with Arabic names', () {
      expect(
        localizeSurahLabel('Al-Mulk (Surah 67) · p. 3', arabic: true),
        'سورة الملك · p. 3',
      );
      expect(
        localizeSurahLabel('Al-Mulk (Surah 67)', arabic: false),
        'Al-Mulk (Surah 67)',
      );
    });
  });

  group('catalogue', () {
    Map<String, dynamic> load(String code) =>
        jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
            as Map<String, dynamic>;

    test('Arabic covers every English key', () {
      final enArb = load('en');
      final arArb = load('ar');
      final keys = enArb.keys.where((k) => !k.startsWith('@')).toSet();
      final arKeys = arArb.keys.where((k) => !k.startsWith('@')).toSet();
      expect(keys.difference(arKeys), isEmpty);
      expect(arKeys.difference(keys), isEmpty);
      expect(arArb['appName'], 'تقدّم');
    });

    test('Arabic messages keep every declared placeholder', () {
      final enArb = load('en');
      final arArb = load('ar');
      final metadata = enArb.keys.where(
        (k) => k.startsWith('@') && !k.startsWith('@@'),
      );
      for (final key in metadata) {
        final placeholders =
            ((enArb[key] as Map)['placeholders'] as Map?)?.keys ?? const [];
        final message = arArb[key.substring(1)] as String;
        for (final name in placeholders) {
          if (name == 'count' && !message.contains('{count')) continue;
          final used =
              message.contains('{$name}') || message.contains('{$name,');
          final pluralSelector = RegExp('\\{\\w+, plural').hasMatch(message);
          expect(
            used || pluralSelector,
            isTrue,
            reason: '$key is missing {$name}',
          );
        }
      }
    });
  });
}
