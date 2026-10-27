# Architecture Decisions

**Phase status:** Accepted for implementation handoff on 2026-10-27.  
**Important distinction:** Architecture and package metadata have been checked; no Flutter build, dependency resolution, analysis, or test has been run by this session. Those are mandatory gates in the implementation phase.

## AD-001 — Supported platforms
**Decision:** Android and iOS only.  
**Reason:** Matches product scope and avoids maintaining irrelevant targets.  
**Guardrail:** CI and documentation must not claim web/desktop support.

## AD-002 — Toolchain baseline
**Decision:** Use Flutter stable 3.47.7 as the implementation baseline and Dart SDK constraint `^3.12.0`; the known target development environment is Dart 3.13.5.  
**Evidence:** Flutter's official changelog lists the 3.47.7 stable hotfix; the selected package versions' published minimum Dart constraints are compatible with Dart 3.12+.  
**Guardrail:** pin the same Flutter SDK in CI. Update the pin only through a deliberate toolchain change accompanied by dependency resolution, analysis, and tests. Before release, confirm the stable channel has not moved and evaluate an available newer stable hotfix.

## AD-003 — State management
**Decision:** Riverpod 3 using Notifier/AsyncNotifier and their providers as appropriate. Do not use StateProvider or StateNotifierProvider for new code.  
**Reason:** explicit state transitions, async state support, and current API direction.  
**Guardrail:** use `ref.mounted` only where provider disposal can occur while awaiting; do not add redundant checks mechanically.

## AD-004 — Navigation
**Decision:** `go_router` for declarative routing. Use `StatefulShellRoute.indexedStack` only if the starter includes multiple persistent navigation tabs; do not add tab architecture solely as a demo.  
**Reason:** route configuration and testable navigation boundaries.  
**Guardrail:** back behavior and directional icons must be tested in RTL and LTR.

## AD-005 — Settings persistence
**Decision:** `shared_preferences` for non-sensitive user preferences only. Keep a small settings repository/controller boundary.  
**Reason:** theme and locale overrides are small, non-sensitive settings.  
**Guardrail:** never store credentials or secrets here. Define fallback/error behavior and test it.

## AD-006 — Models and serialization
**Decision:** manual serialization and copy/equality implementations only where domain models need them. Avoid mandatory code generation by default.  
**Reason:** keep the starter easy to understand and reduce generated-file overhead.  
**Guardrail:** if model count/complexity makes manual code error-prone, revisit with a concrete example and measured tradeoff.

## AD-007 — UI architecture
**Decision:** centralized tokens and theme extensions plus small reusable components. Screens compose shared primitives; do not create a generic design framework beyond demonstrated needs.  
**Reason:** consistency without over-abstraction.  
**Guardrail:** no arbitrary per-screen colors, typography, spacing, or radii.

## AD-008 — Localization
**Decision:** use Flutter's supported localization tooling and generated localization output where appropriate; keep translated strings in localization resources.  
**Reason:** correct locale handling, pluralization support, and maintainable Arabic/English resources.  
**Guardrail:** locale-derived directionality is the source of truth; avoid manually flipping the entire layout.

## AD-009 — Async error handling
**Decision:** represent expected async loading/error/data states explicitly; settings storage failures have a defined safe fallback and observable non-sensitive error path.  
**Reason:** avoid silent failures and false success.  
**Guardrail:** never log secrets or sensitive user data.

## AD-010 — Dependency policy
**Decision:** keep direct dependencies minimal; verify version constraints, platform compatibility, maintenance, and license before adoption.  
**Reason:** reduce supply-chain surface and maintenance cost.  
**Guardrail:** each direct dependency must have a demonstrated purpose. No icon pack, analytics, backend client, DI container, code generation, AI SDK, or monetization SDK without a concrete requirement.

## Approved direct dependency baseline

Versions below were checked against the package metadata on 2026-10-27. This is a metadata compatibility check, not proof that `pub get` has succeeded in the project.

| Package | Constraint | Purpose | Metadata check |
|---|---|---|---|
| `flutter_riverpod` | `^3.4.3` | Flutter integration for Riverpod 3 | Published minimum Dart SDK 3.12 |
| `go_router` | `^18.1.1` | Declarative route configuration | Published minimum Dart SDK 3.12 |
| `shared_preferences` | `^2.5.6` | Non-sensitive appearance/locale preferences | Published minimum Dart SDK 3.11 |
| `flutter_localizations` | Flutter SDK | Supported localization delegates | Must come from the pinned Flutter SDK |
| `intl` | Resolve through Flutter localization setup | Localization formatting when required | Verify the resolved version in `pubspec.lock` |

No additional dependency is approved yet. Use Flutter SDK features when sufficient.

## Source references

- [Flutter official changelog](https://github.com/flutter/flutter/blob/master/CHANGELOG.md) — stable 3.47 release/hotfix history.
- [flutter_riverpod versions on pub.dev](https://pub.dev/packages/flutter_riverpod/versions) — package releases and minimum Dart SDK.
- [go_router versions on pub.dev](https://pub.dev/packages/go_router/versions) — package releases and minimum Dart SDK.
- [shared_preferences versions on pub.dev](https://pub.dev/packages/shared_preferences/versions) — package releases and minimum Dart SDK.
- [Flutter SDK archive](https://docs.flutter.dev/install/archive) — SDK releases.

## AD-011 — Quality gates
**Decision:** CI runs formatting validation, static analysis, and automated tests on pull requests.  
**Reason:** prevent regressions and make acceptance repeatable.  
**Guardrail:** do not claim a check passed unless the relevant workflow or command result is available.

## Implementation entry gate

Architecture is accepted for implementation because target platforms, state management, navigation, persistence, localization, UI composition, dependency baseline, and quality policy are now explicit and supported by current package metadata.

The first implementation commit must add the Flutter project source and CI. The implementation phase must then prove actual dependency resolution, formatting, analysis, and tests. If a published package cannot resolve against Flutter 3.47.7/Dart 3.13.5, stop and amend this decision with evidence rather than guessing.
