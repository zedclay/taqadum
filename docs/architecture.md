# Taqaddum — Architecture

Taqaddum is a 100% offline, single-device Flutter application. There is no backend, no
cloud SDK, and no runtime network access. All user data lives in a local SQLite database
(Drift) on the device.

## 1. Stack

| Concern | Choice | Why |
| --- | --- | --- |
| UI | Flutter (Material 3, custom theme) | Native widgets reproducing the Stitch design |
| State | `flutter_riverpod` 3 | Reactive providers over Drift streams, no global mutable state |
| Navigation | `go_router` 18 | Declarative routes, `StatefulShellRoute.indexedStack` for tabs |
| Database | `drift` + `drift_flutter` (SQLite) | Typed schema, migrations, reactive `watch()` queries |
| Preferences | `shared_preferences` | Device/UI preferences and session flags |
| Credentials | `flutter_secure_storage` + `crypto` | Salted PBKDF2-HMAC-SHA256 hash in Keychain/Keystore |
| Reminders | `flutter_local_notifications` + `timezone` + `flutter_timezone` | Local scheduled notifications only |
| Charts | `fl_chart` | Progress trends, cash flow |
| Export | `path_provider` + `share_plus` | JSON/CSV written locally, shared via the OS sheet |
| Icons | `material_symbols_icons` | Same Material Symbols glyphs as Stitch, bundled locally |
| Formatting | `intl`, `uuid` | Dates, numbers, IDs |
| i18n | `flutter_localizations` + ARB (`gen-l10n`) | English and Arabic (`ar_DZ`, RTL) complete; French disabled until finished. See `docs/arabic_localization_review.md` |

## 2. Folder structure

```
lib/
  main.dart                     entry → bootstrap()
  app/
    app.dart                    MaterialApp.router, theme, locale
    bootstrap.dart              initializes prefs, DB, timezone, notifications
  core/
    database/                   Drift tables, AppDatabase, migrations
    domain/                     shared enums/value types (LifeArea, day keys, periods)
    localization/               BuildContext.l10n extension, AppLanguages / AppLocale
    routing/                    AppRoutes, router, shell scaffold, redirect logic
    services/                   notifications, credentials, password hashing, export, clock
    theme/                      app_colors, app_typography, app_spacing, app_radius, app_motion, app_theme
    utilities/                  formatters, date helpers
    widgets/                    shared design-system components
    providers.dart              core providers (database, preferences, clock)
  features/
    splash/  auth/  onboarding/  today/  goals/  quran/  work/  finance/
    health/  learning/  progress/  reviews/  history/  notifications/  profile/  settings/
      data/                     repositories (the only layer touching Drift)
      domain/                   pure calculations and typed view models (unit-tested)
      presentation/             screens, sheets, feature widgets, providers
  l10n/                         app_en.arb, app_ar.arb, app_fr.arb (+ generated code)
```

## 3. Navigation

`GoRouter` with a root navigator and a `StatefulShellRoute.indexedStack` holding four
branches. The shell renders the single `AppBottomNavigation` (Today · Progress · + · Goals ·
Profile). The center **+** opens the Quick Add bottom sheet — it is not a destination.

| Branch | Routes (bottom nav visible) |
| --- | --- |
| Today | `/today`, `/today/plan`, `/quran`, `/work`, `/finance`, `/health`, `/learning` |
| Progress | `/progress`, `/progress/calendar`, `/activity?date=yyyy-MM-dd` |
| Goals | `/goals`, `/goals/:goalId` |
| Profile | `/profile` |

Full-screen routes on the root navigator (no bottom nav):
`/splash`, `/auth`, `/onboarding`, `/goal-setup` (onboarding), `/goals/new`,
`/goals/:goalId/edit`, `/today/morning-checkin`, `/today/night-review`,
`/progress/weekly-review`, `/progress/monthly-review`, `/notifications`, `/settings`.

Launch decision (`LaunchDecider`, unit-tested) runs on `/splash`:

```
no local account                     → /auth (Create Account tab)
account, no active session           → /auth (Sign In tab)
session, onboarding incomplete       → /onboarding
session, onboarding done, setup open → /goal-setup
otherwise                            → /today
```

A router `redirect` protects all app routes: without a session every route resolves to
`/auth`.

## 4. Database model (Drift, schema v2)

Day-bound records use a `dayKey` string (`yyyy-MM-dd`, local calendar day). Moments use UTC
`DateTime` columns and are rendered in the device timezone. Money is stored as integer minor
units (`amountMinor`, ×100) to avoid floating point errors. IDs are UUID v4 strings.

| Table | Purpose / key columns |
| --- | --- |
| `user_profiles` | Single local user: name, email, role, intention, avatar color, createdAt |
| `goals` | title, description, area, type (target/routine/milestone), unit, targetValue, startValue, periodTarget, frequency, targetDate, why, status (active/paused/completed/archived), isPrimary |
| `goal_actions` | goalId → actions that move a goal (frequency, lastCompletedAt) |
| `goal_milestones` | goalId → ordered milestones with completedAt |
| `goal_progress_events` | goalId, delta, note, source (manual/quran/finance/work/learning/health), sourceId, occurredAt |
| `tasks` | dayKey, title, area, goalId?, scheduledMinute?, durationMinutes?, badge, priorityRank (1–3), completedAt, sortOrder |
| `morning_checkins` | dayKey PK, energy, capacity, intention |
| `night_reviews` | dayKey PK, rating 1–5, tags + notes for "went well" / "better", biggestWin |
| `quran_logs` | kind (reading/memorization/revision), pages, minutes, surah, occurredAt, goalId? |
| `work_activities` | kind (deepWork/lead/followUp/meeting/proposal/clientWon), title, counterpart, valueMinor, minutes, scheduledAt, occurredAt, goalId? |
| `finance_transactions` | type (income/expense/saving), amountMinor, category (stable id such as `clientPayment` for built-ins, or the user's own text), note, tag (personal/business), occurredAt, goalId? |
| `habits` / `habit_logs` | Habit definitions (area, label, templateId for built-in starter habits, reminderMinute) and one log per habit per dayKey |
| `workout_logs`, `walking_logs`, `sleep_logs` | Manual health tracking |
| `learning_resources` / `learning_sessions` | Resources with unit progress; sessions with minutes, takeaway, applied action |
| `notes` | Quick Add notes |
| `weekly_reviews` | weekStart dayKey PK, reflections (tags + notes), biggest win, next-week priorities (JSON), completedAt |
| `monthly_reviews` | monthKey PK (`yyyy-MM`), three reflection questions, lesson, priorities (JSON), completedAt |
| `reminders` | id (stable key), kind, enabled, minuteOfDay, weekdays mask, habitId? |
| `activity_events` | Unified history: area, type, title, subtitle (English fallback), facts (JSON used to render system rows in the active language), amountMinor, entityType/entityId, occurredAt |
| `app_settings` | key/value for user-domain settings (focus areas, pace, learning focus, quiet hours) |

Relationships: goals ⟶ actions / milestones / progress events (cascade delete). Tasks,
Quran logs, work activities, finance transactions, workouts and learning sessions may
reference a goal. When a log references a goal, the repository writes the log, the matching
`goal_progress_events` row and the `activity_events` row **in one transaction**.

Derived, never stored: goal percentage, today's completion, weekly/monthly totals, area
consistency, active days, calendar day strength, finance totals, study totals.

Migrations: `schemaVersion = 2`. `onCreate` builds tables + indexes. `onUpgrade` from v1
adds `habits.templateId` and `activity_events.facts`, then `LegacyTextMigration` (one
transaction) maps English starter habits and built-in finance categories to stable ids and
backfills facts from the source rows. User-written text is never rewritten.

## 5. State management

- **Repository providers** (`Provider<XRepository>`) wrap `AppDatabase`.
- **Stream providers** expose Drift `watch()` queries (`goalsProvider`,
  `tasksForDayProvider(dayKey)`, `transactionsInRangeProvider(range)` …). Any write
  re-emits dependent streams, so adding a saving updates Finance, Goals, Goal Detail,
  Progress and Monthly Review automatically.
- **Derived providers** combine streams through pure domain calculators
  (`GoalProgressCalculator`, `TodaySummary`, `FinanceStats`, `QuranStats`,
  `ProgressCalculator`, `PeriodRange`). These are unit-tested without Flutter.
- **Screen/form state** is local (`StatefulWidget`/`Notifier`) and never persisted until
  the user saves.
- **Preferences** (`PreferencesController`, a `Notifier`) expose language, week start,
  currency, time format, reduce motion. Changing the language re-applies `AppLocale`
  (Intl locale, Latin digits) and the Arabic or Latin type scale, rebuilds the tree and
  reschedules reminders in the new language; no stored data changes.

## 6. Offline strategy

- No network packages; no `INTERNET` permission in the Android release manifest.
- Fonts, logo, photo and icons are bundled assets.
- Authentication is a local device account: PBKDF2 (SHA-256, random 16-byte salt) hash in
  secure storage; plaintext is never stored. "Continue on this device" creates a
  passwordless local profile.
- Reminders are scheduled locally for the next 7 days and rescheduled on launch and after
  relevant logs. Reminders for work already done today are skipped (smart suppression);
  reminders inside quiet hours are not scheduled.
- Export writes JSON (+ CSV for transactions and activity) to the app documents folder and
  hands the files to the OS share sheet. Nothing is uploaded.
- Delete account wipes all tables, preferences, credentials and pending notifications.

## 7. Design system

Tokens live in `lib/core/theme/` (see `docs/design_audit.md`). Screens only reference
tokens and shared widgets from `lib/core/widgets/`. `AppTheme.light()` wires Inter (with
IBM Plex Sans Arabic fallback), input decoration, buttons, sheets and page transitions.

## 8. Demo data

`DemoDataSeeder` (`lib/core/demo/demo_data_seeder.dart`) writes 35 days of realistic
history through the same repositories the UI uses, so every derived statistic is real:
five goals (business revenue as primary, Memorize Juz Amma, Save 600,000 DZD, a
3× weekly workout routine, a negotiation course with milestones), three habits, daily
tasks, check-ins, Quran, work, finance, health and learning logs, tomorrow's plan, an
upcoming meeting and last week's review. Entries later than the current time are never
written, so seeding in the morning does not create future activity.

It runs only when explicitly triggered: `DemoDataSeeder.enabled` is true in debug builds or
with `--dart-define=TAQADDUM_DEMO=true`, and then Settings shows a "Load demo data" row.
Release builds without the define start empty and never seed.

## 9. Testing

Run everything with `flutter test` (119 tests, fully offline).

| Folder | What it covers |
| --- | --- |
| `test/unit/` | Period ranges (week start, trailing, shifting), goal progress and health, goal contributions, progress calculator (day scores, strength bands, summaries, trends), review insights (review week/month choice, movements, wins, gaps, check-in lift), reminder planner (quiet hours, suppression, weekday masks, last-day-of-month, cap), finance/Quran/work stats, Today summary, PBKDF2 vectors and hashing, validators, launch decisions and `guardRoute` |
| `test/data/` | Repositories on an in-memory Drift database: account creation stores only a salted hash, sign-in/out, continue on this device, password setup, delete account wipes everything, goal save/edit/primary, module logs feeding linked goals, task completion contributions, onboarding persistence, demo seeder, JSON/CSV export, persistence across database re-open |
| `test/widget/` | The real app booted on test doubles: every screen with demo data and empty data at 360 px and 430 px and at 1.35× text, bottom navigation and focused flows, first launch → device profile → onboarding → first goal → Today, every Quick Add form, saving a note. Arabic: RTL launch, every screen at 360/430 px and 1.35×, a sweep for leftover English, Arabic onboarding, mixed-script titles, live language switching, and Arabic goldens (`test/widget/goldens/`) |
| `test/unit/arabic_localization_test.dart`, `test/data/localization_test.dart` | Arabic formatting (dates, money, durations, signs), plurals, search folding, bidi isolation, activity text, ARB parity; locale persistence, language switch leaves the database untouched, reminders in the current language, v1 → v2 text migration |

`test/flutter_test_config.dart` loads the bundled Inter and IBM Plex Sans Arabic fonts so
layout tests use real text metrics; any `RenderFlex` overflow fails the suite.
`test/helpers/test_env.dart` wires in-memory SQLite, mock SharedPreferences, an in-memory
credential store, a no-op notification service, a fast password hasher and a fixed clock.
