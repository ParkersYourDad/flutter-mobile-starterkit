# Flutter Mobile Starter Kit

A focused Flutter foundation for Android and iOS, with neutral design tokens, Arabic/English localization, RTL/LTR support, persisted appearance preferences, and testable shared UI components.

## Current implementation

- Material 3 foundations with neutral Light and Dark themes and System mode.
- Central design tokens for color, spacing, radii, typography, and layout widths.
- Bundled IBM Plex Sans Arabic Regular and SemiBold fonts under the included SIL Open Font License 1.1.
- Arabic and English strings using Flutter localization generation.
- Riverpod 3 settings controller and a small persistence boundary using SharedPreferences.
- Declarative routing with correct framework-aware back affordance.
- Shared buttons, inputs, surfaces, section headers, bottom navigation, and loading/empty/error/skeleton states.
- Unit, widget, and targeted Light/Dark golden tests for shared components.
- GitHub Actions for formatting, static analysis, tests, and Android/iOS simulator builds.

## Repository status

The app source and native Android/iOS project scaffolding are committed. CI verifies formatting, analysis, tests, and platform builds. Physical-device checks, a targeted accessibility review, the repository's own reuse license decision, and release readiness remain open gates. Do not treat this starter as release-ready until those gates pass.

## Toolchain and local checks

Use a current stable Flutter release compatible with Dart 3.12 or newer. Android builds require the Android toolchain; iOS builds require macOS and Xcode.

From the repository root, run these commands in order:

1. `flutter pub get`
2. `flutter gen-l10n`
3. `dart format --output=none --set-exit-if-changed lib test`
4. `flutter analyze --fatal-infos`
5. `flutter test --reporter expanded`

Localization output is generated into `lib/l10n/generated` and intentionally not committed.

## Architecture

- `lib/app`: app composition, routing, and themes.
- `lib/core/settings`: theme/locale model, repository boundary, persistence adapter, and Riverpod controller.
- `lib/core/widgets`: reusable controls and shared loading/empty/error states.
- `lib/features`: screen-level composition.
- `lib/l10n/arb`: source translations for English and Arabic.
- `docs/project`: requirements, architecture decisions, design system, stages, and handoffs.

## Scope

Android and iOS only. Web and desktop are out of scope. Backend integrations, authentication providers, analytics, AI SDKs, payments, and product-specific business features are intentionally deferred.

## Quality and security policy

A control must perform its stated action or be explicitly disabled. No secrets or credentials belong in source control. Do not add `print()` logging, unnecessary dependencies, or claims of successful builds/tests without recorded output.

## License

No license has been selected yet. Do not assume permission to reuse or redistribute this repository until a license is added.
