---
name: Calm Progress Operating System
colors:
  surface: '#f9f9ff'
  surface-dim: '#d3daef'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f3ff'
  surface-container: '#e9edff'
  surface-container-high: '#e1e8fd'
  surface-container-highest: '#dce2f7'
  on-surface: '#141b2b'
  on-surface-variant: '#5a4139'
  inverse-surface: '#293040'
  inverse-on-surface: '#edf0ff'
  outline: '#8e7067'
  outline-variant: '#e3bfb4'
  surface-tint: '#ad3300'
  primary: '#a93100'
  on-primary: '#ffffff'
  primary-container: '#d24209'
  on-primary-container: '#fffbff'
  inverse-primary: '#ffb59e'
  secondary: '#ae3203'
  on-secondary: '#ffffff'
  secondary-container: '#fe6a3c'
  on-secondary-container: '#5f1600'
  tertiary: '#645a55'
  on-tertiary: '#ffffff'
  tertiary-container: '#7d726e'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdbd0'
  primary-fixed-dim: '#ffb59e'
  on-primary-fixed: '#3a0b00'
  on-primary-fixed-variant: '#842500'
  secondary-fixed: '#ffdbd1'
  secondary-fixed-dim: '#ffb59f'
  on-secondary-fixed: '#3a0a00'
  on-secondary-fixed-variant: '#862300'
  tertiary-fixed: '#eee0da'
  tertiary-fixed-dim: '#d1c4be'
  on-tertiary-fixed: '#211a17'
  on-tertiary-fixed-variant: '#4e4541'
  background: '#f9f9ff'
  on-background: '#141b2b'
  surface-variant: '#dce2f7'
typography:
  display:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 38px
  headline-1:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
  headline-2:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  headline-3:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-large:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-medium:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
  label-strong:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
  caption:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  caption-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 0.75rem
  margin: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system embodies a calm, intentional, and high-performance Life Operating System. It harmonizes the human-centric simplicity and metric focus of Apple Health (70%) with the sharp utility, modular typography, and structured density of Linear (20%), accented by deliberate editorial craft (10%).

The aesthetic balances clarity, rigor, and emotional reassurance. It rejects frantic gamification, chaotic notifications, and visual noise in favor of mindful momentum—grounded in steady forward movement.

### Core Visual Principles
- **Intentional Restraint:** White and slate surfaces take precedence. Bright, high-energy accents are reserved for active commitments, achievements, and forward trajectory.
- **Bilingual Equilibrium:** Conceived from the ground up for harmonious bidirectional support (Arabic RTL and Latin LTR), ensuring equal visual hierarchy, metric legibility, and baseline alignment.
- **Tactile Utility:** Micro-interactions feel snappy and dependable. Cards act as discrete, organized focus modules without distracting ornamentation.

## Colors

The color palette centers on an energetic primary orange drawn directly from the ascending mark of the visual identity, balanced by a deep obsidian ink neutral and disciplined functional accents.

### Core & Neutral Roles
- **Primary Brand Orange (`#F85D27`):** Primary brand accent, active streaks, progress completion fills, and forward-vector icons.
- **Primary Action Dark Orange (`#C74317`):** Active pressed states, focused interactive elements, and high-contrast badges.
- **Primary Soft (`#FFF0EA`):** Tinted chip fills, subtle selection rings, and background highlights for primary modules.
- **Text Primary (`#111827`):** High-emphasis headings, KPIs, metrics, and core labels.
- **Text Secondary (`#344054`):** Section headers, body content, and standard copy.
- **Text Tertiary (`#667085`):** Subtext, metadata, timestamps, and placeholder copy.
- **Muted Text / Icons (`#98A2B3`):** Inactive indicators, unselected bottom bar items, and disabled states.
- **Border (`#E4E7EC`):** Crisp 1px structural container rules, card boundaries, and dividers.
- **Surface Secondary (`#F2F4F7`):** Segmented control rails, disabled input fields, and pill backgrounds.
- **App Background (`#F9FAFB`):** Soft, non-glare canvas base.
- **Surface (`#FFFFFF`):** High-level elevation containers, cards, and modal sheets.

### Status Semantic System
- **Success:** Text/Icon `#16A34A` | Soft Fill `#ECFDF3`
- **Warning:** Text/Icon `#D97706` | Soft Fill `#FFFAEB`
- **Danger:** Text/Icon `#DC2626` | Soft Fill `#FEF3F2`
- **Info:** Text/Icon `#2563EB` | Soft Fill `#EFF6FF`

### Domain Accents
- **Quran & Spiritual:** `#10B981` (Soft: `#ECFDF5`)
- **Work & Career:** `#F85D27` (Soft: `#FFF0EA`)
- **Finance & Wealth:** `#2563EB` (Soft: `#EFF6FF`)
- **Health & Vitality:** `#E11D48` (Soft: `#FFF1F2`)
- **Learning & Growth:** `#7C3AED` (Soft: `#F5F3FF`)
- **Personal & Family:** `#D97706` (Soft: `#FFFBEB`)

## Typography

Typography relies on a coordinated bilingual framework:
- **Latin & Numerics:** Inter provides neutral clarity, consistent tabular figures (`tnum`) for KPIs and timers, and modern grotesque structure.
- **Arabic Text (RTL):** Pair with `IBM Plex Sans Arabic` across identical optical scale levels. Match weights directly (`400 Regular`, `500 Medium`, `600 SemiBold`, `700 Bold`). Ensure line heights in Arabic support diacritics without clipping by applying an optical line-height expansion of +2px when rendering Arabic script strings.

### Usage Rules
- **Display & Headings:** Use semi-bold and bold weights for progress stats, summary titles, and dashboard headings. Maintain tight line-heights to preserve vertical density.
- **Tabular Data:** All numerical indicators (metrics, completion percentages, counters, prayer times, workout counts) must enable font feature `'tnum'` (tabular figures) to ensure column stability.

## Layout & Spacing

Layout geometry follows an exact 4px structural grid (4, 8, 12, 16, 20, 24, 32, 40, 48, 64px) optimized for handheld mobile reach and glanceable executive summaries.

### Screen Layout Principles
- **Screen Margins:** Fixed 20px (`1.25rem`) horizontal margins on mobile devices to create breathing room around cards.
- **Vertical Hierarchy:** Section headers are spaced 24px (`1.5rem`) apart. Intra-section card stacks sit on an 8px or 12px vertical cadence.
- **Card Padding:** Interior card padding is standardized to 16px (`1rem`), scaling to 20px on hero banner cards.
- **Touch Targets:** Minimum tap target bounds of 44×44px across all buttons, icon triggers, and list items.

### Responsive Behavior
- **Mobile (Base, 360px – 430px):** Single-column layout. Horizontal swipe carousels with peek margins (16px visible next card) for daily ring milestones.
- **Tablet & Large Form Factor (600px+):** Transitions from single-column feed into a 2-column bento-style responsive grid with 16px gutter spacing.

## Elevation & Depth

Visual hierarchy prioritizes structural separation over atmospheric diffusion. Emulating Apple Health’s clean separation and Linear’s structured clarity, surface boundaries rely primarily on crisp 1px borders.

### Depth Rules
- **Base Canvas:** `#F9FAFB` provides a grounded, neutral backdrop.
- **Standard Cards & Modules:** Pure white `#FFFFFF` paired with an explicit `1px solid #E4E7EC` border. Zero drop-shadows under normal resting state.
- **Interactive Hover & Pressed:** Shift border to `#D0D5DD` with subtle scale transition (`transform: scale(0.99)`).
- **Floating Modals & Bottom Sheets:** Used exclusively for contextual flows, action pickers, and creation modals.
  - Border: `1px solid rgba(228, 231, 236, 0.8)`
  - Shadow: `0px 12px 32px -4px rgba(17, 24, 39, 0.08), 0px 4px 12px -2px rgba(17, 24, 39, 0.03)`
- **Elevated FAB (Center Action Item):** Floating quick-entry '+' trigger utilizes an energetic brand drop shadow:
  - Shadow: `0px 8px 20px -2px rgba(248, 93, 39, 0.35)`

## Shapes

The corner radius architecture reinforces a balanced, ergonomic mobile touch experience. 

### Corner Radius Hierarchy
- **Extra Small (4px):** Progress bar ends, tiny badges, metric delta indicators.
- **Small (8px):** Category tag chips, secondary tooltips, compact checkboxes.
- **Input (12px):** Text fields, search bars, dropdown triggers.
- **Button (14px):** Primary, secondary, and tertiary action buttons.
- **Standard Card (16px):** Core task items, habit rows, standard widgets.
- **Large Card / Container (20px):** Hero summary modules, streak insights, prayer/workout trackers.
- **Modal / Bottom Sheet (24px top corners):** Floating slide-over sheets and detail dialogs.
- **Circular (9999px):** Avatar markers, segmented category filter pills, icon badges, and floating action button.

## Components

### Buttons
- **Primary:** High-emphasis action with `#F85D27` background, white `#FFFFFF` text, `14px` border radius, and `12px 20px` internal padding. Active state darkens to `#C74317`.
- **Secondary / Subtle:** `#F2F4F7` background with `#344054` label, no border. Active state transitions to `#E4E7EC`.
- **Outline:** Transparent background, `1px solid #E4E7EC`, `#111827` text.
- **Destructive:** Soft `#FEF3F2` background with `#DC2626` text; primary destructive uses `#DC2626` background with white text.

### Chips & Domain Badges
- Displayed with `8px` or full pill (`9999px`) radius.
- Height is constrained to `28px` for compact tags and `34px` for filter triggers.
- Features paired domain styling (e.g., Quran: `#10B981` text over `#ECFDF5` background; Finance: `#2563EB` text over `#EFF6FF` background).

### Cards & Task Rows
- **Standard Metric Card:** Pure white background, `16px` border radius, `1px solid #E4E7EC` border, and `16px` padding. Contains a title, optional category badge, metric counter, and progress track.
- **Interactive Habit Row:** Checkable circular state toggle on the leading side (supporting LTR and RTL), item title in `Body Medium`, category dot indicator, and subtle drag handle or chevron on the trailing side.

### Checkboxes & Progress Rings
- **Checkboxes:** `20px` rounded square (`6px` radius) with `1.5px solid #D0D5DD`. When selected, transitions to `#F85D27` fill with white checkmark.
- **Metric Radial Rings:** Apple Health-style circular progress indicators with `6px` stroke width, `#F2F4F7` track background, and animated `#F85D27` (or domain accent) rounded cap stroke.

### Input Fields
- `12px` border radius, `1px solid #E4E7EC` border, `#FFFFFF` background, `12px 16px` padding, and `14px` text size.
- Focused state applies an explicit `1px solid #F85D27` border alongside a soft outer ring: `0px 0px 0px 3px rgba(248, 93, 39, 0.12)`.

### Persistent Bottom Navigation Bar
- Grounded fixed bar at bottom with safe-area bottom inset.
- `#FFFFFF` surface with `1px solid #E4E7EC` top divider and subtle backdrop-filter blur.
- 5 items with bidirectional icon layout:
  1. **Today (اليوم):** Calendar check / Home icon.
  2. **Progress (التقدم):** Ascending bar chart icon.
  3. **Add (إضافة):** Elevated circular button (`48px` diameter, `#F85D27` fill, white plus icon, and soft brand shadow).
  4. **Goals (الأهداف):** Bullseye target icon.
  5. **Profile (الحساب):** User silhouette icon.
- Inactive items rendered in `#98A2B3`; active selected tab rendered in `#F85D27` with bold weight caption.