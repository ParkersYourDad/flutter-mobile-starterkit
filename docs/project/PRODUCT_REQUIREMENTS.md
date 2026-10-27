# Product Requirements

Status legend: **Required** = must ship in the foundation; **Deferred** = deliberately out of scope unless a later product decision changes it.

## Product intent

Provide a clean, reusable Flutter mobile foundation that developers can understand quickly, customize safely, and extend without inheriting unnecessary complexity.

## Scope and non-goals

### In scope
- Android and iOS only.
- English and Arabic localization with locale-aware directionality.
- Light, dark, and system appearance.
- Centralized design tokens, themes, and reusable controls.
- Navigation foundation, app settings persistence, explicit UI states.
- Accessible interaction patterns, automated tests, CI, and concise docs.

### Out of scope
- Web and desktop targets.
- Backend services, authentication provider integration, analytics, push notifications, AI SDKs, payments/subscriptions, and product-specific business features.
- Fake/demo functionality presented as production-ready.
- Mandatory code generation or abstraction layers without a demonstrated need.

## Requirements and acceptance criteria

### Product and maintainability

| ID | Priority | Requirement | Acceptance criteria | Verification |
|---|---|---|---|---|
| PR-001 | P0 | Mobile-only project | Android and iOS are supported; web/desktop are not presented as supported targets. | Project config and CI matrix |
| PR-002 | P0 | Simple starter experience | A new developer can follow the README to set up and run the app without undocumented steps. | Fresh-checkout setup |
| PR-003 | P0 | No fake features | Every visible interactive control performs its stated action or is explicitly disabled with a reason. | Widget tests and manual walkthrough |
| PR-004 | P0 | Controlled dependencies | Each direct dependency has a documented use; no unused dependency remains. | pubspec review and dependency analysis |
| PR-005 | P1 | Clear extension points | Documentation explains where to add a screen, state, localization key, and shared component. | Documentation acceptance |

### Localization and platform behavior

| ID | Priority | Requirement | Acceptance criteria | Verification |
|---|---|---|---|---|
| PR-010 | P0 | English and Arabic | All starter-owned visible copy is localized; no screen-level user-facing strings are hardcoded. | Localization tests and source search |
| PR-011 | P0 | Correct LTR/RTL | Direction follows active locale; back navigation and directional icons mirror correctly. | Widget tests in both locales |
| PR-012 | P0 | Locale persistence | User-selected locale persists across restart; system/default locale is respected when no override exists. | Settings tests |
| PR-013 | P0 | System locale behavior | Locale can remain system-controlled; changing system locale updates app behavior when no override is selected. | Integration/manual test on device |
| PR-014 | P1 | Long translated strings | Layout remains usable with longer Arabic/English labels and narrow phones. | Widget/golden tests at narrow sizes |

### Appearance and design system

| ID | Priority | Requirement | Acceptance criteria | Verification |
|---|---|---|---|---|
| PR-020 | P0 | Light/Dark/System | All three modes work and are user-selectable; system mode follows platform appearance. | Widget and device tests |
| PR-021 | P0 | Theme persistence | Explicit theme choice persists across restart; system mode is preserved as a distinct setting. | Settings tests |
| PR-022 | P0 | Centralized tokens | Colors, typography, spacing, radii, and motion values live in shared tokens/theme definitions rather than per-screen literals. | Source inspection and tests |
| PR-023 | P0 | Neutral premium visual style | No random accent colors, emoji icons, unnecessary shadows/elevation, or surface tint; consistent open surfaces and subtle dividers. | Targeted golden review |
| PR-024 | P0 | Shared components | Buttons, inputs, cards/surfaces, section headers, loading, empty, and error states have consistent shared APIs and styling. | Widget tests and goldens |
| PR-025 | P1 | Responsive mobile layouts | Content remains readable and controls usable on compact and large phone sizes, including around 480/560/640 logical-pixel widths. | Responsive widget tests |
| PR-026 | P1 | Motion restraint | Transitions are subtle, purposeful, and respect reduced-motion/accessibility expectations where supported. | Targeted behavior tests/manual check |

### Accessibility and interaction

| ID | Priority | Requirement | Acceptance criteria | Verification |
|---|---|---|---|---|
| PR-030 | P0 | Touch targets | Interactive controls meet platform accessibility target guidance or document a justified exception. | Accessibility review |
| PR-031 | P0 | Text scaling | No critical clipping/overlap at enlarged system font sizes. | Widget tests at enlarged text scale |
| PR-032 | P0 | Semantics | Controls expose meaningful labels, roles, and state to screen readers. | Semantics tests |
| PR-033 | P0 | Contrast | Text and essential UI indicators meet WCAG 2.2 AA contrast targets where applicable. | Automated contrast checks and manual review |
| PR-034 | P1 | Keyboard/focus behavior | Focus order and visible focus are sensible wherever a physical keyboard is relevant. | Targeted test/manual check |

### Engineering, reliability, and security

| ID | Priority | Requirement | Acceptance criteria | Verification |
|---|---|---|---|---|
| PR-040 | P0 | State management | New Riverpod code uses Notifier/AsyncNotifier as appropriate; no new StateProvider/StateNotifierProvider. | Analysis and source review |
| PR-041 | P0 | Navigation | Navigation is centralized and tested; secondary screens have correct back behavior and RTL-aware directional presentation. | Router/widget tests |
| PR-042 | P0 | Settings failure behavior | Storage errors do not crash the app silently; user-visible behavior and recovery/fallback are defined. | Unit/widget tests |
| PR-043 | P0 | Async lifecycle safety | Lifecycle checks such as ref.mounted are used where disposal can occur during an await, not mechanically after every await. | Code review and tests |
| PR-044 | P0 | No secret leakage | No credentials, private keys, or real environment secrets are committed; configuration docs use placeholders. | Secret scan and source review |
| PR-045 | P0 | No unsafe logging | No print() calls or sensitive-data logging in production code. | Source check and lint |
| PR-046 | P0 | Automated quality | Formatting, static analysis, unit/widget tests run in CI and failures block acceptance. | GitHub Actions run |
| PR-047 | P1 | Targeted golden tests | Key shared components are covered in Light/Dark variants; snapshots avoid broad, brittle duplication. | Golden test run |
| PR-048 | P1 | Baseline performance | No obvious synchronous heavy work on UI thread or unnecessary rebuild/animation loops in foundation paths. | Profiling and targeted tests |

## Acceptance policy

A requirement is accepted only with evidence appropriate to its type. Written intention is not implementation evidence. If a requirement cannot be verified in the available environment, label it **Unverified** and name the missing environment or action. Do not silently waive P0 requirements.

## Dependencies and decisions

- Flutter/Dart and package versions must be verified against current stable releases and resolved in CI; do not rely on memory alone.
- Prefer Flutter's built-in localization, Material primitives, and platform support when they satisfy the requirement.
- Select IBM Plex Sans Arabic only after confirming the font assets, licensing, Arabic shaping, and app bundling plan.
- Licensing for the repository must be decided before advertising reuse or publishing a release.
