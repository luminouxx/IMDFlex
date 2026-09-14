# 0001 — Progressive Design System API

- Status: Accepted
- Date: 2026-09-14
- Areas: Design, Engineering

## Context

The Figma V4 design defines reusable visual contracts, while the SwiftUI implementation must remain native, accessible, and maintainable. Existing component initializers had started accumulating optional icon, role, and selection parameters. That pattern makes simple use cases harder to discover and encourages “big head” components.

## Decision

1. Public component initializers accept only required content, bindings, and actions.
2. Optional local presentation is added through focused value-returning modifiers that each change one concern.
3. Shared visual scope—Layout mode, Motion mode, and Panel style—uses SwiftUI Environment.
4. Workflow state such as selection, loading, validation, and callbacks stays explicit in Presentation.
5. Native SwiftUI controls and semantic Dynamic Type styles are preferred. The app does not embed Figma's Inter font; Apple platform UI uses the system font.
6. Interactive controls provide at least a 44×44 pt hit region. Status must not be communicated by color alone.
7. Preset axes stay small and independent; combined state presets are prohibited.

## Consequences

- Simple use reads like native SwiftUI and autocomplete reveals complexity progressively.
- Component variants cannot silently become workflow models.
- Call sites must migrate from optional-heavy initializers to explicit modifiers.
- Visual snapshots remain deferred until a dependency decision is approved; pure layout and motion contracts receive XCTest coverage now.

## References

- [Design System Foundation](../../design-system-foundation.md)
- [Progressive Disclosure article](https://medium.com/@luminouxx98/progressive-disclosure%EC%9D%84-%EC%A7%80%ED%82%A8-swiftui-component-%EC%84%A4%EA%B3%84-44a96f6aa991)
- Figma file `kqT9zmJTq9nOoV43y6hYqS`, V4 Button, Field, Status Badge, Rules, and Editor Header nodes.
