# Presentation

UI screens and view logic.

## Structure

```
Sources/
├── MapEditor/      # Map editing screen
└── ProjectList/    # Project list screen
```

## Guidelines

### Views
- Use SwiftUI for all views
- Keep views focused on UI rendering
- Inject UseCases via initializer

### ViewModels (if needed)
- Use `@Observable` for state management
- Keep business logic in UseCases, not ViewModels

## Dependencies

- Domain
- DesignSystem

## Testing Requirements

- **SwiftUI Previews are required** for all views
- **Unit tests are required** for ViewModels and screen logic
- Test user interaction flows

## ⚠️ Rules

- **DO NOT** import Data module directly
- **DO NOT** access file system or persistence
- **DO NOT** instantiate repositories (use injected UseCases)

## Contributing

When modifying this module:
1. Add SwiftUI Preview for every new view
2. Add unit tests for ViewModel logic
3. Use DesignSystem components instead of custom styles
4. Update this README if adding new screens or patterns
