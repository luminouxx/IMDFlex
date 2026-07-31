# Drawing Draft State

This document records the first coordinate-based drawing draft boundary for IMDFlex.

## Purpose

`DrawingDraftState` represents the in-progress geometry that a user is authoring before it becomes a Domain IMDF feature.

The model is intentionally Presentation-layer state:

- It stores draft coordinates.
- It validates geometry readiness.
- It can produce a draft result.
- It does not create Domain features.
- It does not serialize GeoJSON.
- It does not own MapKit gesture recognition.

## Coordinate Order

`IMDFDraftCoordinate` stores coordinates as:

- `longitude`
- `latitude`

Its `geoJSONPosition` returns `[longitude, latitude]`.

This mirrors GeoJSON position order and keeps IMDFlex from accidentally treating positions as `[latitude, longitude]` later.

## Geometry Readiness

The draft follows `IMDFAuthoringGeometry.minimumPointCount`:

| Geometry | Minimum coordinates | Notes |
| --- | ---: | --- |
| `point` | 1 | A single tapped coordinate. |
| `line` | 2 | A connected line draft. |
| `polygon` | 3 | A polygon ring draft, not closed by this model yet. |
| `form` | 0 | Metadata-only authoring; coordinates are ignored. |

`DrawingDraftState.finish()` returns `nil` until the minimum coordinate count is satisfied.

## Authoring Integration

`FeatureAuthoringToolState` now owns a `DrawingDraftState`.

The authoring state still owns IMDF workflow readiness:

- selected feature
- category readiness
- required references
- combined finish readiness

The drawing draft owns only geometry readiness:

- selected geometry
- coordinate list
- point count
- finish result

This keeps category/reference rules separate from map coordinate drafting.

## Deferred Work

The current draft model intentionally leaves these for follow-up PRs:

- MapKit tap/drag gesture capture.
- Snapping or grid alignment.
- Polygon ring closing behavior.
- Undo/redo stacks.
- Coordinate projection or overlay transform handling.
- Domain feature creation.
- GeoJSON serialization.
- Apple IMDF Validator or preflight integration.

## Next Step

The next natural PR is to connect MapKit tap gestures to `appendDraftCoordinate(_:)`, converting map tap locations into `IMDFDraftCoordinate` values.
