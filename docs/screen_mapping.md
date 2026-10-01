# Taqaddum — Screen Mapping

| # | Stitch screen | Flutter widget | Route | Feature folder | Major interactions |
| --- | --- | --- | --- | --- | --- |
| 01 | `01_splash` | `SplashScreen` | `/splash` | `features/splash` | Logo + tagline, runs `LaunchDecider`, redirects |
| 02 | `02_auth` | `AuthScreen` (+ `ResetPasswordSheet`, `DeviceProfileSheet`) | `/auth` | `features/auth` | Sign In / Create Account tabs, validation, password visibility, Remember me, honest local reset, Continue on this device |
| 03 | `03_onboarding` | `OnboardingScreen` (4 steps) | `/onboarding` | `features/onboarding` | Step X of 4 + progress, focus areas, starter targets (become habits), day pace + checkpoints (become reminders), summary, Skip |
| 04 | `04_goal_setup` | `GoalEditorScreen` | `/goal-setup`, `/goals/new`, `/goals/:goalId/edit` | `features/goals` | Title, area, type (Target/Routine/Milestone), target/start/unit, frequency, date picker, why, linked actions, milestones, Save & Continue / Save for later |
| 05 | `05_today` | `TodayScreen` | `/today` | `features/today` | Greeting/date, momentum hero, Top 3 focus, task toggle, add action, life-area progress, insight, review prompt, module shortcuts |
| 06 | `06_morning_checkin` | `MorningCheckInScreen` | `/today/morning-checkin` | `features/today` | Energy, choose up to 3 priorities, custom priority, capacity, intention, Start My Day |
| 07 | `07_daily_plan` | `DailyPlanScreen` (+ `RescheduleSheet`) | `/today/plan` | `features/today` | Date strip, load summary, priorities, Morning/Afternoon/Evening/Anytime groups, toggle, reschedule, add |
| 08 | `08_quick_add` | `QuickAddSheet` (modal) | — (center + button) | `features/today/presentation/quick_add` | Six types; the same sheet switches to Task / Quran / Money / Work / Habit / Note forms; suggestions |
| 09 | `09_night_review` | `NightReviewScreen` | `/today/night-review` | `features/today` | Rating 1–5, summary, tags + notes, unfinished → Tomorrow, tomorrow at a glance, Complete Day |
| 10 | `10_quran` | `QuranScreen` (+ `QuranLogSheet`) | `/quran` | `features/quran` | Daily routine, memorization, year goal, revision items, 30-day consistency, week stats, recent activity, log |
| 11 | `11_work` | `WorkScreen` (+ `WorkLogSheet`) | `/work` | `features/work` | Momentum (deep work/leads/follow-ups/meetings), quick actions, focus logs, sales activity week/month, active leads, meetings, business goals |
| 12 | `12_finance` | `FinanceScreen` (+ `TransactionSheet`) | `/finance` | `features/finance` | Net surplus period switch, income/expense/saving, cash flow chart, spending categories, savings goal, filtered transactions |
| 13 | `13_health_habits` | `HealthScreen` (+ workout/walk/sleep/habit sheets) | `/health` | `features/health` | Movement today, log workout/walk/sleep, habits toggle, health goals, 7-day activity |
| 14 | `14_learning` | `LearningScreen` (+ session/resource/focus sheets) | `/learning` | `features/learning` | Study today, focus skill, applied actions, sessions, goals, resources progress, weekly totals |
| 15 | `15_goals` | `GoalsScreen` | `/goals` | `features/goals` | Status filter, primary focus card, next action, log progress, all goals, completed archive, New goal |
| 16 | `16_goal_detail` | `GoalDetailScreen` (+ `LogProgressSheet`) | `/goals/:goalId` | `features/goals` | Trajectory, log progress, next action, actions, milestones, history chart, why; menu: edit / pause / complete / archive / primary |
| 17 | `17_progress` | `ProgressScreen` | `/progress` | `features/progress` | Week/Month/Year, overall consistency, trend chart, life areas, strongest/attention, consistency grid, active goals, review prompts |
| 18 | `18_progress_calendar` | `ProgressCalendarScreen` | `/progress/calendar` | `features/progress` | Month navigation, area filter, day states, selected-day summary, View full day → Activity |
| 19 | `19_weekly_review` | `WeeklyReviewScreen` | `/progress/weekly-review` | `features/reviews` | Generated week summary, life areas, biggest win, carried over, reflection tags/notes, next-week priorities, complete |
| 20 | `20_monthly_review` | `MonthlyReviewScreen` | `/progress/monthly-review` | `features/reviews` | Month summary, areas, insights, goals, category snapshots, wins, 3 reflection questions, next-month priorities |
| 21 | `21_activity_history` | `ActivityScreen` (+ detail sheet) | `/activity?date=` | `features/history` | Search, area/review chips, day/week/month/last month/year/all range, summary, grouped by day, detail sheet with Open, empty state |
| 22 | `22_notifications` | `NotificationsScreen` | `/notifications` | `features/notifications` | Master switch, per-reminder toggles and times, weekdays, quiet hours, smart suppression, permission status |
| 23 | `23_profile` | `ProfileScreen` (+ `EditProfileSheet`) | `/profile` | `features/profile` | Identity, primary focus, year progress, life areas, intention, shortcuts, export |
| 24 | `24_settings` | `SettingsScreen` | `/settings` | `features/settings` | Language (Arabic/French marked preview), reduce motion, week start, currency, time format, notifications, life areas, primary focus, history, export, privacy, account, help, about, licenses, log out, delete; debug-only demo data row |
