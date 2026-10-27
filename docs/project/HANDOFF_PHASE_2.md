# Handoff — Phase 2: Architecture Decisions

**Status:** Architecture decisions committed to GitHub.  
**Receiver:** Design System & UX, then Flutter Engineering.  
**Evidence:** `docs/project/ARCHITECTURE_DECISIONS.md`, `docs/project/DESIGN_SYSTEM.md`.

## Delivered
- Mobile-only target decision.
- Riverpod 3 Notifier/AsyncNotifier approach.
- go_router decision with conditional use of StatefulShellRoute only if tabs are in scope.
- SharedPreferences limited to non-sensitive preferences.
- Manual model serialization as default; code generation deferred absent concrete need.
- Localization, error handling, dependency policy, and CI quality gates.
- Design tokens, typography, neutral theme rules, component contracts, accessibility and golden-test scope.

## Acceptance gate
These decisions are adequate to start implementation planning and design-system implementation. Package versions and APIs must still be verified against the selected Flutter stable SDK through dependency resolution, analysis, and tests.

## Blockers and risks
- Flutter/Dart toolchain has not been executed in this session.
- No actual app source, tests, or CI workflow has been committed yet.
- Font licensing and bundled font files remain to be verified.
- License for the repository remains undecided.

## Handoff rule
Do not represent the architecture or design system as implemented merely because these specifications exist. Implementation and automated verification remain mandatory.
