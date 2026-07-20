# IMDF Schema Gap

This document tracks gaps between IMDFlex's current Domain/export model and Apple's official IMDF resources. The MVP scope now includes every Apple IMDF feature collection, with shallow manual authoring first.

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

- Use curated Swift enums as common presets and `IMDFCategoryCatalog` as the full Apple raw-value foundation.
- Add UI-facing labels separate from IMDF raw values.
- Continue adding tests when new category presets are introduced.

See `docs/imdf-category-catalog.md` for the category catalog strategy.

### 6. Occupant Requires Anchor

Apple validation includes:

- `OccupantMustReferenceAnchor`
- `OccupantMustHaveCategory`
- `OccupantMustHaveName`

Current MVP scope includes `occupant` and now includes local `anchor` support. `Occupant` stores an optional `anchorID`, `Unit` owns anchors, and the exporter writes `anchor.geojson` plus `occupant.properties.anchor_id`.

Remaining direction:

- Confirm exported `anchor` and `occupant` relationships with Apple IMDF Sandbox.
- Add topology checks for anchor coverage by the referenced unit.
- Decide whether anchors can later be reused by fixtures, kiosks, or other IMDF features.

### 7. Remaining IMDF Feature Collections Are Now MVP Scope

Apple validation includes rules for these feature collections that were not part of the original core MVP:

- `Detail`: `DetailMustHaveLinealGeometry`, `DetailMustReferenceLevel`
- `Fixture`: `FixtureMustHavePolygonalGeometry`, `FixtureMustReferenceLevel`, `FixtureMustHaveCategory`
- `Geofence`: `GeofenceMustHavePolygonalGeometry`, `GeofenceMustHaveCategory`, `GeofenceMustHaveLevelOrBuildingReference`
- `Kiosk`: `KioskMustHavePolygonalGeometry`, `KioskMustReferenceLevel`
- `Relationship`: `RelationshipMustHaveCategory`, `RelationshipCategoryMustBeValid`, `RelationshipDirectionMustBeValid`
- `Section`: `SectionMustHavePolygonalGeometry`, `SectionMustReferenceLevel`, `SectionMustHaveCategory`

Current Domain/export support for these features is implemented as shallow MVP coverage. Local preflight checks basic geometry and relationship endpoint resolution. Full topology validations such as feature coverage, display point containment, and anchor containment remain Apple Validator confirmation work.

## Feature-Level Gap Table

| Feature | Current Status | Validator-Risk Gap | Priority |
| --- | --- | --- | --- |
| Manifest | Export exists locally | Sandbox confirmation pending | P0 |
| Address | Basic model exists | ISO country/province fields and reference semantics need review | P1 |
| Venue | Model/export exists locally | Display point containment and coverage pending | P1 |
| Building | Model/export exists locally | Display point containment and relationship preflight pending | P1 |
| Footprint | Model/export exists locally | Topology rules pending | P1 |
| Level | Model/export exists locally | Coverage by units and containment pending | P1 |
| Unit | Model/export exists locally | Level containment and accessibility/restriction expansion pending | P1 |
| Opening | Model/export exists locally | Unit boundary coverage and door metadata pending | P1 |
| Amenity | Model exists | Coordinate optional but point geometry required; category values incomplete | P1 |
| Occupant | Model exists with anchor reference | Category values incomplete; Sandbox confirmation pending | P1 |
| Anchor | Model and export exist locally | Coverage by referenced unit not yet checked locally | P1 |
| Detail | Model/export/preflight exists locally | Topology and Sandbox confirmation pending | P1 |
| Fixture | Model/export/preflight exists locally | Anchor containment and Sandbox confirmation pending | P1 |
| Geofence | Model/export/preflight exists locally | Level/building reference strategy and Sandbox confirmation pending | P1 |
| Kiosk | Model/export/preflight exists locally | Anchor containment and Sandbox confirmation pending | P1 |
| Relationship | Model/export/preflight exists locally | Direction/property names need official Validator confirmation | P1 |
| Section | Model/export/preflight exists locally | Coverage/display point containment pending | P1 |

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

1. Keep existing core feature export and tests. Done locally; Apple Sandbox confirmation pending.
2. Add all-feature MVP contract documentation. Done locally.
3. Add Domain models for `detail`, `fixture`, `geofence`, `kiosk`, `relationship`, and `section`. Done locally.
4. Extend `IMDFExporter` to write every IMDF feature collection. Done locally.
5. Extend local preflight to cover required geometry, category, and references for all MVP features. Done locally for model-level checks.
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
- Occupant references an anchor.
- Occupant anchor reference resolves to an anchor in the same unit.
- Detail has enough coordinates to form a line.
- Fixture has enough coordinates to form a polygon.
- Geofence has enough coordinates to form a polygon.
- Kiosk has enough coordinates to form a polygon.
- Section has enough coordinates to form a polygon.
- Relationship origin/destination references resolve to authored features.
- Relationship origin and destination are not the same feature.

The preflight validator intentionally does not yet prove:

- Venue polygon covers all child features.
- Display points are contained by their parent polygons.
- Level/unit/footprint coverage is topologically correct.
- Fixture/kiosk anchor containment is topologically correct.
- Relationship property names and direction values are accepted by Apple IMDF Validator.
- Apple IMDF Sandbox acceptance.

## Open Questions

- Should `Venue` polygon be drawn directly by the user, derived from building footprints, or both?
- Should `Level` polygon be copied from the building footprint by default?
- Should anchors be shared only inside a unit, or should future editor tools surface a broader anchor management concept?
- Should full Apple category lists be modeled as enums, or should the app store raw category strings plus curated presets?
