# IMDF-Generator Migration Notes

IMDFlex continues the product direction from `luminouxx/IMDF-Generator`, but keeps the Tuist-based modular structure already present in this repository.

## Migration Direction

- Keep IMDFlex as the product repository.
- Move concepts from IMDF-Generator into the existing modules:
  - `Domain`: IMDF entities and feature relationships.
  - `Data`: project persistence, GeoJSON serialization, IMDF ZIP export.
  - `Presentation`: project workflow, MapKit editor, image overlay alignment.
- Re-check all IMDF entities against Apple IMDF requirements before treating exported archives as submission-ready.

## MVP Feature Scope

The MVP now targets every Apple IMDF feature collection, while keeping manual authoring depth simple at first:

- `address.geojson`
- `venue.geojson`
- `building.geojson`
- `footprint.geojson`
- `level.geojson`
- `unit.geojson`
- `opening.geojson`
- `amenity.geojson`
- `anchor.geojson`
- `occupant.geojson`
- `detail.geojson`
- `fixture.geojson`
- `geofence.geojson`
- `kiosk.geojson`
- `relationship.geojson`
- `section.geojson`

## Product Workflow

1. Create or open a project.
2. Search an address in Apple Maps.
3. Lock map position, zoom, and orientation.
4. Create levels.
5. Add a floor-plan image overlay per level.
6. Align the overlay by moving, scaling, rotating, and adjusting opacity against the building outline.
7. Edit IMDF features by feature type using point-based drawing tools.
8. Export `imdf.zip`.
9. Run preflight checks and guide Apple IMDF Validator verification.

## Current Migration Status

- Added a ZIP-based `IMDFExporter` foundation that creates the MVP GeoJSON files from the current `Venue` aggregate.
- Fixed the Tuist workspace project path typo from `Project/` to `Projects/`.

## Next Migration Steps

1. Validate the current Domain entity fields against Apple IMDF schema.
2. Add a project-level preflight validator for required feature relationships.
3. Port the IMDF-Generator MapKit point-drawing core into `Presentation/MapEditor`.
4. Port and redesign the image overlay alignment flow for level-specific floor plans.
5. Replace the current nested Domain aggregate with explicit feature repositories if editing complexity grows.

See `docs/all-imdf-feature-mvp-plan.md` for the all-feature MVP implementation plan and `docs/imdf-schema-gap.md` for the current Apple IMDF validation and category gap analysis.
