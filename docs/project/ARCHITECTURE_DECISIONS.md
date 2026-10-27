# Architecture Decisions

These are the approved starting decisions. They remain subject to compatibility checks in the actual Flutter environment; any change must include a reason and update this record.

## AD-001 — Supported platforms
**Decision:** Android and iOS only.  
**Reason:** Matches product scope and avoids maintaining irrelevant targets.  
**Guardrail:** CI and documentation must not claim web/desktop support.

## AD-002 — State management
**Decision:** Riverpod 3 using Notifier/AsyncNotifier and their providers as appropriate. Do not use StateProvider or StateNotifierProvider for new code.  
**Reason:** explicit state transitions, async state support, and current API direction.  
**Guardrail:** use ref.mounted only where provider disposal can occur while awaiting; do not add redundant checks mechanically.

## AD-003 — Navigation
**Decision:** go_router for declarative routing. Use StatefulShellRoute.indexedStack only if the starter includes multiple persistent navigation tabs; do not add tab architecture solely as a demo.  
**Reason:** typed, testable route configuration and clear deep-link/navigation boundaries.  
**Guardrail:** back behavior and directional icons must be tested in RTL and LTR.

## AD-004 — Settings persistence
**Decision:** shared_preferences for non-sensitive user preferences only. Keep a small settings repository/controller boundary.  
**Reason:** theme and locale overrides are small, non-sensitive settings.  
**Guardrail:** never store credentials or secrets here. Define fallback/error behavior and test it.

## AD-005 — Models and serialization
**Decision:** manual serialization and copy/equality implementations where domain models need them. Avoid mandatory code generation by default.  
**Reason:** keep the starter easy to understand and reduce generated-file overhead.  
**Guardrail:** if model count/complexity makes manual code error-prone, revisit with a concrete example and measured tradeoff.

## AD-006 — UI architecture
**Decision:** centralized tokens and theme extensions plus small reusable components. Screens compose shared primitives; do not create a generic design framework beyond demonstrated needs.  
**Reason:** consistency without over-abstraction.  
**Guardrail:** no arbitrary per-screen colors, typography, spacing, or radii.

## AD-007 — Localization
**Decision:** use Flutter's supported localization tooling and generated localization output where appropriate; keep translated strings in localization resources.  
**Reason:** correct locale handling, pluralization support, and maintainable AR/EN resources.  
**Guardrail:** locale-derived Directionality must be the source of truth; avoid manually flipping the entire layout.

## AD-008 — Async error handling
**Decision:** represent expected async loading/error/data states explicitly; settings storage failures have a defined safe fallback and observable non-sensitive error path.  
**Reason:** avoid silent failures and false success.  
**Guardrail:** never log secrets or user-sensitive data.

## AD-009 — Dependency policy
**Decision:** keep dependencies minimal and pinned by compatible constraints; verify latest stable versions and SDK compatibility before adopting.  
**Reason:** reduce supply-chain surface and maintenance burden.  
**Guardrail:** every direct dependency requires a purpose, license compatibility, and a current compatibility check.

## AD-010 — Quality gates
**Decision:** CI runs formatting validation, static analysis, and automated tests on pull requests.  
**Reason:** prevent regressions and make acceptance repeatable.  
**Guardrail:** do not claim a check passed unless the relevant workflow or command result is available.

## Provisional package set

- Flutter SDK built-ins for Material, navigation primitives where adequate, accessibility semantics, and localization.
- flutter_riverpod / Riverpod 3 for state.
- go_router for navigation if confirmed necessary by the implemented route structure.
- shared_preferences for non-sensitive appearance/locale overrides.
- flutter_localizations and intl where required by Flutter localization setup.

No package version is considered verified until dependency resolution and CI confirm it for the selected Flutter stable SDK. Avoid adding icon packs, analytics, backend clients, DI containers, code-generation packages, or animation packages without a concrete requirement.
