# Taqaddum

A calm, fully offline personal progress system for Quran, work, finance, health, learning
and personal goals. Built natively in Flutter from the Google Stitch design reference in
`design_reference/`.

- **Offline by design.** No backend, cloud SDK, analytics or runtime network access. All
  data lives in a local SQLite database on the device.
- **One local account.** Create an account with a password (stored only as a salted
  PBKDF2-HMAC-SHA256 hash in the platform secure storage) or continue on this device
  without one.
- **Everything is derived.** Goal progress, consistency, calendars, reviews and module
  statistics are computed from the records you log.

## Screens

24 screens mapped one-to-one to the Stitch reference: splash, auth, onboarding, goal setup
and editor, Today, morning check-in, daily plan, Quick Add, night review, Quran, Work,
Finance, Health & habits, Learning, Goals, goal detail, Progress, progress calendar, weekly
review, monthly review, activity history, notifications, profile and settings. See
[`docs/screen_mapping.md`](docs/screen_mapping.md).

Bottom navigation: **Today · Progress · + · Goals · Profile**. The **+** opens Quick Add;
focused flows (auth, onboarding, check-in, night review, reviews, goal editor, settings,
notifications) hide the bar.

## Requirements

- Flutter 3.47 / Dart 3.13 or newer
- Xcode 16+ for iOS (deployment target iOS 15), Android SDK for Android

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # Drift code
flutter gen-l10n                                           # localization code
flutter run
```

### Demo data

Debug builds show **Settings → Developer → Load demo data**, which writes 35 days of
realistic history through the normal repositories. To enable the same row in a profile or
release build, pass:

```bash
flutter run --release --dart-define=TAQADDUM_DEMO=true
```

Without that flag, release builds start empty and never seed data.

## Quality checks

```bash
dart format .
flutter analyze
flutter test
flutter build apk --debug
flutter build ios --simulator
```

The test suite runs fully offline: unit tests for the domain calculators, repository tests
on an in-memory database, and widget tests that boot the real app at 360 px and 430 px
widths and at 1.35× text size. See [`docs/architecture.md`](docs/architecture.md#9-testing).

## Project layout

```
lib/
  app/        bootstrap and MaterialApp
  core/       database, domain types, routing, services, theme tokens, shared widgets
  features/   one folder per area: data (repositories), domain (pure logic), presentation
  l10n/       ARB files (English complete; Arabic and French partial, falling back to English)
test/         unit, data and widget tests
docs/         architecture, design audit, screen mapping
design_reference/   Stitch export (reference only — never shipped as UI)
```

## Privacy

Nothing leaves the device unless you export it. **Export my data** (on Profile or in
Settings) writes JSON (all tables) or CSV (transactions and activity) and hands the
file to the system share sheet. **Log out** keeps your data; **Delete account** erases every
record, preference, credential and scheduled reminder.
