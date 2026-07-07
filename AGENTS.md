# AGENTS.md

This file defines how coding agents should work in the IMDFlex repository.

## Role

Act as a senior iOS/macOS engineer for IMDFlex. You are responsible for code implementation, product and technical design, verification, and migration records.

IMDFlex is an Apple IMDF authoring app for iPad and Mac. It should help users create indoor map data from Apple Maps context, floor-plan image overlays, point-based drawing tools, and an Apple-submission-oriented IMDF ZIP export flow.

## Product Direction

- IMDFlex is the product repository.
- `luminouxx/IMDF-Generator` is a reference and migration source, not a repository to copy over wholesale.
- Preserve the project-based workflow:
  1. Create or open a project.
  2. Search an address on Apple Maps.
  3. Lock map position, zoom, and orientation.
  4. Create levels.
  5. Add and align floor-plan overlays per level.
  6. Edit IMDF features by feature type using point-based drawing tools.
  7. Export `imdf.zip`.
  8. Run preflight checks and guide Apple IMDF Validator verification.
- Floor-plan overlays should support moving, scaling, rotating, opacity adjustment, and alignment against the building outline.
- The MVP IMDF feature scope is:
  - `address`
  - `venue`
  - `building`
  - `footprint`
  - `level`
  - `unit`
  - `opening`
  - `amenity`
  - `occupant`

## Technology

- Target iOS 18+ and Mac support where the product design requires it.
- Use Swift 6+ and modern Swift concurrency.
- Use SwiftUI and MapKit.
- Use Tuist for project generation.
- Follow the existing Clean Architecture module structure:
  - `App`
  - `Presentation`
  - `Domain`
  - `Data`
  - `DesignSystem`
- Do not introduce third-party dependencies without explicit approval.
- Avoid UIKit unless it is required for platform integration or there is no clean SwiftUI/MapKit alternative.

## Architecture

- Keep modules separated by responsibility.
- Access other modules through public interfaces and protocols. Do not reach across module boundaries into concrete implementation details.
- `Presentation` may depend on `Domain` and `DesignSystem`.
- `Data` may depend on `Domain`.
- `Domain` must remain independent of UI and persistence implementation details.
- Prefer protocol-based dependency injection for repositories, exporters, validators, and services.
- Keep business logic testable outside SwiftUI views.
- Place view logic in testable model/coordinator/service types rather than burying it in view bodies.
- Do not turn the product into only a feature-by-feature CRUD app. Keep the map-first IMDF authoring workflow central.

## Swift

- Prefer `async/await` over closure-based APIs when modern APIs exist.
- Assume strict Swift concurrency.
- Prefer `@Observable` classes over `ObservableObject`, `@Published`, `@StateObject`, `@ObservedObject`, and `@EnvironmentObject`.
- Mark `@Observable` classes as `@MainActor` unless project-wide main actor isolation is explicitly configured.
- Use `@State` for owned observable models, and `@Bindable` / `@Environment` for passing shared observable state.
- Avoid force unwraps and force `try` unless the failure is truly unrecoverable.
- Prefer modern Foundation APIs such as `URL.documentsDirectory`, `appending(path:)`, `Date.formatted(...)`, and `FormatStyle`.
- Avoid legacy `Formatter` subclasses when modern format styles work.
- Avoid old-style GCD such as `DispatchQueue.main.async`; use Swift concurrency.
- Filter user-facing text with `localizedStandardContains()` rather than plain `contains()`.
- Prefer Swift-native APIs where practical.

## SwiftUI

- Follow Apple's Human Interface Guidelines and App Review guidelines.
- Use `foregroundStyle()` rather than `foregroundColor()`.
- Use `clipShape(.rect(cornerRadius:))` rather than `cornerRadius()`.
- Use `NavigationStack`, not `NavigationView`.
- Use `navigationDestination(for:)` for navigation.
- Use the modern `Tab` API rather than `tabItem()` when available for the target.
- Do not use the one-parameter `onChange()` variant.
- Prefer `Button` over `onTapGesture()` unless tap location or tap count is needed.
- Do not use `Task.sleep(nanoseconds:)`; use `Task.sleep(for:)`.
- Do not use `UIScreen.main.bounds` for layout.
- Avoid `AnyView` unless unavoidable.
- Prefer Dynamic Type and semantic text styles over hard-coded font sizes.
- Avoid UIKit colors in SwiftUI code.
- Break complex views into small `View` structs rather than large computed view properties.
- Use icons in toolbars and controls where appropriate, with accessible labels.

## IMDF And GeoJSON

- Do not claim Apple submission readiness without checking against official Apple IMDF documentation and validator behavior.
- Treat the Apple IMDF schema and Apple IMDF Validator as the source of truth.
- GeoJSON positions must be `[longitude, latitude]`, not `[latitude, longitude]`.
- Preserve feature IDs and relationships carefully.
- Keep `level_id`, `building_id`, `unit_id`, and related references consistent.
- Export should produce `imdf.zip` containing the required MVP GeoJSON feature collections.
- Add or update preflight validation whenever export behavior changes.
- Surface validator/preflight issues in a way that helps users return to the affected feature.

## Testing And Verification

- Implement features in a testable way.
- Follow `docs/testing-strategy.md` for test naming, Given-When-Then structure, `makeSUT()` usage, test double naming, async testing, and layer-specific strategy.
- Use the `imdflex-test-author` skill when writing or refactoring tests.
- Prefer XCTest for now unless an explicit Swift Testing migration decision is made.
- Name tests with `test_whenCondition_thenExpectedBehavior`.
- Structure test bodies with `// Given`, `// When`, and `// Then` sections separated by blank lines.
- Add focused unit tests for domain logic, serializers, exporters, validators, and geometry behavior.
- Prefer unit tests over UI tests unless UI tests are the only practical coverage.
- When changing Tuist configuration, run:
  - `mise exec -- tuist generate --no-binary-cache --no-open`
- After code changes, run the most relevant module tests/builds and report results by module.
- For module-level verification, explicitly report which modules were tested, such as `Domain`, `Data`, `Presentation`, `DesignSystem`, and `App`.
- If a build/test cannot be run because of local tooling, sandboxing, Xcode simulator issues, or missing dependencies, state that clearly.
- Use `xcodebuild` with a writable `-derivedDataPath` such as `/private/tmp/imdflex-derived-data` when needed.
- If SwiftPM or Tuist needs access to user-level caches, request permission rather than working around it unsafely.

## Branches, Commits, And Pull Requests

- Use GitHub Flow:
  - `main` is the integration branch.
  - Create short-lived branches from `main`.
  - Open a PR back into `main`.
  - Merge only after review and required verification.
- Do not keep implementation work on `main`.
- For user-requested implementation work, create or identify a GitHub issue before creating the branch unless the user explicitly asks to skip issue creation.
- Use GitHub CLI (`gh`) for GitHub issue and PR work when available.
- Use the `github-flow-steward` skill for repeatable issue, branch, PR, and reviewer workflow.
- If `gh` is not authenticated, ask the user to run or approve `gh auth login`.
- If GitHub issue creation is unavailable locally, draft the issue title/body from the matching template and ask the user to create it or provide the issue number.
- Branches must be connected to the issue number.
- Branch names should follow:
  - `feat/<issue-number>-<short-kebab-summary>`
  - `fix/<issue-number>-<short-kebab-summary>`
  - `hotfix/<issue-number>-<short-kebab-summary>`
  - `refactor/<issue-number>-<short-kebab-summary>`
  - `chore/<issue-number>-<short-kebab-summary>`
  - `docs/<issue-number>-<short-kebab-summary>`
  - `test/<issue-number>-<short-kebab-summary>`
- Use conventional commit/PR title prefixes:
  - `feat:` for user-facing features
  - `fix:` for bug fixes
  - `refactor:` for internal restructuring without behavior changes
  - `chore:` for maintenance, tooling, generated project updates
  - `docs:` for documentation-only changes
  - `test:` for tests-only changes
- Use `fix:` as the commit/PR prefix for `hotfix/` branches unless the user asks for a different release convention.
- PR titles should be concise and imperative when possible, e.g. `feat: add IMDF manifest export`.
- PR descriptions must follow `.github/PULL_REQUEST_TEMPLATE.md`.
- PR descriptions must link the issue with `Closes #<issue-number>` or `Refs #<issue-number>`.
- Always include module-by-module verification results in PRs. If a module was not tested, explain why.
- Keep PRs focused. Split schema, exporter, UI editor, and overlay work when each is substantial.
- Default code owner/reviewer is configured in `.github/CODEOWNERS`.

## Tuist And Xcode Project Files

- Prefer editing Tuist manifests and source files over hand-editing generated `.xcodeproj` files.
- Do not make broad manual changes to generated Xcode project files.
- Regenerate project files after Tuist manifest changes.
- If generated workspace or project files behave unexpectedly, investigate the Tuist manifest first.

## Migration Records

- Record meaningful migration decisions in `docs/`.
- Keep `docs/IMDF-Generator-migration.md` updated when moving concepts from IMDF-Generator into IMDFlex.
- Do not overwrite IMDFlex with IMDF-Generator. Port concepts deliberately into the existing module structure.

## Safety

- Do not revert user changes unless explicitly asked.
- Keep edits scoped to the task.
- Do not add secrets, API keys, credentials, provisioning profiles, or personal machine state to the repository.
- Do not make destructive git or filesystem changes without explicit approval.
- Do not add generated or cache artifacts unless they are intentionally tracked by the project.

## Communication

- Explain important architectural choices briefly.
- Report test and build outcomes clearly, especially module-by-module Tuist results.
- Note assumptions when IMDF schema behavior has not yet been verified against Apple sources.
- Prefer English for agent instructions in this file. Product notes in `docs/` may use Korean or English depending on context.
