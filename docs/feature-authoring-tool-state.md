# Feature Authoring Tool State

This document records the first Presentation-layer authoring contract for IMDFlex.

## Purpose

`FeatureAuthoringToolState` defines what the editor is currently authoring before MapKit gestures or concrete Domain mutations are added.

The state is intentionally UI-independent and small:

- selected IMDF feature
- authoring geometry
- drafted point count
- category selection status
- required reference satisfaction
- finish/cancel behavior

It should not own MapKit camera state, selected Domain objects, category picker search, or persistence.

## Geometry Modes

| Geometry | Minimum drafted points | Examples |
| --- | ---: | --- |
| `point` | 1 | `amenity`, `anchor` |
| `line` | 2 | `opening`, `detail` |
| `polygon` | 3 | `venue`, `unit`, `fixture`, `section` |
| `form` | 0 | `address`, `building`, `occupant`, `relationship` |

## Feature Contracts

| Feature | Geometry | Category | Required references |
| --- | --- | --- | --- |
| `address` | `form` | No | None |
| `venue` | `polygon` | `venue` | None |
| `building` | `form` | `building` | None |
| `footprint` | `polygon` | `footprint` | `building` |
| `level` | `polygon` | `level` | `building` |
| `unit` | `polygon` | `unit` | `level` |
| `opening` | `line` | `opening` | `level` |
| `amenity` | `point` | `amenity` | `unit` |
| `anchor` | `point` | No | `unit` |
| `occupant` | `form` | `occupant` | `anchor` |
| `detail` | `line` | No | `level` |
| `fixture` | `polygon` | `fixture` | `level` |
| `geofence` | `polygon` | `geofence` | `levelOrBuilding` |
| `kiosk` | `polygon` | No | `level` |
| `relationship` | `form` | `relationship` | `relationshipEndpoints` |
| `section` | `polygon` | `section` | `level` |

## Progressive Disclosure

This model should stay focused. Add complexity through adjacent models instead of growing one large editor object:

- Category picker/search belongs in a category picker model.
- Map point storage belongs in a drawing draft model.
- Domain feature mutation belongs in an editor use case/coordinator.
- Inspector field editing belongs in feature-specific inspector state.

## Next Steps

1. Build an editor shell that reads `IMDFAuthoringFeature` and `IMDFAuthoringGeometry`.
2. Add a category picker model that uses `categoryFeature`.
3. Add a drawing draft model for point/line/polygon coordinates.
4. Connect completed drafts to Domain feature creation.
