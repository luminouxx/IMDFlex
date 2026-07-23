# DesignSystem

Shared UI components and design tokens for the hybrid IMDFlex editor style.

## Structure

```
Sources/
├── Components/    # Reusable views (tool buttons, badges, panels, empty states)
└── Tokens/        # Color, typography, spacing, radius, and icon tokens
```

## Guidelines

- Components should be generic and reusable
- Define all colors and styles as static properties
- No business logic in this module
- Keep editor controls stable in size so selection state does not shift layout
- Prefer semantic roles over feature-specific component names
- Prefer small composable components over option-heavy components

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

### Tool Button

```swift
IMDFToolButton(
    title: "Unit",
    systemImage: "square.split.2x2",
    isSelected: true
) {}
```

`IMDFToolButton` is icon-only by default. Add label-capable variants later when a real editor layout needs them.

### Status Badge

```swift
IMDFStatusBadge("3 Issues", systemImage: "exclamationmark.triangle", role: .warning)
```

### Panel

```swift
IMDFPanel(role: .inspector) {
    Text("Inspector")
}
```

`IMDFPanel` is only a surface container. Header, footer, loading, and inspector-specific behavior should be composed by higher-level components.

## ⚠️ Rules

- **DO NOT** import Domain or Data
- **DO NOT** include app-specific or business logic
- **DO NOT** reference specific screens or features
- **DO NOT** grow base components with unrelated optional behavior

## Contributing

When modifying this module:
1. Add SwiftUI Preview for every new component
2. Add usage example to this README
3. Document public APIs with DocC comments
4. Ensure components work in both light and dark mode

See `docs/design-system-foundation.md` for the product-level design direction.
