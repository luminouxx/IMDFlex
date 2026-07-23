# Design System Foundation

This document records the initial IMDFlex design system direction.

## Direction

IMDFlex uses a hybrid editor style:

- Apple Maps-like floating controls on top of the map.
- Denser professional inspector surfaces for repeated IMDF editing.
- System appearance support for light and dark mode.
- iPad and Apple Pencil first, with Mac pointer/keyboard compatibility.

## Layout Principles

- iPad should prefer bottom or contextual floating controls.
- Mac should prefer a left tool rail and right fixed inspector.
- Feature authoring controls should use stable 44 pt icon buttons.
- Inspector and status surfaces should be compact, scannable, and restrained.
- Validation/preflight status should use semantic color roles.

## Initial Tokens

- `IMDFColor`: accent, selection, success, warning, danger, separator, grid line.
- `IMDFSpacing`: fixed spacing scale from 2 to 24.
- `IMDFRadius`: 4, 6, and 8 point radii.
- `IMDFIconSize`: 16, 20, and 24 point icon sizes.
- `IMDFFont`: semantic text styles for badges, tool labels, inspector rows, and panel titles.

## Initial Components

- `IMDFToolButton`: fixed-size icon button for map/editor tools.
- `IMDFStatusBadge`: compact semantic badge for validation and selection state.
- `IMDFPanel`: material-backed floating, inspector, or status surface.

## Deferred Work

- Editor shell layout.
- Feature authoring state integration.
- Category picker/search UI.
- Snapshot testing.
- Platform-specific toolbar/inspector adaptation.
