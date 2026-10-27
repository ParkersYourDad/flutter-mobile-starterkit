# Release Checklist

This checklist is required before describing a build as release-ready. CI success alone is not release certification.

## Automated baseline

- [ ] The current release commit has a green GitHub Actions quality job (dependency resolution, localization generation, formatting, static analysis, tests).
- [ ] Android production release build succeeds and is signed through the approved secure signing process.
- [ ] iOS archive/build succeeds on macOS with the intended signing and provisioning settings.
- [ ] Version/build number and release notes are reviewed.
- [ ] Dependency and license notices are checked; repository source MIT license and IBM Plex Sans Arabic OFL notice remain present.
- [ ] No secrets, keystores, provisioning profiles, or credentials are committed. Signing secrets are supplied only through approved secure configuration.

## Physical-device verification — release blockers

Record device model, OS version, locale, appearance, text size, tester/date, result, and defect references for each applicable item.

- [ ] Android device: smoke test launch, navigation, in-app/system back behavior, theme/locale settings, and persistence after a force-stop/restart.
- [ ] iPhone device: repeat the same smoke checks, including native back gesture and process restart.
- [ ] TalkBack: verify screen title, control labels/roles/state, settings selection, error feedback, and focus order.
- [ ] VoiceOver: verify the equivalent labels, roles/state, settings selection, error feedback, and focus order.
- [ ] Arabic RTL and English LTR: inspect screen alignment, back arrow direction, controls, long labels, punctuation, numbers, and mixed Arabic/Latin content on devices.
- [ ] Font rendering: verify IBM Plex Sans Arabic shaping, punctuation, fallback glyphs, and mixed-script layout on actual Android and iOS hardware.
- [ ] Appearance: verify Light, Dark, and System, then change OS appearance while System is selected.
- [ ] Locale: verify the System locale follows OS locale changes where applicable; verify explicit Arabic/English overrides remain stable across restart.
- [ ] Text scaling: test at default and enlarged system text sizes, including the maximum practical settings screen size, with no clipped controls or hidden actions.
- [ ] Layout: verify compact phones (including 320 logical pixels wide) and larger phone sizes; check 480/560/640 logical-pixel stress widths without treating them as web targets.
- [ ] Contrast and states: inspect enabled, disabled, focused, error, selected, loading, and system-provided surfaces in both themes; do not rely on color alone.
- [ ] Motion: verify transitions remain restrained and respect relevant platform reduce/disable-animation preferences.

## Final handoff

- [ ] All critical/high-severity defects found during the release pass are fixed or explicitly block release.
- [ ] No manual release blocker is marked passed without recorded evidence.
- [ ] README setup commands and supported-platform limits match the release build.
- [ ] Any product-specific privacy policy, permissions rationale, store listing, and data disclosures are added by the consuming app before distribution.

## Current status

Automated foundation checks have passed in [CI run #53](https://github.com/ParkersYourDad/flutter-mobile-starterkit/actions/runs/40432349288). Physical-device, accessibility, font-rendering, and signed production-release checks have not been demonstrated by that run. **Do not treat this repository as release-certified until the applicable blocker checklist above is completed.**
