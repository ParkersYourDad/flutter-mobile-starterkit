# Design System — Premium Minimal

This document defines implementation constraints, not a claim that UI has already been implemented or visually validated.

## Visual principles

- Quiet, premium, content-first surfaces; restrained, consistent spacing.
- Neutral identity: white, black, and warm grays; no arbitrary accent colors.
- Prefer open surfaces and subtle dividers; avoid decorative cards and elevation.
- No Material surface tint and no emoji used as icons.
- Use native platform behavior where appropriate, but keep the app's visual language consistent across Android and iOS.
- Motion should be short, restrained, meaningful, and non-essential to understanding.

## Typography

Initial semantic scale:
- Body: 14
- Title: 16
- Section heading: 20
- Page heading: 24

These are design tokens, not permission to hardcode sizes in screens. Verify legibility at increased text scale and on compact devices. IBM Plex Sans Arabic Regular and SemiBold are bundled from IBM/plex commit `71f558992315a12ca1f06a2215d57962a1992162`. The font package's SIL Open Font License 1.1 is included alongside the assets in `assets/fonts/ibm_plex_sans_arabic/OFL.txt`. The family is applied centrally as `IBMPlexSansArabic`; verify shaping and glyph fallback on physical iOS and Android devices before release.

## Spacing and shape

Initial spacing scale (logical pixels): 4, 8, 12, 16, 24, 32, 48.  
Initial radius scale (logical pixels): 8, 12, 16, 24, and a pill radius token.

All values must live in centralized tokens. Components must use semantic tokens rather than copying raw values.

## Theme behavior

- Light, dark, and system modes.
- Neutral color schemes with adequate contrast in both themes.
- Zero decorative elevation and no surface tint.
- Theme mode persists when explicitly selected; System remains a distinct choice.
- Every shared component must work in both themes without per-screen overrides.

## Shared component contract

### Button
- Primary, secondary, and tertiary variants only when their hierarchy is meaningful.
- Clearly defined enabled, disabled, loading, and pressed states.
- Loading prevents duplicate activation and exposes an accessible state.
- Label and icons mirror direction only when the icon is directional.

### Input
- Label, hint, error, enabled/disabled, focus, and validation states.
- Correct keyboard/input semantics and accessible error association.
- RTL-aware alignment; no text-direction assumptions for mixed-script user input.

### Surface/Card
- Use only when grouping improves comprehension.
- Prefer open layout and dividers over nested card stacks.
- No decorative elevation or tinted surfaces.

### SectionHeader
- Consistent title hierarchy and optional supporting/action content.
- Handles Arabic, long strings, and narrow widths.

### Loading, empty, error, success
- Loading is not a blank screen; use skeletons only when they reflect actual pending content.
- Empty states explain what is empty and offer a real next action when one exists.
- Error states communicate recoverable action; never show fake success.
- Success feedback is brief and accessible.

## Navigation and directionality

- Back affordance is clear on secondary screens.
- Back icon direction and placement follow locale direction.
- System back gesture/button and in-app back behavior remain sensible.
- Do not mirror non-directional icons or logos.

## Accessibility requirements

- Test semantic labels, roles, focus order, and state announcements.
- Respect system text scaling without clipping critical content.
- Meet WCAG 2.2 AA contrast targets where applicable.
- Ensure usable touch targets, with documented exceptions.
- Motion must not carry information by itself; respect platform reduced-motion expectations where supported.

## Responsive and localization checks

Test compact and large phones, plus widths around 480, 560, and 640 logical pixels as layout stress points, not as web breakpoints. Verify:
- English LTR and Arabic RTL.
- Long strings and mixed Arabic/Latin content.
- Light/Dark/System.
- Increased text scale.
- Loading/error/empty/success.
- Back navigation and directional icons.

## Golden test scope

Use targeted goldens for key shared components (button, surface/card, input, bottom navigation only if included) in Light and Dark. Avoid broad screenshot duplication and brittle full-screen goldens unless a screen is a true release-critical contract.

## Acceptance

This specification is accepted only when implemented tokens/components and automated tests exist, and the targeted rendered output has been reviewed. This file alone is not evidence of visual completion.
