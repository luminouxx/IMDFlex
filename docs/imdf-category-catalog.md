# IMDF Category Catalog Strategy

This document records how IMDFlex should use Apple's `categories_20210728.csv`.

## Source

- Source file reviewed locally: `/Users/luminoux/Downloads/IMDF/categories_20210728.csv`
- CSV columns: `collection`, `venueType`, `feature`, `category`, `definition`
- Official Apple resource baseline remains `https://register.apple.com/resources/imdf/`

Do not claim Apple submission readiness from this file alone. Apple IMDF Validator remains the source of truth for final acceptance.

## Feature Counts

The CSV contains these distinct category counts by `feature`:

| Feature | Count |
| --- | ---: |
| `access-control` | 8 |
| `accessibility` | 10 |
| `amenity` | 172 |
| `building` | 5 |
| `door` | 11 |
| `door-material` | 4 |
| `fixture` | 15 |
| `footprint` | 3 |
| `geofence` | 8 |
| `level` | 9 |
| `occupant` | 1116 |
| `opening` | 7 |
| `relationship` | 7 |
| `restriction` | 2 |
| `section` | 71 |
| `unit` | 63 |
| `venue` | 22 |

## Strategy

Use two layers:

1. Curated Swift enums for common presets already used by Domain models and tests.
2. `IMDFCategoryCatalog` for the full Apple category universe and future picker/search UI.

This avoids generating huge Swift enums for sets such as `occupant` while still keeping Apple raw values available for validation and selection.

## Current Implementation

`IMDFCategoryCatalog` currently provides:

- `IMDFCategoryFeature`: feature/category collection identifiers.
- `IMDFCategoryEntry`: a feature-scoped raw category value plus optional definition.
- `IMDFCategoryCatalog`: lookup by feature and raw value.
- `IMDFCategoryCatalogSource.appleCategories20210728FeatureSummaries`: official count summaries and representative values used by tests.

The full catalog is stored as generated JSON:

- Resource: `IMDFlex/Projects/Data/Resources/IMDFCategoryCatalog.generated.json`
- Loader: `IMDFCategoryCatalogJSONLoader`
- Generated distinct entries: 1,533

Regenerate it from the Apple CSV with:

```bash
python3 scripts/generate_imdf_category_catalog_json.py \
  /Users/luminoux/Downloads/IMDF/categories_20210728.csv \
  IMDFlex/Projects/Data/Resources/IMDFCategoryCatalog.generated.json
```

## Next Steps

1. Let Presentation category pickers query the catalog by feature type.
2. Add search/filter behavior using `localizedStandardContains()` for user-facing category selection.
3. Gradually allow Domain feature categories to preserve raw strings in addition to curated enum presets.
