# All IMDF Feature MVP Plan

This document records the product and implementation plan for expanding IMDFlex MVP support from a core IMDF subset to every Apple IMDF feature collection.

## Source Baseline

- Apple resource page: `https://register.apple.com/resources/imdf/`
- Apple IMDF version shown by the resource page: `1.0.0`
- Apple resource page last update: `October 19, 2021`
- Assets analyzed locally: `/private/tmp/IMDF-assets`
- Validation CSV analyzed: `imdf-validations-1.0.3.csv`
- Category CSV analyzed: `categories_20210728.csv`

Apple IMDF Sandbox and Apple IMDF Validator remain the source of truth. Local implementation and tests are preflight aids only.

## MVP Definition

The MVP should be able to represent, validate locally, and export every Apple IMDF feature collection. Editor UX can stay shallow and manual at first.

In practice, MVP means:

- Every IMDF feature file is present in `imdf.zip`.
- Empty optional collections still export valid GeoJSON `FeatureCollection` files.
- Authored features preserve IDs and references.
- Required geometry/category/reference fields have local model-level preflight checks.
- Advanced topology checks are documented and deferred unless they can be implemented safely without a geometry engine.
- Apple Sandbox/Validator success is not claimed until run against an exported archive.

## Feature Collections

| File | Geometry | Primary required references | MVP authoring tool |
| --- | --- | --- | --- |
| `address.geojson` | `null` | Referenced by `venue` | Form |
| `venue.geojson` | `Polygon` | `address_id` | Polygon |
| `building.geojson` | `null` | Referenced by `footprint` and `level` | Form + display point |
| `footprint.geojson` | `Polygon` | `building_id` | Polygon |
| `level.geojson` | `Polygon` | `building_id` | Polygon |
| `unit.geojson` | `Polygon` | `level_id` | Polygon |
| `opening.geojson` | `LineString` | `level_id` | Line |
| `amenity.geojson` | `Point` | `unit_id` | Point |
| `anchor.geojson` | `Point` | `unit_id` | Point |
| `occupant.geojson` | `null` | `anchor_id` | Form |
| `detail.geojson` | `LineString` | `level_id` | Line |
| `fixture.geojson` | `Polygon` | `level_id`, optional contained anchors | Polygon |
| `geofence.geojson` | `Polygon` | `level_id` or `building_id` | Polygon |
| `kiosk.geojson` | `Polygon` | `level_id`, optional contained anchors | Polygon |
| `relationship.geojson` | `null` | referenced feature IDs | Form |
| `section.geojson` | `Polygon` | `level_id` | Polygon |

## Implementation Order

1. Documentation contract: update agent instructions, migration notes, and schema gap docs around the all-feature MVP.
2. Domain layer: add missing feature entities and containment in existing aggregates.
3. Exporter layer: export every feature file and preserve basic references.
4. Preflight layer: validate missing geometry/category/reference issues for all MVP features.
5. Presentation layer: add feature-type selection and reuse point/line/polygon tools for every feature.

## Commit Strategy

This scope should be committed in reviewable layers:

1. `docs:` all-feature MVP contract.
2. `feat:` Domain entities and model tests.
3. `feat:` exporter support and Data tests.
4. `feat:` preflight support, docs, final verification.

## Deferred Work

- Full polygon containment and coverage validation.
- Self-intersection detection beyond Apple Validator.
- Complete category lists for `amenity` and `occupant`.
- Official confirmation of `relationship.direction` accepted values.
- Official confirmation of `relationship` endpoint property names.
- Rich editor UX for every feature.
- Apple IMDF Sandbox automation.
