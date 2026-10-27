# Flutter Mobile Starter Kit

A focused Flutter foundation for Android and iOS, with neutral design tokens, Arabic/English localization, RTL/LTR support, persisted appearance preferences, and testable shared UI components.

## Current implementation

- Material 3 foundations with neutral Light and Dark themes and System mode.
- Central design tokens for color, spacing, radii, typography, and layout widths.
- Bundled IBM Plex Sans Arabic Regular and SemiBold fonts under the included SIL Open Font License 1.1.
- Arabic and English strings using Flutter localization generation.
- Riverpod 3 settings controller and a small persistence boundary using SharedPreferences.
- Declarative routing with framework-aware back navigation.
- Shared buttons, inputs, surfaces, section headers, bottom navigation, and loading/empty/error/skeleton states.
- Unit, widget, and targeted Light/Dark golden tests.
- GitHub Actions for formatting, static analysis, tests, and Android/iOS simulator builds on code-relevant changes.

## Quick start

Use Flutter stable compatible with the SDK constraint in `pubspec.yaml` (Dart `>=3.12.0 <4.0.0`). Android builds require the Android SDK/toolchain. iOS builds require macOS and Xcode.

From the repository root:

1. `flutter pub get`
2. `flutter gen-l10n`
3. `dart format --output=none --set-exit-if-changed .`
4. `flutter analyze --fatal-infos`
5. `flutter test --reporter expanded`

For a local platform build:
- Android debug: `flutter build apk --debug`
- iOS simulator: `flutter build ios --simulator --no-codesign` (macOS only)

Generated localization output is produced under `lib/l10n/generated` and intentionally not committed.

## Architecture

- `lib/app`: app composition, routing, and themes.
- `lib/core/settings`: theme/locale model, repository boundary, persistence adapter, and Riverpod controller.
- `lib/core/widgets`: reusable controls and shared loading/empty/error states.
- `lib/features`: screen-level composition.
- `lib/l10n/arb`: source translations for English and Arabic.
- `docs/project`: requirements, architecture decisions, design system, stages, and handoffs.
- `docs/release/RELEASE_CHECKLIST.md`: device verification and release gates.

## Localization and design

Use the localization resources rather than hardcoding visible copy. Keep layout direction derived from the active locale; test Arabic and English, both appearance themes, enlarged text, and back navigation. Use the shared tokens and controls instead of defining ad hoc visual values per screen. See [the design system](docs/project/DESIGN_SYSTEM.md).

## Quality

A control must perform its stated action or be explicitly disabled. Do not add secrets or credentials to source control, do not use `print()` for logging, and do not claim a build/test passed without recorded output.

CI runs for changes to Dart source/tests, dependencies, localizations, assets, platform projects, and workflow/tooling files. Documentation-only changes do not launch native platform builds.

## Scope

Android and iOS only. Web and desktop are out of scope. Backend integrations, authentication providers, analytics, AI SDKs, payments, and product-specific business features are intentionally deferred.

## License

Project source code is licensed under the MIT License (see `LICENSE`). Bundled IBM Plex Sans Arabic font files are separately licensed under SIL Open Font License 1.1; see `assets/fonts/ibm_plex_sans_arabic/OFL.txt` and the accompanying notice.
