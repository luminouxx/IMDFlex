# End-to-End Lo-Fi Wireflow

Status: First skeleton complete

Date: 2026-08-20

## Purpose

This wireflow verifies the core IMDFlex authoring journey before visual design. It uses one representative Ready state per Screen Family and keeps stable Screen IDs so later exception states and Figma frames can be traced back to the Coverage Matrix.

## Success criteria

1. A user can begin with no project and reach an exported `imdf.zip`.
2. Project, venue, building, level, and editing context remain understandable.
3. A reported issue leads to a real correction and recheck, rather than jumping directly to export.
4. Submission-blocking incomplete items and workflow incomplete items are distinguishable.
5. Long-running work can be resumed without losing a project or a drawing draft.

## Screen sequence

### A. Project and spatial setup

1. `HOME-01` Recent Projects
2. `CREATE-01` Start Method
3. `CREATE-02` Project Basics — create Draft Project (`D-LF-001`)
4. `SETUP-02` Address Search
5. `SETUP-03` Map Confirmation
6. `SETUP-04` Venue Detail
7. `SETUP-05` Building List
8. `SETUP-06` Building Detail
9. `SETUP-08` Level List
10. `SETUP-09` Level Detail

### B. Floor plan and project overview

11. `FLOOR-01` Floor Plan Hub
12. `FLOOR-02` Floor Plan Import
13. `FLOOR-04` Manual Alignment
14. `EDIT-01` Project Overview

### C. Editor and feature authoring

15. `EDIT-02` Editor Shell
16. `AUTHOR-01` Feature Picker
17. `AUTHOR-02` Polygon Drawing — drawing draft recovery (`D-LF-002`)
18. `AUTHOR-05` Continuous Authoring
19. `AUTHOR-08` Feature Inspector
20. `AUTHOR-11` Relationship Picker
21. `AUTHOR-12` Map Relationship Mode

### D. Review, correction, and export

22. `REVIEW-01` Issue Summary
23. `REVIEW-03` Issue Detail
24. `REVIEW-04` Issue Location
25. `AUTHOR-06` Geometry Selection & Edit
26. `REVIEW-05` Recheck
27. `REVIEW-06` Recheck Result
28. `EXPORT-01` Export Hub
29. `EXPORT-02` Submission Preflight — incomplete classification (`D-LF-003`)
30. `EXPORT-06` Export Progress
31. `EXPORT-07` Export Success

## Closed-loop logic

```text
Issue Summary
→ Issue Detail
→ Issue Location
→ Geometry Selection & Edit
→ Recheck
→ Recheck Result
→ Export Hub
→ Submission Preflight
→ Export Progress
→ Export Success
→ Recent Projects
```

If recheck still finds a blocking issue, `REVIEW-06` routes to the next issue rather than export. If preflight finds a submission-blocking incomplete item, `EXPORT-02` routes back to its affected feature. A development or review ZIP remains available regardless of those items.

## Prototype convention

Each Lo-Fi screen shows only:

- Screen ID and title
- current project, building, and level context when applicable
- one primary purpose
- one primary action
- Back, Cancel, Skip, or Retry only when the Coverage Matrix requires it
- next Screen ID

Visual tokens are intentionally limited to grayscale, one interaction accent, and 4-point spacing multiples. This is a temporary Lo-Fi convention, not the final IMDFlex design system.

## Next coverage pass

The next pass adds the highest-risk state branches: Draft Project cancel, address search offline/error, drawing draft context switch, invalid geometry, unresolved issue recheck, submission-blocked export, and export failure/retry.
