# Project Execution Plan

## Operating model

Work is divided into specialist workstreams. In this session these are role-based workstreams, not independent background agents. Parallelize only independent discovery/preparation; integrate changes through one accountable implementation owner.

Each stage is completed and recorded before dependent work begins. A handoff states deliverables, acceptance evidence, risks, and the receiver. A written plan is not implementation evidence. Avoid repeated broad audits; use targeted checks driven by a concrete gate or failure.

## Stage 1 — Product requirements

**Owner:** Product & Requirements  
**Deliverables:** `docs/project/PRODUCT_REQUIREMENTS.md` and this plan.  
**Exit gate:** every core requirement has an ID, priority, acceptance criteria, and verification approach.  
**Status:** **Accepted** — product scope and core requirements are in the repository. This accepts the specification, not product implementation.

## Stage 2 — Architecture decisions

**Owner:** Architecture & Engineering  
**Deliverables:** `docs/project/ARCHITECTURE_DECISIONS.md` and `docs/project/HANDOFF_PHASE_2.md`.  
**Exit gate:** targets, state, routing, persistence, localization, dependencies, and quality policy are explicit; package metadata and runtime compatibility are checked.  
**Status:** **Accepted** — current package metadata checked; later CI resolved and built the selected dependencies.

## Stage 3 — Design system and UX

**Owner:** Design Systems & UX  
**Deliverables:** `docs/project/DESIGN_SYSTEM.md`, centralized tokens/theme, shared component contracts and implementation, Light/Dark golden tests, `docs/project/HANDOFF_PHASE_3.md`.  
**Exit gate:** tokens and components are centralized; theme/localization/RTL behavior has testable contracts; targeted Light/Dark goldens pass.  
**Status:** **Accepted** — design specification and shared components committed; targeted golden suite passed in CI.

## Stage 4 — Flutter implementation and build verification

**Owner:** Flutter Engineering  
**Deliverables:** mobile Flutter app, settings persistence, routing/localization, reusable components, tests, CI, platform build results.  
**Exit gate:** dependency resolution, format, analysis, tests, Android debug build, and iOS simulator build all pass.  
**Status:** **Accepted** — documented in `docs/project/HANDOFF_PHASE_4.md`; CI passed on Flutter 3.47.8 / Dart 3.13.7.

## Stage 5 — Quality, security, accessibility, performance

**Owner:** Quality Engineering  
**Deliverables:** controller failure-path tests, enlarged-text/compact RTL test, token contrast assertions, focused source scan, and `docs/project/HANDOFF_PHASE_5.md`.  
**Exit gate:** all automated checks available in CI pass; remaining device checks are explicitly assigned as release gates rather than falsely marked passed.  
**Status:** **Accepted for automated verification** — [CI run #53](https://github.com/ParkersYourDad/flutter-mobile-starterkit/actions/runs/40432349288) completed successfully: 23 tests passed, formatting/analyze passed, Android debug APK passed, and iOS simulator build passed. Physical-device and full release checks remain unverified and must block any claim of release readiness.

## Stage 6 — Developer experience and release readiness

**Owner:** Developer Experience & Release  
**Status:** **In Progress** — CI path filters, contributor guidance, setup instructions, license confirmation, and release gates are being finalized.  
**Goal:** make setup and extension repeatable and remove avoidable CI overhead while preserving required code checks.  
**Deliverables:**
- CI path filters that skip documentation-only changes but retain coverage for Dart source/tests, dependencies, localizations, assets, tooling, workflow, and Android/iOS platform changes.
- README setup/extension instructions that match CI commands.
- Concise contributor guidance.
- Explicit license boundaries (project code MIT; bundled font assets OFL with their notice).
- A release checklist with physical-device accessibility, font rendering, large text/layout, system appearance/locale persistence, and signed production builds.
**Exit gate:** CI path filters work as intended and code-relevant workflow changes pass CI; setup instructions match implemented commands; license and third-party font terms remain explicit; manual device checks remain tracked and release stays blocked until actual evidence is recorded.

## Handoff states

`Ready → In Progress → Handoff Review → Accepted`

Use `Blocked` only with a specific reason, owner, and unblocking action. Do not start dependent implementation until the preceding phase is accepted. Do not claim a check passed without the actual result.

## Non-negotiable constraints

- Android and iOS only; no web/desktop scope.
- English and Arabic with locale-aware RTL/LTR; Light/Dark/System.
- Premium minimal neutral design; no emoji icons, arbitrary colors, unnecessary elevation, or surface tint.
- Centralized tokens/shared components; no hardcoded user-facing copy or visual values in screens.
- Riverpod 3 Notifier/AsyncNotifier; no new StateProvider/StateNotifierProvider.
- Manual model serialization by default; no code generation without a demonstrated need.
- No fake production behavior, secret leakage, unnecessary SDKs, analytics, AI, or monetization packages without product need.
- No deletion of unrelated repositories or history rewrites.
- Never represent automated CI as physical-device certification.

## Current repository state

Repository: `ParkersYourDad/flutter-mobile-starterkit`  
Default branch: `main`  
Stages 1–5 are accepted within their stated evidence and limits. Stage 6 is active. Release readiness remains blocked until the manual/device release gates are backed by evidence.
