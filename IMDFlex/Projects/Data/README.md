# Data

Repository implementations and data sources.

## Structure

```
Sources/
├── Repositories/    # Protocol implementations
└── DataSources/     # File I/O, JSON parsing
```

## Guidelines

- Implement protocols defined in Domain module
- Handle all file system and persistence logic here
- Use `@unchecked Sendable` only when necessary with proper synchronization

### Repositories
- One repository per domain aggregate
- Handle data mapping between storage and domain models

### DataSources
- Keep I/O operations isolated
- Handle encoding/decoding errors gracefully

## Dependencies

- Domain

## Testing Requirements

- **Unit tests are required** for all repositories
- Mock file system for testing
- Test error handling paths

## ⚠️ Rules

- **DO NOT** import Presentation or DesignSystem
- **DO NOT** import SwiftUI
- **DO NOT** expose implementation details to other modules

## Contributing

When modifying this module:
1. Ensure repository implementations match Domain protocols
2. Add unit tests for new repositories or data sources
3. Update this README if adding new folders or patterns
