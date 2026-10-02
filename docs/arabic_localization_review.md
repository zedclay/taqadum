# Arabic localization review

Taqaddum ships complete in English and Modern Standard Arabic (`ar_DZ`, right-to-left).
French is listed in the language picker as "coming in a future update" and cannot be
selected. Everything works offline; no translation, font or locale data is downloaded.

## 1. Locale architecture

| Piece | Where | Notes |
| --- | --- | --- |
| Catalogues | `lib/l10n/app_en.arb` (template), `app_ar.arb`, `app_fr.arb` | 1409 messages. Arabic covers every key (checked by `test/unit/arabic_localization_test.dart`). French has 22 keys and is not selectable. |
| Generated code | `lib/l10n/generated/` via `flutter gen-l10n` (`l10n.yaml`) | `nullable-getter: false`; untranslated report in `build/untranslated_messages.json` (French only). |
| Access | `context.l10n` (`lib/core/localization/l10n.dart`) | Outside widgets (reminders): `lookupAppLocalizations(prefs.locale)`. |
| Languages | `AppLanguages` (`lib/core/localization/app_locale.dart`) | `selectable = [en, ar]`; `normalize()` maps unknown or `fr` to `en`. Autonyms (English, العربية, Français) are never translated. |
| Process locale | `AppLocale.apply(code)` | Sets `Intl.defaultLocale` and keeps Latin digits for `ar` date formatting. Used by `Fmt` and `bidiSafe`. |
| Persistence | `PreferencesController.setLocale` → SharedPreferences `pref.locale` | Restored on launch; a change applies immediately. |
| App shell | `TaqaddumApp._applyLanguage` | Applies `AppLocale`, switches the type scale, rebuilds the theme and, after a switch, rebuilds every element once so widgets that read typography statically refresh. |
| Supported locales | `MaterialApp.supportedLocales` | `en`, `ar_DZ`, `ar` with Global Material/Widgets/Cupertino delegates (bundled with Flutter). |

Arabic messages use ICU plurals with all six Arabic categories where a count is shown
(`=0`, `=1`, `=2`, `few` 3–10, `many` 11–99, `other` 100+ and fractions), e.g.
`{n, plural, =1{يتبقى يوم واحد} =2{يتبقى يومان} few{تتبقى {n} أيام} many{يتبقى {n} يومًا} other{يتبقى {n} يوم}}`.
Sentences are complete messages with placeholders, never concatenated fragments.

### System text stored in the database

Version 1 wrote English system text (activity titles, starter habit names, finance
categories) into rows. Schema v2 fixes this without a reset:

- `activity_events.facts` holds JSON (minutes, rating, kind, category…). `ActivityText`
  (`lib/features/history/presentation/activity_text.dart`) renders system rows from facts in
  the active language; `title`/`subtitle` keep an English fallback (`ActivityFallback`) for
  exports and older rows.
- `habits.templateId` marks built-in starter habits (`quran1` … `personal2`); the name is
  localized at display time (`habitDisplayName`). Renaming a habit clears the template.
- Built-in finance categories are stored as stable ids (`food`, `clientPayment`,
  `emergency` …, `FinanceCategories`); custom categories stay as typed.
- Goal units are stable ids (`pages`, `juz`, `hours`, `minutes`, `sessions`, `books`, `km`,
  `times`) or a currency code.
- `LegacyTextMigration` upgrades v1 rows in one transaction and is covered by
  `test/data/localization_test.dart`.

User content (goal titles, notes, names, custom categories, surah portions typed by the user)
is never translated.

## 2. Fonts

| Script | Family | Weights | Source |
| --- | --- | --- | --- |
| Arabic | IBM Plex Sans Arabic | 400, 500, 600, 700 | `assets/fonts/IBMPlexSansArabic-*.ttf` (OFL) |
| Latin | Inter | 400, 500, 600, 700 | `assets/fonts/Inter-*.ttf` (OFL) |

`AppTypography.useArabic(true)` switches every style to IBM Plex Sans Arabic with Inter as
fallback (so Latin user content still renders in Inter) and sets letter spacing to 0, since
tracking breaks Arabic joining. English uses Inter with IBM Plex Sans Arabic as fallback.
No runtime font download (`google_fonts` is not a dependency).

## 3. RTL

- `MaterialApp` locale `ar_DZ` → `Directionality.rtl` for the whole tree.
- Paddings and alignments are directional (`EdgeInsetsDirectional`, `AlignmentDirectional`,
  `start`/`end`); chevrons and back arrows mirror through Material.
- Not mirrored: numbers, percentages, DZD amounts, check marks, play/pause, the logo,
  progress rings and charts (time still runs left to right on chart axes; month labels use
  numbers because Arabic month initials are ambiguous).
- Signed values (`-100%`, `+270 ألف`) are wrapped in a left-to-right isolate so the sign
  stays beside the number.
- User text containing Latin letters is wrapped with `bidiSafe` (first-strong isolate) so
  "Read Atomic Habits (2nd time)." keeps its punctuation in place. Composed labels wrap only
  the user-written piece. Text fields are never wrapped, so isolate marks never reach the
  database; search ignores them.

## 4. Terminology

| English | Arabic |
| --- | --- |
| Taqaddum | تقدّم |
| Today / Progress / Goals / Profile | اليوم / التقدّم / الأهداف / الملف الشخصي |
| Quick Add | إضافة سريعة |
| Morning check-in | المراجعة الصباحية |
| Night review | مراجعة المساء |
| Weekly review / Monthly review | مراجعة الأسبوع / مراجعة الشهر |
| Quran & Faith / Work & Growth / Personal Finance | القرآن والإيمان / العمل والنمو / المال الشخصي |
| Health & Habits / Learning / Personal Life | الصحة والعادات / التعلّم / الحياة الشخصية |
| Short area labels | القرآن / العمل / المال / الصحة / التعلّم / شخصي |
| Target / Routine / Milestone (goal types) | هدف رقمي / روتين / مرحلة |
| Action (goal) / Task (day) | إجراء / مهمة |
| Priority | أولوية |
| Lead / Follow-up / Proposal / Client won | عميل محتمل / متابعة / عرض / عميل جديد |
| Deep work | عمل عميق |
| Reading / Memorization / Revision | القراءة / الحفظ / المراجعة |
| Revision queue | مراجعات اليوم |
| Income / Expense / Saving | دخل / مصروف / ادخار |
| Quiet hours | ساعات الهدوء |
| Preferences / Language / Week starts on | التفضيلات / اللغة / بداية الأسبوع |
| Currency / Time format | العملة / تنسيق الوقت |
| Data & Privacy / Export my data | البيانات والخصوصية / تصدير بياناتي |
| Log out / Delete account | تسجيل الخروج / حذف الحساب |
| Help & FAQ / About Taqaddum | المساعدة والأسئلة الشائعة / حول تقدّم |

Validation and empty states follow the same calm tone, e.g. "هذا الحقل مطلوب.",
"تعذر حفظ التحديث. حاول مرة أخرى.", "يومك خالٍ من المهام حاليًا.".

## 5. Units

| Id | Label | Quantity (1 / 2 / 5 / 20) |
| --- | --- | --- |
| `pages` | صفحات | صفحة واحدة / صفحتان / 5 صفحات / 20 صفحة |
| `juz` | أجزاء | جزء واحد / جزآن / 5 أجزاء / 20 جزءًا |
| `hours` | ساعات | ساعة واحدة / ساعتان / 5 ساعات / 20 ساعة |
| `minutes` | دقائق | دقيقة واحدة / دقيقتان / 5 دقائق / 20 دقيقة |
| `sessions` | جلسات | جلسة واحدة / جلستان / 5 جلسات / 20 جلسة |
| `books` | كتب | كتاب واحد / كتابان / 5 كتب / 20 كتابًا |
| `km` | كم | 5 كم |
| `times` | مرات | مرة واحدة / مرتان / 5 مرات / 20 مرة |

Compact durations: `45 د`, `1 س 30 د`. Compact amounts: `2.5 ألف`, `1.2 مليون`.

## 6. Dates and times

- Formatting goes through `Fmt` (`lib/core/utilities/formatters.dart`) with Arabic patterns,
  e.g. `EEEE، d MMMM` → "الخميس، 1 أكتوبر".
- Dates use the standard Arabic month names (يناير، فبراير، مارس…). Flutter's localizations
  load the generic `ar` date symbols, which `ar_DZ` falls back to.
- Digits are always Latin (`DateFormat.useNativeDigitsByDefaultFor('ar', false)`), including
  in Flutter's date picker.
- 12-hour times use ص / م; 24-hour times are `13:05`.
- The week start comes from the user's setting, not the locale.

## 7. Currency

`Fmt.money` keeps Latin digits with comma grouping and puts the symbol after the amount:
"150,000 دج". Arabic symbols: DZD دج, MAD د.م., TND د.ت., SAR ر.س, AED د.إ, EGP ج.م.
EUR, USD and GBP keep their ISO code. Settings lists currencies as "دينار جزائري (DZD)".

## 8. Notifications

`ReminderScheduler` builds titles, bodies and the Android channel name and description
from the current locale. Any preference change (including language) reschedules: pending
notifications are cancelled, the channel is re-registered (so Android shows the new channel
name) and reminders are recreated in the new language. Examples: "مراجعتك الأسبوعية جاهزة.",
"واصل وردك من القرآن عندما تكون مستعدًا.".

## 9. Intentionally untranslated

| Content | Why |
| --- | --- |
| User content (goal titles, notes, names, custom categories, counterparts) | Belongs to the user; shown with bidi isolation. |
| Demo data from `DemoDataSeeder` | Debug-only sample content, written as if typed by an English-speaking user. |
| English fallback in `activity_events.title/subtitle` | Canonical stored text for exports and older rows; the UI renders facts instead. |
| Language autonyms (English, العربية, Français) and the "عربي / EN" switch on sign-in | Each language is named in its own script. |
| ISO currency codes (DZD in settings, EUR/USD/GBP amounts), JSON / CSV | Standard codes and file formats. |
| Email placeholder `name@example.com`, example company names in hints (Atlas Construction) | Email addresses and brand names are Latin. |
| Open-source license texts (`showLicensePage` content) | Legal texts from package authors. |
| French | Disabled until the catalogue is complete; a stored `fr` falls back to English. |

Platform-provided strings (date picker, time picker, text selection menu, license page
chrome) come from Flutter's bundled Arabic `GlobalMaterialLocalizations`.

## 10. Testing

| File | Covers |
| --- | --- |
| `test/unit/arabic_localization_test.dart` | Locale selection, Arabic dates with Latin digits, money/percent/durations, signs in RTL, English output unchanged, Arabic plurals, Arabic and English search, bidi isolation, activity text from facts, user content kept verbatim, surah names, ARB key and placeholder parity. |
| `test/data/localization_test.dart` | Locale persists and French stays disabled, EN→AR→EN leaves every table unchanged, reminders and channel in Arabic then English, v1 English text migrated to ids and facts. |
| `test/widget/arabic_test.dart` | Launch in `ar_DZ` with RTL and Arabic navigation; every screen plus goal detail and editor at 360 px and 430 px and at 1.35× text; a sweep that fails on any visible English system text across all screens and Quick Add forms; Arabic onboarding and goal setup at 1.35×; a mixed English title; Arabic finance and settings; switching AR→EN→AR from settings. |
| `test/widget/arabic_golden_test.dart` | Golden images of Today, Finance and Settings in Arabic (`test/widget/goldens/`). |

`dart run tool/l10n_audit.dart --strict` fails on hardcoded user-facing literals in
`lib/` (files marked `l10n-ignore-file` hold demo or stored canonical text only).
