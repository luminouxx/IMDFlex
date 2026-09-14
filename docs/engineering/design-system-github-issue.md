# GitHub Issue — Progressive Design System Components

Created as [#39](https://github.com/luminouxx/IMDFlex/issues/39).

## Title

`feat: establish progressive design system components`

## Summary

Rebuild IMDFlex's SwiftUI design tokens and shared components from the approved Figma V4 contract while keeping APIs small, native, accessible, and progressively disclosed.

## Motivation

The current DesignSystem uses an older blue and radius scale, does not provide a shared Field, and lets optional state accumulate in component initializers. Repeated controls can drift in hit size, alignment, disabled state, and accessibility semantics.

## Proposed Solution

- Align semantic color, radius, control-size, spacing, typography, Layout, and Motion tokens with the current Figma/HIG contract.
- Use required-only initializers and focused value-returning modifiers.
- Use Environment for shared visual scope, not workflow state.
- Add native Button styles, a 44 pt Field, status badge, panel surface, tool/select controls, inspector rows, and DisclosureGroup composition.
- Migrate existing map-editor call sites required by the API change.
- Add lightweight DesignSystem contract tests, documentation governance, and an HTML implementation report.

## Acceptance Criteria

- [ ] Primary is `#005EA8`; controls use 12 pt radius and at least 44×44 pt interactive regions.
- [ ] Status badge is noninteractive, at least 32 pt high, and communicates status with icon, text, and color.
- [ ] Field label, value, supporting text, error, focus, and icon alignment are systemized.
- [ ] `Compact`, `Intermediate`, and `Regular` Layout modes plus Standard/Reduced Motion are explicit and testable.
- [ ] Public component initializers contain only required data; optional presentation uses focused modifiers.
- [ ] DesignSystem, Presentation integration, and the complete app compile without third-party dependencies.
- [ ] Decision records, documentation index, and HTML report are committed.

## IMDF Impact

None. This change affects shared UI infrastructure and does not alter Apple IMDF schema, GeoJSON, relationships, export, or validator behavior.

## Alternatives Considered

- Keep extending the existing initializer-heavy components: rejected because it increases coupling and API discovery cost.
- Mirror every Figma property as a Swift parameter: rejected because native SwiftUI and HIG behavior are the shipping source of truth.
- Add snapshot-test dependencies now: deferred because third-party dependencies require explicit approval; build and pure-contract tests cover this phase.

## Additional Context

- Figma: `kqT9zmJTq9nOoV43y6hYqS`
- [Progressive Disclosure article](https://medium.com/@luminouxx98/progressive-disclosure%EC%9D%84-%EC%A7%80%ED%82%A8-swiftui-component-%EC%84%A4%EA%B3%84-44a96f6aa991)
