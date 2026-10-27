# Design System — Premium Minimal

**Phase 3 status:** Accepted for implementation handoff on 2026-10-27.  
**Evidence:** centralized tokens/theme and shared components exist under `lib/app/theme/` and `lib/core/widgets/`; targeted Light/Dark component goldens are included in `test/goldens/`. The latest observed GitHub Actions quality job passed formatting, analysis, localization generation, and tests. Android/iOS build jobs were still running at the time this handoff was recorded.

This spec separates existing implementation from checks still owned by the quality/release stages. It does not claim that every accessibility or device-level visual check has already been performed.

## 1. Visual principles

- Quiet, premium, content-first surfaces; generous whitespace and consistent rhythm.
- Neutral identity: warm white, charcoal, and warm gray. No decorative accent color.
- Prefer open layout and subtle dividers; use bordered surfaces only when grouping helps comprehension.
- No decorative elevation/shadows and no Material surface tint.
- No emoji icons. Use Flutter's standard icon set; use directional icons only where the direction carries meaning.
- Keep the visual language consistent across Android and iOS while respecting platform back/gesture behavior.
- Motion must be purposeful and non-essential to understanding. Do not introduce a custom animation package for simple transitions.
- Preserve user/system text scaling; do not clamp text just to keep a screenshot fixed.

## 2. Canonical color tokens

These values mirror `lib/app/theme/app_tokens.dart`. Screens and components must consume tokens/theme roles, not copy raw hex values.

| Semantic token | Light | Dark | Purpose |
|---|---|---|---|
| Canvas | `#F8F8F6` | `#121211` | Main app background |
| Surface | `#FFFFFF` | `#1C1C1A` | Input/surface background |
| Primary | `#292925` | `#F0F0EA` | Main action / monochrome emphasis |
| On primary | `#FFFFFF` | `#121211` | Content on primary action |
| Secondary | `#5C5C55` | `#C5C5BC` | Secondary controls and icons |
| Main text | `#20201D` | `#F2F2ED` | Primary text |
| Muted text | `#62625C` | `#B8B8AF` | Supporting text |
| Divider / outline variant | `#E5E5E0` | `#363632` | Low-emphasis separators |
| Focus outline | `#777770` | `#91918A` | Focused input boundary |
| Error | `#B3261E` | `#F2B8B5` | Error semantics only |

Primary/secondary remain neutral; semantic error color is allowed only to communicate an error. Do not add brand accent colors or arbitrary screen-specific palettes. The theme must keep surface tint transparent.

### Token-level contrast calculations

Calculated from the current token values using WCAG relative luminance (these are calculations on specified colors, not a claim that all rendered widgets have been manually audited).

| Foreground / background | Approx. ratio |
|---|---:|
| Light main text / canvas | 15.36:1 |
| Light muted text / canvas | 5.77:1 |
| Light secondary / canvas | 6.34:1 |
| Light focus outline / surface | 4.51:1 |
| Light error / surface | 6.54:1 |
| Dark main text / canvas | 16.69:1 |
| Dark muted text / canvas | 9.38:1 |
| Dark secondary / canvas | 10.79:1 |
| Dark focus outline / surface | 5.38:1 |
| Dark error / surface | 10.00:1 |

Goldens and contrast measurements do not replace runtime accessibility verification for disabled states, icons, overlays, and real device rendering.

## 3. Typography

- Bundled family: `IBMPlexSansArabic`; current assets include Regular (400) and SemiBold (600) with the SIL Open Font License 1.1 and notice under `assets/fonts/ibm_plex_sans_arabic/`.
- Use the central app theme; do not assign font families or sizes ad hoc inside screens.
- Semantic scale:
  - Body: 14 logical pixels; body line height 1.5.
  - Title: 16; weight 600.
  - Section heading: 20; weight 600.
  - Page heading: 24; weight 600; line height 1.2.
  - Supporting/caption text: 12; line height 1.4.
- The font assets originate from [IBM/plex](https://github.com/IBM/plex) and its [Arabic package OFL license](https://github.com/IBM/plex/blob/master/packages/plex-sans-arabic/LICENSE.txt). Keep license/notice files beside bundled fonts.
- Verify Arabic shaping, Latin glyph fallback, punctuation/mixed-script content, and the available weights on Android and iOS devices before release. Do not invent a missing 500/700 font asset.

## 4. Spacing, shape, sizing

Canonical spacing (logical pixels): 4, 8, 12, 16, 24, 32, 48.  
Canonical corner radii: 8, 12, 16, 24, and pill (999).  
Minimum shared control height: 48.  
Page max content width: 640; default horizontal inset: 24.

Values live in `AppTokens`. Widths 320, 390, 480, 560, and 640 are useful test points; 480/560/640 are test thresholds, not a promise of a web-style responsive breakpoint system. Keep Android/iOS layouts phone-first and allow scroll rather than clipping when vertical space is constrained.

## 5. Component contracts

### AppButton
- Variants: primary, secondary, tertiary; use a variant only when hierarchy justifies it.
- Minimum height 48; radius 12; horizontal padding 16.
- Loading makes the action non-interactive to prevent duplicate submissions and shows a compact progress indicator.
- Disabled/loading state must be understandable to screen readers; do not imply success just because loading ended.
- Directional icons mirror when needed; decorative/non-directional icons do not.

### AppTextField
- Required label; optional hint, validation error, keyboard/action, autofill, prefix/suffix, focus node, enabled/read-only, and obscured behavior.
- Cannot accept both a controller and initialValue.
- Filled using current surface tokens, padding 16, radius 12; focused outline uses the focus token; errors use the semantic error token.
- Error text must be localized and associated with the field; validation state cannot rely on color alone.
- RTL alignment follows ambient Directionality. Input text may contain mixed Arabic/Latin content, identifiers, and numbers.

### AppSurface and SectionHeader
- AppSurface uses the surface token, 16 default padding, radius 16, and subtle divider border; no elevation.
- Prefer plain layout/dividers when a boxed surface adds no meaning; avoid nested card stacks.
- SectionHeader follows the shared heading hierarchy and must support optional description/trailing action without overflow.

### Loading, empty, error, skeleton
- A loading state is shown only while genuine work is pending and provides a semantic label/live region where appropriate.
- Empty state explains the absence of content; any action offered must perform a real action.
- Error state exposes a useful recovery path when one exists and never presents false success.
- Skeletons are reserved for known content shapes and must not be used to decorate a static screen.

### AppBottomBar
- Optional component, not a requirement to add tabs to every app.
- Use only when the product has 3–5 genuine top-level destinations and tab state/navigation behavior is defined.
- Destination labels, selected state, and semantics must be localized; ambient Directionality governs placement.
- Golden coverage demonstrates component appearance, but the actual application must not include a bottom bar without a real navigation need.

### Secondary-screen navigation
- Secondary screens need a clear back affordance and working system/in-app back behavior.
- Directional back glyph must mirror in RTL; non-directional glyphs and logos must not mirror.
- Verify Arabic at a compact width and ensure title/actions do not overlap.

## 6. Localization and accessibility contracts

- English and Arabic strings live in localization resources; no screen-owned hardcoded UI copy.
- Use Flutter's localization delegates and supported locales so framework controls and Directionality follow the selected locale. See [Flutter internationalization](https://docs.flutter.dev/ui/internationalization).
- Check custom animations against platform preferences using Flutter's accessibility APIs; `MediaQueryData.disableAnimations` represents Android's disable/reduce-animation setting, while iOS exposes reduce motion separately. See [Flutter disableAnimations](https://api.flutter.dev/flutter/widgets/MediaQueryData/disableAnimations.html).
- Preserve nonlinear text scaling. Test at larger text scales, with long translations, and on compact devices.
- Interactive targets should be at least 48 logical pixels unless a documented platform-specific exception applies.
- Semantics must include meaningful labels, roles, and state; focus order must be predictable.
- Check WCAG 2.2 AA text contrast where applicable; do not use color alone to communicate errors or selection.
- Test LTR/RTL, Light/Dark/System, settings persistence, screen-reader semantics, empty/error/loading states, and back navigation.

## 7. Golden coverage and acceptance matrix

| Area | Automated evidence | Remaining device/manual check |
|---|---|---|
| Theme tokens and central typography | `test/app_theme_test.dart`; shared-component goldens | Inspect final rendering on Android and iOS |
| Buttons, surface, text input, bottom bar | Light/Dark goldens in `test/goldens/` | Verify visual choices and screen-reader announcements |
| Arabic/LTR and back behavior | Widget test for Arabic direction and compact preferences | Confirm with TalkBack and VoiceOver |
| Settings appearance/locale behavior | Widget and repository tests | Verify OS appearance/locale changes on device |
| Narrow layout and text scale | Compact-width regression test exists | Add/verify 480/560/640 layout and large text cases in Quality stage |
| Color contrast | Token-level ratios above | Check semantic states and real rendered widgets |
| Font assets/license | Bundled font and OFL/notice files | Verify shaping and glyph fallback on both platforms |
| Motion/reduced motion | Flutter platform behavior available | Test Android reduce animations and iOS Reduce Motion |

### Acceptance rule

The design specification and shared-component implementation are accepted for handoff because tokens/components are centralized and the latest observed quality workflow passed. Stage 5 still owns the broader accessibility, font-rendering, contrast-state, large-text, and device-specific checks; do not claim those checks are complete before evidence is recorded.
