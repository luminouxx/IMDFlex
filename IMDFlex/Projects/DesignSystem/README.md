# DesignSystem

Shared UI components and design tokens.

## Structure

```
Sources/
├── Components/    # Reusable views (CardView, EmptyStateView, etc.)
├── Styles/        # Button styles, text styles
└── Extensions/    # Color, Font extensions
```

## Guidelines

- Components should be generic and reusable
- Define all colors and styles as static properties
- No business logic in this module

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
    .background(Color.imdfBackground)
```

### Button Style

```swift
Button("Action") { }
    .buttonStyle(.imdf)
```

### CardView

```swift
CardView {
    Text("Content inside card")
}
```

### EmptyStateView

```swift
EmptyStateView(
    title: "No Projects",
    message: "Create a new project to get started",
    systemImage: "map"
)
```

## ⚠️ Rules

- **DO NOT** import Domain or Data
- **DO NOT** include app-specific or business logic
- **DO NOT** reference specific screens or features

## Contributing

When modifying this module:
1. Add SwiftUI Preview for every new component
2. Add usage example to this README
3. Document public APIs with DocC comments
4. Ensure components work in both light and dark mode
