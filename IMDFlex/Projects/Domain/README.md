# Domain

Core business logic and IMDF entity definitions.

## Structure

```
Sources/
├── Entities/    # IMDF data models
└── UseCases/    # Business logic & repository protocols
```

## Guidelines

### Entities
- All entities must conform to `Identifiable`, `Codable`, `Sendable`
- Use `UUID` for all identifiers
- Keep entities as pure data structures (no business logic)

### UseCases
- Define repository protocols here (implemented in Data module)
- UseCase classes should be `final` and `Sendable`
- Inject dependencies via initializer

## Dependencies

- None (this is the innermost layer)

## Testing Requirements

- **Unit tests are required** for all UseCases
- Test business logic independently from Data layer
- Use mock repositories for testing

## ⚠️ Rules

- **DO NOT** import Data, Presentation, or DesignSystem
- **DO NOT** import UIKit or SwiftUI
- **DO NOT** add external dependencies without discussion

## Contributing

When modifying this module:
1. Ensure all entities remain `Sendable`
2. Update or add unit tests for UseCase changes
3. Update this README if adding new folders or patterns
4. Document public APIs with DocC comments
