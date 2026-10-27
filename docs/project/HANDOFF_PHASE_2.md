# Handoff — Phase 2: Architecture Decisions

**Status: ACCEPTED.**  
**Original phase closure:** 2026-10-27  
**Receiver:** Design Systems & UX (Stage 3).  
**Evidence:** [Architecture Decisions](ARCHITECTURE_DECISIONS.md), [Execution Plan](EXECUTION_PLAN.md).

## Delivered and accepted
- Android/iOS-only product target.
- Riverpod 3 with Notifier/AsyncNotifier; go_router for actual route needs; shared_preferences limited to non-sensitive preferences.
- Manual model serialization by default; no code generation without a demonstrated need.
- Localization and directionality strategy, safe settings persistence/error handling, centralized UI architecture, dependency policy, and CI acceptance.

## Metadata validation
- Selected `flutter_riverpod ^3.4.3`, `go_router ^18.1.1`, and `shared_preferences ^2.5.6` were checked against current pub.dev version metadata and minimum Dart constraints on 2026-10-27.
- Flutter SDK localization support is used rather than a third-party localization package.

## Post-handoff runtime evidence
The implementation CI later confirmed the architecture against an actual runner. [GitHub Actions run #40](https://github.com/ParkersYourDad/flutter-mobile-starterkit/actions/runs/40430508949) completed successfully for code commit `9b41c8c0aee338f71618d591a5bba9c0594d51d5` on Flutter 3.47.8 / Dart 3.13.7, including dependency resolution, localization generation, format, analysis, tests, Android debug APK build, and iOS simulator build.

This runtime evidence is a later implementation result, not something claimed at the time the architecture decision was first written.

## Acceptance decision
Stage 2 is closed. The architecture decisions were explicit before implementation and the later CI run confirms the chosen dependency set resolves and builds on the logged toolchain. Physical-device behavior and store/release builds are not covered by this evidence.
