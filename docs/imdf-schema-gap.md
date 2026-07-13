# IMDF Schema Gap

This document tracks gaps between IMDFlex's current Domain/export model and Apple's official IMDF resources.

## Source Baseline

- Official resource page: `https://register.apple.com/resources/imdf/`
- IMDF version shown by Apple page: `1.0.0`
- Last update shown by Apple page: `October 19, 2021`
- Asset ZIP analyzed: `IMDF.zip`
- Validation CSV analyzed: `imdf-validations-1.0.3.csv`
- Category CSV analyzed: `categories_20210728.csv`

## Highest-Risk Gaps

### 1. Manifest Export Is Present, Validator Confirmation Pending

Apple validation includes:

- `ManifestFileMustBePresent`
- `ManifestVersionMustBeValid`

Current `IMDFExporter` writes `manifest.json` with IMDF version `1.0.0`.

Remaining direction:

- Keep tests that exported ZIP archives contain `manifest.json`.
- Confirm the generated archive in Apple IMDF Sandbox before claiming official submission readiness.

### 2. Venue Geometry Needs Apple Sandbox Confirmation

Apple validation includes:

- `VenueMustHavePolygonalGeometry`
- `VenueGeometryMustContainDisplayPoint`
- `VenueMustCoverAllChildFeatures`
- `VenueMustHaveAddress`
- `VenueMustHaveAtLeastOneBuilding`

Current exporter emits polygonal `venue.geojson` geometry. The Domain model supports explicit venue coordinates, and the exporter falls back to an enclosing polygon derived from building footprints for legacy/project bootstrap data.

Remaining direction:

- Validate fallback-derived venue geometry in Apple IMDF Sandbox.
- Add preflight issues for missing venue coordinates, missing address, and missing buildings.
- Keep `address_id` and building coverage relationships valid.

### 3. Level Geometry And Category Are Present, Coverage Rules Pending

Apple validation includes:

- `LevelMustHavePolygonalGeometry`
- `LevelMustHaveCategory`
- `LevelMustHaveName`
- `LevelMustHaveShortName`
- `LevelMustHaveOrdinal`
- `LevelMustBeReferencedByUnit`

Current `Level` has `name`, `ordinal`, optional `shortName`, `category`, and polygon coordinates. The exporter falls back to the building footprint when level coordinates are not explicitly provided.

Remaining direction:

- Make `shortName` required before export or enforce it in preflight.
- Ensure every exported level is referenced by at least one unit.
- Validate level/footprint coverage behavior in Apple IMDF Sandbox.

### 4. Building And Footprint Categories Are Present, Relationship Preflight Pending

Apple validation includes:

- `BuildingMustHaveCategory`
- `BuildingCategoryMustBeValid`
- `BuildingMustHaveAtLeastOneFootprint`
- `FootprintCategoryMustBeValid`
- `FootprintMustHavePolygonalGeometry`
- `FootprintMustReferenceBuilding`

Current `Building` has an Apple category value. Current `Footprint` has an Apple category value and polygon geometry.

Remaining direction:

- Keep footprint-to-building references explicit in exporter and preflight validation.
- Add preflight issues for buildings without footprints and footprints without valid polygon geometry.

### 5. Remaining Category Coverage Needs Apple IMDF Review

MVP category enum raw values are being aligned to Apple IMDF values. Core categories and curated MVP presets for `Unit`, `Opening`, `AccessControl`, `Amenity`, and `Occupant` now use Apple category CSV values where represented.

Resolved examples:

- `VenueCategory.shoppingCenter` exports `shoppingcenter`.
- `VenueCategory.parkingFacility` exports `parkingfacility`.
- `UnitCategory.foodService` exports `foodservice`.
- `OpeningCategory.emergencyExit` exports `emergencyexit`.
- `AccessControl.keyAccess` exports `keyaccess`.
- Amenity presets use Apple compact/dot values such as `restroom.male`, `drinkingfountain`, `powerchargingstation`, and `firstaid`.
- Occupant presets map to Apple category values such as `shopping`, `corporateoffices`, `medicalcenter`, `publicservices.government`, `arts.entertainment`, and `localservices`.

Remaining direction:

- Decide whether full Apple category lists should be modeled as enums, raw strings, or curated presets.
- Add UI-facing labels separate from IMDF raw values.
- Continue adding tests when new category presets are introduced.

### 6. Occupant Requires Anchor

Apple validation includes:

- `OccupantMustReferenceAnchor`
- `OccupantMustHaveCategory`
- `OccupantMustHaveName`

Current MVP scope includes `occupant` but not `anchor`. Current `Occupant` has no anchor reference, and current exporter writes `unit_id` instead.

Required direction:

- Decide whether MVP includes `anchor`.
- If `occupant` remains in MVP, add `Anchor` Domain model and `anchor.geojson` export.
- If `anchor` is deferred, defer `occupant` from Apple-submission MVP export.

## Feature-Level Gap Table

| Feature | Current Status | Validator-Risk Gap | Priority |
| --- | --- | --- | --- |
| Manifest | Not exported | Required manifest missing | P0 |
| Address | Basic model exists | ISO country/province fields and reference semantics need review | P1 |
| Venue | Model exists | Missing polygon geometry and display point | P0 |
| Building | Model exists | Missing category; must have footprint and level references | P0 |
| Footprint | Model exists | Missing category | P0 |
| Level | Model exists | Missing polygon geometry and category; short name optional | P0 |
| Unit | Model exists | Category values need Apple alignment; level containment needs preflight | P1 |
| Opening | Model exists | Category/access-control values need Apple alignment | P1 |
| Amenity | Model exists | Coordinate optional but point geometry required; category values incomplete | P1 |
| Occupant | Model exists | Requires anchor reference; category values incomplete | P0 decision |
| Anchor | Not in MVP model | Required if exporting occupants | P0 decision |

## Apple Category Baseline For MVP

Use Apple category values as raw export values.

### Venue

`airport`, `airport.intl`, `aquarium`, `businesscampus`, `casino`, `communitycenter`, `conventioncenter`, `governmentfacility`, `healthcarefacility`, `hotel`, `museum`, `parkingfacility`, `resort`, `retailstore`, `shoppingcenter`, `stadium`, `stripmall`, `theater`, `themepark`, `trainstation`, `transitstation`, `university`

### Building

`parking`, `transit`, `transit.bus`, `transit.train`, `unspecified`

### Footprint

`aerial`, `ground`, `subterranean`

### Level

`arrivals`, `arrivals.domestic`, `arrivals.intl`, `departures`, `departures.domestic`, `departures.intl`, `parking`, `transit`, `unspecified`

### Opening

`automobile`, `bicycle`, `emergencyexit`, `pedestrian`, `pedestrian.principal`, `pedestrian.transit`, `service`

### Access Control

`badgereader`, `fingerprintreader`, `guard`, `keyaccess`, `outofservice`, `passwordaccess`, `retinascanner`, `voicerecognition`

## Recommended Implementation Order

1. Add `manifest.json` export and tests. Done locally; Apple Sandbox confirmation pending.
2. Add explicit geometry/category fields for `Venue`, `Building`, `Footprint`, and `Level`. Done locally; Apple Sandbox confirmation pending.
3. Align remaining MVP category enums with Apple category CSV raw values. Curated MVP presets are aligned locally; full category strategy remains open.
4. Add a preflight validator for required relationships and required geometry. Started locally with model-level required data checks.
5. Decide `Occupant + Anchor` scope before exporting occupants as Apple-submission data.
6. Add module tests:
   - `Domain`: entity construction and category raw values.
   - `Data`: exported ZIP file list and GeoJSON structure.
   - `Data`: relationship references and coordinate order.
   - `Presentation`: later, editor tools should produce valid Domain geometry.

## Local Preflight Scope

`IMDFPreflightValidator` is a local authoring aid, not a replacement for Apple IMDF Sandbox or Apple IMDF Validator.

The first local preflight pass checks model-level issues that can be detected without full GeoJSON topology:

- Venue has explicit polygon coordinates.
- Venue references an address.
- Venue has at least one building.
- Building has a footprint.
- Footprint has enough coordinates to form a polygon.
- Level has a short name.
- Level has explicit polygon coordinates or a valid building footprint fallback.
- Level has at least one unit.
- Unit has enough coordinates to form a polygon.
- Occupant has a category.
- Occupant export is blocked until anchor support exists.

The preflight validator intentionally does not yet prove:

- Venue polygon covers all child features.
- Display points are contained by their parent polygons.
- Level/unit/footprint coverage is topologically correct.
- Apple IMDF Sandbox acceptance.

## Open Questions

- Should `Venue` polygon be drawn directly by the user, derived from building footprints, or both?
- Should `Level` polygon be copied from the building footprint by default?
- Should `Occupant` be deferred until `Anchor` is implemented?
- Should full Apple category lists be modeled as enums, or should the app store raw category strings plus curated presets?
