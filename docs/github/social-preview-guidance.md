# GitHub repository presentation

Suggested settings for the GitHub repository page. These are applied manually in the
repository settings; nothing in this project changes them automatically.

## About → Description

> Offline-first Flutter personal progress system for goals, habits, Quran, work, finance, health and reflection.

## About → Topics

```
flutter, dart, offline-first, sqlite, drift, riverpod, go-router, productivity,
goal-tracking, habit-tracker, mobile-app, rtl, arabic
```

Leave the website field empty until there is a real project page.

## Social preview image

Settings → General → Social preview. GitHub recommends 1280 × 640 px (PNG or JPG, under
1 MB).

Suggested composition:

- Light background (`#F7F8FA`, the app's background color) with a soft orange accent.
- Left third: `assets/brand/taqaddum_logo.png`, then the title **Taqaddum — تقدّم** and
  the line *Offline-first personal progress system*.
- Right two thirds: three phone screenshots, slightly overlapping:
  `docs/screenshots/01_today.png`, `05_goals.png` and `07_progress.png`
  (`11_today_arabic.png` works well instead of one of them to show RTL support).
- Avoid adding claims that are not true of the project (store badges, download counts,
  ratings).

## Screenshots

`docs/screenshots/` contains real renders of the Flutter app with its built-in demo data
(1170 × 2532 px, 390 × 844 pt at 3×). To regenerate them after UI changes:

```bash
flutter test --update-goldens tool/screenshots/capture_screenshots_test.dart
```

The script lives outside `test/` so the regular `flutter test` run does not overwrite the
images.
