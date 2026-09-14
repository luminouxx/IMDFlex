# Design System Foundation

This document is the current implementation contract for the IMDFlex SwiftUI design system.

## Direction

IMDFlex uses a hybrid editor style:

- Apple Maps-like floating controls over a real map canvas.
- Calm, professional inspector surfaces for repeated IMDF authoring.
- Apple-native interaction, semantic typography, Dynamic Type, light/dark appearance, and accessibility settings.
- iPad and Apple Pencil first. Mac adaptation remains a product direction; the current Tuist target is iOS.

## Layout Principles

- `Compact`, `Intermediate`, and `Regular` are explicit layout modes with 16, 24, and 32 pt outer padding.
- Intermediate and Regular inspector guidance is 320 and 360 pt. Compact uses a separate presentation rather than a fixed inspector width.
- Interactive controls use a minimum 44×44 pt hit region; the 32 pt status badge is display-only.
- Inspector and status surfaces should be compact, scannable, and restrained.
- Validation/preflight status uses text, icon, and semantic color together.
- Layout and Motion modes should be applied at a screen root with `.imdfLayoutMode(_:)` and `.imdfMotionMode(_:)` so support remains traceable. The APIs are available; current screen integration is deferred to the Presentation migration.

## Current Tokens

- `IMDFColor`: appearance-aware text/icon tints and separate filled-action backgrounds for primary and danger, plus semantic separators and neutral fills. Light, dark, and high-contrast values are explicit; light primary remains `#005EA8`.
- `IMDFSpacing`: 2–40 pt spacing scale, including V4 outer padding values.
- `IMDFRadius`: 12 pt controls and 16/20 pt panel surfaces.
- `IMDFControlMetrics`: 44 pt control/field minimum, 32 pt noninteractive badge, and 52 pt large action guidance.
- `IMDFIconSize`: 16, 20, and 24 pt icon sizes.
- `IMDFFont`: semantic Dynamic Type styles. The Figma Inter reference is not embedded in the app; the shipping iOS UI uses the Apple system font.
- `IMDFLayoutMode`: Compact, Intermediate, Regular.
- `IMDFMotionMode`: Standard and Reduced, combined with the system Reduce Motion setting.

## Current Components

- `IMDFButtonStyle`: primary, secondary, and destructive native Button styles with pressed, disabled, Dynamic Type, and Reduced Motion behavior.
- `IMDFToolButton`: 44 pt icon-only map/editor tool with explicit selection, native destructive semantics, and press feedback.
- `IMDFStatusBadge`: 32 pt semantic, noninteractive status with an icon and accessibility value.
- `IMDFField`: labeled 44 pt TextField with focus, supporting text, error, icon, placeholder, external disabled state, and a distinct read-only state.
- `IMDFPanel`: material-backed surface styled through scoped Environment.
- `IMDFInspectorRow` and `IMDFInspectorActionRow`: separate display and 44 pt interactive inspector rows.
- `IMDFDisclosureSection`: native DisclosureGroup wrapper for progressive disclosure.
- `IMDFSelectionButton`, `IMDFInspectorSection`, and `EmptyStateView`: focused reusable compositions.

## Progressive Disclosure Component Rules

DesignSystem components stay small and reveal complexity through composition instead of option-heavy “big head” APIs.

- Initializers contain required content, bindings, and actions only.
- Optional presentation is applied with focused modifiers such as `.selected(_:)`, `.status(_:)`, `.error(_:)`, and `.systemImage(_:)`.
- Shared surface policy such as Panel style, Layout mode, and Motion mode is scoped through Environment.
- Selected feature, validation result, loading state, and callbacks remain explicit Presentation state; they are never hidden in Environment.
- `IMDFPanel` stays a pure container. Headers, footers, selection, loading, and workflow logic are composed at a higher level.
- `IMDFStatusBadge` is only for status and validation. Category display requires a separate component when a real repeated use case exists.
- New presets are added only for recurring semantic differences. Do not create combinatorial presets such as “primaryCompactLoadingSelected”.
- Feature-specific composition belongs in Presentation.

## State And Appearance Contract

- Interactive controls provide visible pressed feedback; spatial scale is removed when Reduce Motion is active.
- Disabled controls preserve their semantic role while reducing emphasis. Read-only fields remain readable and expose a lock affordance instead of pretending to be disabled input.
- Button and selection labels may wrap to two lines under Dynamic Type rather than being forced into a single truncated line.
- Semantic colors must resolve through the DesignSystem bundle for light, dark, and high-contrast appearances. Contract tests pin the light accent, verify tint contrast against the system background, and verify white-label contrast on filled-action backgrounds.

## Deferred Work

- Product-screen migration to these components beyond the existing map editor integration.
- Category picker/search UI and a category-specific chip when recurring use is proven.
- `IMDFCategoryChip` for category selection/display.
- Snapshot testing.
- Platform-specific toolbar/inspector adaptation.

## References

- [Progressive Disclosure를 지킨 SwiftUI Component 설계](https://medium.com/@luminouxx98/progressive-disclosure%EC%9D%84-%EC%A7%80%ED%82%A8-swiftui-component-%EC%84%A4%EA%B3%84-44a96f6aa991)
- Figma V4 component contract: Button 44 pt / radius 12 / primary `#005EA8`, Field 44 pt, Status Badge 32 pt.
- [Important decision 0001](decisions/important/0001-progressive-design-system-api.md)
