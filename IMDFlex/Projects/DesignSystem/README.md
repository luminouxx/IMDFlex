# DesignSystem

Shared SwiftUI tokens and components for the map-first IMDFlex editor.

## Structure

```
Sources/
├── Components/    # Focused reusable views
├── Styles/        # Small visual presets and semantic roles
└── Tokens/        # Color, typography, spacing, layout, motion, and metrics
```

## Guidelines

- Keep initializers limited to required content and actions.
- Add optional presentation one concern at a time with focused modifiers.
- Put shared visual scope in Environment; keep workflow state in Presentation.
- Prefer native SwiftUI controls and semantic text styles.
- Every interactive control must provide at least a 44×44 pt hit region.
- Keep editor controls stable in size so state changes do not shift layout.
- Never import Domain or Data into this module.

## Dependencies

- None

## Testing Requirements

- **SwiftUI Previews are required** for all components
- Previews should demonstrate all component variants

## Component Usage

### Colors

```swift
import DesignSystem

Text("Hello")
    .foregroundStyle(Color.imdfPrimary)
```

### Primary and secondary actions

```swift
Button("Create feature", systemImage: "plus", action: createFeature)
    .buttonStyle(.imdfPrimary)

Button("Cancel", action: cancel)
    .buttonStyle(.imdfSecondary)

Button("Delete feature", systemImage: "trash", role: .destructive, action: deleteFeature)
    .buttonStyle(.imdfDestructive)
```

### Tool Button

```swift
IMDFToolButton("Unit", systemImage: "square.split.2x2", action: selectUnit)
    .selected(selectedFeature == .unit)
```

### Status Badge

```swift
IMDFStatusBadge("3 Issues")
    .status(.warning)
```

### Panel

```swift
IMDFPanel {
    Text("Inspector")
}
.imdfPanelStyle(.inspector)
```

`IMDFPanel` is only a surface container. Header, footer, loading, and inspector-specific behavior should be composed by higher-level components.

### Field

```swift
IMDFField("Name", text: $name)
    .placeholder("Feature name")
    .supportingText("Shown to map users")

IMDFField("Level reference", text: .constant(levelID))
    .readOnly()
```

### Responsive and motion scope

```swift
EditorRoot()
    .imdfLayoutMode(.intermediate)
    .imdfMotionMode(.reduced)
```

## Rules

- **DO NOT** import Domain or Data
- **DO NOT** include app-specific or business logic
- **DO NOT** reference specific screens or features
- **DO NOT** grow base components with unrelated optional behavior

## Contributing

When modifying this module:
1. Add a SwiftUI Preview for visual components.
2. Add or update the usage example in this README.
3. Verify light/dark appearance, Dynamic Type, Reduce Motion, and Reduce Transparency.
4. Add tests for pure contracts, appearance-aware semantic colors, and stable metrics; prefer build verification for view rendering until snapshot testing is approved.

See `docs/design-system-foundation.md` for the product-level design direction.
