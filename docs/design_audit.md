# Taqaddum — Design Audit

Source: `design_reference/stitch_taqaddum_design_system_foundation/` (24 screens, each with
`screen.png` + `code.html`) and `calm_progress_operating_system/DESIGN.md`.

Priority when sources disagree: `screen.png` → `DESIGN.md` → `code.html` → canonical tokens
below. The Stitch HTML uses auto-generated Material 3 tokens (`primary #a93100`,
`surface-container-* #e1e8fd…`) that drift from the brand; they were **not** copied.

## 1. Remote dependencies found in the Stitch export

| Dependency | Where | Resolution |
| --- | --- | --- |
| `cdn.tailwindcss.com` | all 24 HTML files | Not used. UI rebuilt natively in Flutter. |
| Google Fonts — Inter | 20 files | Bundled: `assets/fonts/Inter-{Regular,Medium,SemiBold,Bold}.ttf` (OFL). |
| Google Fonts — IBM Plex Sans Arabic | 3 files | Bundled: `assets/fonts/IBMPlexSansArabic-*.ttf` (OFL), registered as fallback family. |
| Material Symbols Outlined (CDN font) | all files | `material_symbols_icons` package — ships the Symbols font inside the app, tree-shaken in release. Same glyph names as Stitch. |
| `lh3.googleusercontent.com/aida-public/AB6AXuD…` (logo) | 01 Splash, 02 Auth | Downloaded once → `assets/brand/taqaddum_logo.png` (512×341, unmodified). |
| `lh3.googleusercontent.com/aida/AEtjO1V…` (logo, header) | 04, 06, 09, 21 | Byte-identical to the logo above (same MD5) — reuses `taqaddum_logo.png`. |
| `lh3.googleusercontent.com/aida-public/AB6AXuAK2…` (photo) | 20 Monthly Review | Downloaded once → `assets/images/monthly_cadence.jpg`. |

Result: zero runtime network dependencies. Android release manifest has no `INTERNET`
permission.

## 2. Canonical tokens (implemented in `lib/core/theme/`)

### Colors — `app_colors.dart`

| Token | Hex | Usage |
| --- | --- | --- |
| background | `#F7F8FA` | Scaffold canvas |
| surface | `#FFFFFF` | Cards, sheets, nav bar |
| surfaceMuted | `#F2F4F7` | Progress tracks, segmented rails, neutral chips, secondary buttons |
| textPrimary | `#101828` | Headings, KPIs |
| textBody | `#344054` | Long-form body copy (DESIGN.md "Text Secondary") |
| textSecondary | `#667085` | Subtitles, metadata |
| textMuted | `#98A2B3` | Inactive nav, placeholders, disabled |
| border | `#EAECF0` | 1px card/input borders, dividers |
| borderStrong | `#D0D5DD` | Unchecked checkbox ring, pressed borders |
| brand | `#F85D27` | Active nav, FAB, brand accents, Work domain |
| primaryStrong | `#D94A18` | Primary CTA, main progress fill |
| brandSoft | `#FFF1EB` | Selected tiles, primary chips |
| success / warning / danger / info | `#16A34A` `#D97706` `#DC2626` `#2563EB` | Semantic status |
| quran / quranSoft | `#10B981` / `#ECFDF5` | Quran & Faith |
| work / workSoft | `#F85D27` / `#FFF1EB` | Work |
| finance / financeSoft | `#2563EB` / `#EFF6FF` | Finance |
| health / healthSoft | `#E11D48` / `#FFF1F2` | Health & Habits |
| learning / learningSoft | `#7C3AED` / `#F5F3FF` | Learning |
| personal / personalSoft | `#D97706` / `#FFFBEB` | Personal life |

### Typography — `app_typography.dart` (Inter, bundled; tabular figures on numeric styles)

| Style | Size / line / weight | Stitch equivalent |
| --- | --- | --- |
| display | 32 / 38 / 700 | `display` — KPI (74%, 1,850,000) |
| pageTitle | 28 / 34 / 700 | `headline-1` — screen titles |
| headline | 22 / 28 / 600 | `headline-2` — Today greeting, hero titles |
| sectionTitle | 18 / 24 / 600 | `headline-3` — section headings |
| cardTitle | 16 / 22 / 600 | card headings |
| bodyLarge | 16 / 24 / 400 | inputs, long text |
| body | 14 / 20 / 400 | secondary copy |
| bodyMedium | 14 / 20 / 500 | row labels |
| label | 12 / 16 / 600 | `label-strong` |
| caption | 12 / 16 / 400 | metadata |
| captionSmall | 11 / 14 / 500 | chips, badges |

### Spacing — `app_spacing.dart`
4-pt scale: 4, 8, 12, 16, 20, 24, 28, 32. Screen horizontal padding 20. Card padding 16,
hero card padding 20. Section gap 28.

### Radius — `app_radius.dart`
sm 8 (chips, number badges) · md 12 (rows, compact tiles) · input 14 · button 16 · card 16 ·
hero 20 · sheet 24 (top corners) · pill 999.

### Elevation
Cards: white, 1px `border`, very soft shadow `0 1 2 rgba(16,24,40,.04)` (Stitch `shadow-sm`).
FAB: brand shadow `0 8 20 -2 rgba(248,93,39,.35)` (DESIGN.md). Sheets: 24px top radius,
DESIGN.md modal shadow.

### Motion — `app_motion.dart`
Small state 180ms · page 240ms · progress 260ms · sheet 250ms. All collapse to zero when the
user enables **Reduce motion** in Settings.

## 3. Repeated UI patterns → shared components (`lib/core/widgets/`)

| Pattern (seen in) | Component |
| --- | --- |
| Bottom nav with raised center + (05, 07, 10–18, 21, 23) | `AppBottomNavigation` (single instance inside the shell) |
| Orange full-width CTA 56px (03, 04, 06, 09, 19, 20) | `PrimaryButton` |
| Neutral/outline buttons, "Skip", "Save for later" | `SecondaryButton`, `AppTextButton` |
| Destructive (24 Delete account) | `DestructiveButton` |
| Labelled inputs (02, 04, 08) | `AppTextField` |
| Rounded progress bars (everywhere) | `AppProgressBar` |
| Section title + trailing meta/action | `SectionHeader` |
| Domain chips with dot (05, 07, 15, 21) | `CategoryChip` |
| Status pills ("On track", "Needs attention", "Done") | `StatusChip` |
| Checkable action rows (05, 07, 14, 18) | `TaskRow` |
| History rows with icon tile + time (10, 14, 21) | `ActivityRow` |
| Goal card with chips, value, bar, next action (15, 17, 20) | `GoalProgressRow` |
| Transaction rows (12) | `TransactionRow` |
| Settings / profile list rows (22, 23, 24) | `SettingsRow`, `SettingsGroup` |
| Bottom sheets (08, 10, 21, 02 reset) | `AppBottomSheet` / `showAppSheet` |
| Empty results (21) | `EmptyState` |
| Week/Month/Year and This/Last month segmented controls (12, 17, 11) | `PeriodSelector` / `SegmentedPills` |
| White rounded card container | `AppCard` |
| Colored icon tile | `IconTile` |
| Focused-flow header with back + title (06, 09, 19, 20) | `FocusedHeader` |
| Toggle rows (22) | `AppSwitch` inside `SettingsRow` |
| Selectable pill tags (09, 19, 20) | `ChoiceTag` |
| Insight callout (05, 11, 17) | `InsightCard` |

## 4. Intentional differences from Stitch

1. **Header copy errors fixed.** Stitch 06 Morning Check-in and 09 Night Review headers read
   "Set Up Your Goals (إعداد أهدافك)"; 24 Settings header reads "Notifications". They are
   titled *Morning Check-in*, *Night Review* and *Settings*.
2. **Google sign-in replaced.** "Continue with Google" cannot work offline. The same button slot
   (same shape and position under "OR CONTINUE WITH") becomes **Continue on this device** —
   a passwordless local profile. No fake Google button.
3. **Password reset is honest.** Stitch shows "Send Link". With no server, the sheet explains
   the password cannot be recovered remotely and offers to erase the on-device account and
   start again (with confirmation).
4. **Lavender tints normalized.** Stitch's generated `surface-container-*` lavender/blue tints
   (`#f1f3ff`, `#e1e8fd`) on chips, tiles and secondary buttons are rendered with neutral
   `surfaceMuted #F2F4F7` or the relevant domain soft color, per DESIGN.md.
5. **Progress fill color.** Stitch's `primary #a93100` (dark rust) fills map to
   `primaryStrong #D94A18`; life-area bars use their domain color instead of Stitch's
   arbitrary grays/blacks (e.g. Personal Finance bar was `inverse-surface`).
6. **No "Pro" badge** on the Settings account card — there is no subscription.
7. **"Streak +1" / streak flames removed** from the Activity detail sheet and Quran screens —
   the brief forbids gamifying religion. Consistency is expressed as active days.
8. **Religious quote removed from onboarding summary.** The Arabic saying in Stitch 03 step 4
   is replaced by a neutral line, per "no fake religious quotations".
9. **Statistics are real.** Every number in the screenshots (74%, 1,850,000 DZD, 24/31 active
   days…) is computed from the local database. The screenshot values only exist in the
   optional development `DemoDataSeeder`.
10. **Bilingual inline labels.** Stitch mixes English with small Arabic sub-labels. The app
    renders one language at a time through Flutter localization (English complete;
    Arabic/French architecture ready), which is also what makes true RTL possible.
11. **Status bar mockups** (`9:41`, signal icons) in the PNGs are device chrome, not UI.
12. **Appearance.** Only the light theme is designed in Stitch. Appearance shows Light as the
    active option with an honest note that a dark theme is planned.
13. **Avatar.** Profile uses local initials on a tinted circle (no camera/gallery permission
    in V1); the camera badge opens the edit-profile sheet.
14. **Activity History nav highlight.** Stitch 21 highlights *Progress* in the bottom bar; the
    route lives in the Progress branch to match.
15. **Monthly Review photo** is kept as a local asset with a gradient overlay, as in Stitch.
