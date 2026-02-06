# App

Application entry point and dependency injection.

## Structure

```
Sources/
└── IMDFlexApp.swift    # @main entry point
Resources/
└── (assets, configs)
```

## Responsibilities

- App lifecycle management (`@main`)
- Dependency injection setup
- Root view configuration
- App-level configurations (Info.plist settings)

## Dependencies

- Domain
- Data
- Presentation
- DesignSystem

## Guidelines

- Keep this module minimal
- Only wire dependencies here
- No business logic or UI implementation

## ⚠️ Rules

- **DO NOT** add business logic (use Domain)
- **DO NOT** add UI components (use Presentation or DesignSystem)
- **DO NOT** add data handling (use Data)

## Contributing

When modifying this module:
1. Keep dependency injection setup clean and readable
2. Update Info.plist entries via `Project.swift` infoPlist parameter
3. Update this README if adding new app-level configurations
