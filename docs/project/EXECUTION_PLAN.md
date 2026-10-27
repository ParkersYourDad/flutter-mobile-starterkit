# Project Execution Plan

## Operating model

Work is divided into specialist workstreams. In this session these are role-based workstreams, not independent background agents. Parallelize only independent discovery/preparation; integrate all changes through one accountable implementation owner.

Each stage is completed and recorded before dependent work begins. A handoff states deliverables, acceptance evidence, risks, and the receiver. A written plan is not implementation evidence. Do not repeat full audits; use targeted checks driven by a concrete failure or gate.

## Stage 1 — Product requirements

**Owner:** Product & Requirements  
**Deliverables:** `docs/project/PRODUCT_REQUIREMENTS.md` and this plan.  
**Exit gate:** every core requirement has an ID, priority, acceptance criteria, and verification approach.  
**Status:** **Accepted** — specification is in the repository. This accepts requirements, not product implementation.

## Stage 2 — Architecture decisions

**Owner:** Architecture & Engineering  
**Deliverables:** `docs/project/ARCHITECTURE_DECISIONS.md` and `docs/project/HANDOFF_PHASE_2.md`.  
**Exit gate:** target, state, routing, persistence, localization, dependencies, and quality policy are explicit; version constraints checked against current published metadata. Runtime resolution/build checks belong to Stage 4 CI.  
**Status:** **Accepted** — source metadata and Flutter release history checked on 2026-10-27.

## Stage 3 — Design system and UX

**Owner:** Design Systems & UX  
**Deliverables:** `docs/project/DESIGN_SYSTEM.md`, centralized tokens/theme, shared component contracts and implementation, Light/Dark golden tests, `docs/project/HANDOFF_PHASE_3.md`.  
**Exit gate:** token values are unambiguous; components use centralized theme roles; design/localization/accessibility behavior has testable contracts; targeted Light/Dark goldens pass.  
**Status:** **Accepted for handoff** — current source includes the token/theme and shared components; the quality job on code commit `9aa3af4b771fb14930d7d25bcf26bbd9ff3f59be` passed dependency resolution, localization generation, format, analysis, and automated tests. Broader device accessibility/rendering checks remain in Stage 5.

## Stage 4 — Flutter implementation and build verification

**Owner:** Flutter Engineering  
**Goal:** finish and verify the working Android/iOS foundation already present in the repository, correcting only targeted failures.  
**Deliverables:** app source, settings persistence, routing/localization, reusable components, tests, CI, and platform build results.  
**Exit gate:** the latest commit has green dependency resolution, localization generation, format, analyze, and tests; Android debug APK and iOS simulator builds both pass. A prior green run does not replace checking the latest commit's results.  
**Status:** **In Progress** — code and CI exist. Latest observed quality job passed; Android and iOS build jobs for that run were still pending/running. Check their final outcomes before closing this stage.

## Stage 5 — Quality, security, accessibility, performance

**Owner:** Quality Engineering  
**Goal:** verify high-value behavior beyond source-only assertions.  
**Deliverables:** targeted evidence for RTL/LTR and back navigation, system locale/appearance, large text, compact layouts, semantics, font shaping/fallback, token contrast, storage failures, secret/log checks, and baseline performance.  
**Exit gate:** no unresolved critical/high-severity defect; results recorded; failures return as a bounded fix list rather than a repeated broad review.

## Stage 6 — Developer experience and release readiness

**Owner:** Developer Experience & Release  
**Deliverables:** concise tested setup/extension docs, contribution guidance, CI path filtering, explicit license status, and release checklist.  
**Exit gate:** clean-checkout setup is tested, CI runs on code-relevant changes and pull requests, and support/licensing boundaries are explicit.

## Handoff states

`Ready → In Progress → Handoff Review → Accepted`

Use `Blocked` only with a specific reason, owner, and unblocking action. Do not start dependent implementation until the preceding phase is accepted. Do not claim a check passed without the actual result. Keep documentation-only changes from triggering full native builds once the CI path filter is established.

## Non-negotiable constraints

- Android and iOS only; no web/desktop scope.
- English and Arabic with locale-aware RTL/LTR; Light/Dark/System.
- Premium minimal neutral design; no emoji icons, arbitrary colors, unnecessary elevation, or surface tint.
- Centralized tokens/shared components; no hardcoded user-facing copy or visual values in screens.
- Riverpod 3 Notifier/AsyncNotifier; no new StateProvider/StateNotifierProvider.
- Manual model serialization by default; no code generation without a demonstrated need.
- No fake production behavior, secret leakage, unnecessary SDKs, analytics, AI, or monetization packages without product need.
- No deletion of unrelated repositories or history rewrites.
- Do not describe planned or unverified checks as passing.

## Current repository state

Repository: `ParkersYourDad/flutter-mobile-starterkit`  
Default branch: `main`  
Stage 1, 2, and 3 handoffs are accepted. Stage 4 is active pending latest Android/iOS CI build outcomes. The code-quality job has passed in the observed run; native build jobs were still pending/running when last inspected.
