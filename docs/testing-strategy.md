# Testing Strategy

This document defines how IMDFlex tests should be written and reviewed.

## Goals

IMDFlex tests should be valuable, fast, independent, repeatable, self-validating, and useful as executable documentation. Prefer a smaller set of meaningful tests over broad coverage that is tightly coupled to implementation details.

Use tests to protect the parts of the product that are hardest to verify manually:

- IMDF Domain model contracts and relationships.
- GeoJSON serialization and coordinate order.
- ZIP export structure.
- Preflight validation rules.
- Drawing/editor state transitions once Presentation models are introduced.

## Framework

Use XCTest for now. IMDFlex targets iOS 18+ and Swift 6+, so Swift Testing can be revisited later, but do not mix frameworks casually inside the same module without an explicit migration decision.

## Naming

Use `test_whenCondition_thenExpectedBehavior`.

Examples:

```swift
func test_whenVenueIsExported_thenArchiveIncludesManifestAndMVPGeoJSONFiles() async throws
func test_whenProjectIsUpdated_thenUpdatedAtIsRefreshedAndContentIsPreserved() async throws
```

Avoid names such as `testExport()` or `testAdd()`. The test name should explain the failure before opening the file.

## Given-When-Then

Structure XCTest bodies with comments and blank lines:

```swift
func test_whenItemIsAdded_thenCountIncreasesByOne() {
    // Given
    let sut = makeSUT()
    let item = Item.fixture()

    // When
    sut.add(item)

    // Then
    XCTAssertEqual(sut.items.count, 1)
}
```

Prefer this style over wrapping every phase in helper functions. Helpers are useful, but they should not hide the facts that make the scenario meaningful.

## makeSUT

Use `makeSUT()` for the primary system under test and default collaborators:

```swift
private func makeSUT(
    repository: ProjectRepositoryProtocol = InMemoryProjectRepositoryFake()
) -> ProjectUseCase {
    ProjectUseCase(repository: repository)
}
```

When the test needs both the SUT and a collaborator for assertions, returning a labeled tuple is acceptable:

```swift
private func makeSUT() -> (sut: ProjectUseCase, repository: InMemoryProjectRepositoryFake)
```

Use memory leak tracking for class-based SUTs when lifecycle risk appears:

```swift
func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
        XCTAssertNil(instance, "Expected instance to be deallocated.", file: file, line: line)
    }
}
```

## Test Doubles

Name test doubles precisely:

- `Stub`: returns prepared values.
- `Spy`: records calls, counts, or arguments.
- `Mock`: verifies expected interactions.
- `Fake`: lightweight working implementation unsuitable for production.

Do not call every test double a mock. Prefer real Domain objects when they keep the test simpler and more realistic.

## Layer Strategy

### Domain

Test pure entities, value semantics, category raw values, geometry rules, and use case contracts. Mocking should be rare. In-memory fakes are acceptable for protocol-backed use cases.

### Data

Test repository behavior, serializers, exporters, ZIP structure, GeoJSON shape, category raw values, relationship IDs, and coordinate order. These tests should assert IMDF contracts, not private implementation details.

### Presentation

Test observable state models, coordinators, editor state machines, drawing tools, and async user flows. Public APIs should be awaitable whenever possible. Avoid hidden `Task {}` timing that forces sleeps or flaky expectations.

### DesignSystem And App

Prefer build verification unless there is meaningful behavior to test. Snapshot testing for SwiftUI views can be considered later with explicit dependency approval.

## Async Tests

Prefer awaitable public APIs:

```swift
await sut.loadVenues()
XCTAssertEqual(sut.venues.count, 3)
```

Avoid tests that assert immediately after starting hidden work:

```swift
sut.loadVenues()
XCTAssertEqual(sut.venues.count, 3)
```

If behavior depends on time, inject a clock rather than using sleeps.

## Contract Tests

When multiple production implementations conform to the same protocol, add shared contract tests where practical. This is especially useful for repositories, exporters, validators, and cache-backed data sources.

## TestSupport Module

Do not add a shared TestSupport module yet. Once Domain/Data/Presentation tests start duplicating fixtures, ZIP readers, geometry assertions, memory leak tracking, or test doubles, create a dedicated Tuist `TestSupport` module and move shared test-only helpers there.

Until then, keep helpers private to their test file or test target.

## Verification

Report verification by module in PRs:

- `Domain`: tested or not run, with reason.
- `Data`: tested or not run, with reason.
- `Presentation`: tested or not run, with reason.
- `DesignSystem`: tested or not run, with reason.
- `App`: built or not run, with reason.

When Apple IMDF export behavior changes, local tests are not enough. State whether Apple IMDF Sandbox / Validator was run manually.
