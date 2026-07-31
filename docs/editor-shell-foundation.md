# Editor Shell Foundation

This document records the first editor shell boundary for IMDFlex.

## Goal

The editor shell connects the Presentation-layer IMDF authoring state to visible editor controls without committing to MapKit coordinate capture, Domain feature mutation, persistence, or GeoJSON export yet.

This keeps the workflow map-first while letting the UI progressively disclose only what the current authoring feature needs:

- selected IMDF feature
- geometry mode
- drafted point count
- category readiness
- reference readiness
- draft completion readiness

## Component Boundary

### Presentation MVVM

Map editor Presentation code should follow a strict MVVM boundary:

- SwiftUI views render display-ready state and call ViewModel intents.
- Child views receive the smallest needed values and intent closures, not the entire parent ViewModel, unless they represent a separate screen-level MVVM boundary.
- ViewModels orchestrate user intents and combine focused Presentation state models.
- Display descriptors own feature, geometry, reference, label, icon, and status mapping.
- Focused state models, such as drawing drafts, should remain small and should not know about SwiftUI view layout.
- Domain feature creation, persistence, export, and validation should stay behind future use cases, services, or coordinators.

Do not add editor workflow orchestration directly to `MapEditorView` or its private child views. If a view needs to decide what a feature means, which requirement is ready, or which action should mutate state, move that decision into a ViewModel or descriptor first.

### DesignSystem

DesignSystem should provide small, reusable primitives that do not know about IMDF feature semantics.

Current editor primitives:

- `IMDFToolButton`: icon-only command button for compact map tools.
- `IMDFPanel`: material-backed floating, inspector, and status surfaces.
- `IMDFStatusBadge`: compact status display.
- `IMDFSelectionButton`: selectable row-like control for feature or mode lists.
- `IMDFInspectorSection`: titled inspector grouping.
- `IMDFInspectorRow`: compact key/value inspector row.

These components should stay generic. They should not import `Domain` or `Presentation`, and they should not know about categories, levels, units, or GeoJSON.

### Presentation

Presentation owns editor-specific composition:

- `MapEditorView`
- `FeatureAuthoringToolState`
- feature display names and SF Symbol choices
- draft controls that call authoring state intents
- category/reference readiness placeholders

Presentation can depend on `Domain` and `DesignSystem`, but it should keep Domain mutations behind future editor use cases or coordinators.

## Astryx Reference

Astryx Components is used as a taxonomy reference, not as a visual copy target.

Useful categories for IMDFlex:

- Action: toolbar, icon button, segmented/selection controls.
- Container: panel, collapsible inspector section.
- Data Input: field, selector, typeahead, slider.
- Feedback & Status: badge, status dot, banner.
- Layout: app shell, divider, section, resize handle.
- Overlay: popover, tooltip, command palette.

IMDFlex should translate these ideas into native SwiftUI controls that follow Apple HIG and fit iPad/Mac map editing.

## Progressive Disclosure Rules

- Keep DesignSystem controls small and reusable.
- Compose inspector headers, footers, and actions in Presentation.
- Do not create one large editor component that owns all state.
- Add category picker, reference picker, drawing coordinates, and inspector forms as adjacent models.
- Avoid hiding important workflow state in SwiftUI view bodies when it can be represented by testable state or coordinator APIs.

## Deferred Work

The current shell intentionally does not implement:

- address search
- map locking
- level selection
- floor-plan overlay alignment
- MapKit gesture coordinate capture
- GeoJSON conversion
- Domain feature creation
- `imdf.zip` export
- Apple IMDF Validator execution

Those should be added as focused follow-up PRs.
