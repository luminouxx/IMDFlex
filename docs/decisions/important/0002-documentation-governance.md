# 0002 — Documentation Governance

- Status: Accepted
- Date: 2026-09-14
- Areas: Product, Design, Engineering, Marketing

## Context

IMDFlex has product plans, Figma reports, Lo-Fi evidence, engineering contracts, and migration records at different levels of authority. A bulk move while another feature branch edits tracked documents would create avoidable conflicts and broken references.

## Decision

1. `docs/README.md` is the stable documentation entry point.
2. Binding decisions live in `docs/decisions/important/`; reversible implementation notes live in `docs/decisions/routine/`.
3. Working material is grouped under `docs/product/`, `docs/design/`, `docs/engineering/`, and `docs/marketing/`.
4. Untracked Figma and Lo-Fi artifacts are organized now. Existing tracked files modified by another active branch stay in place and are indexed by domain until a dedicated relocation change is safe.
5. File movement never upgrades a document's approval state. Historical PASS, HOLD, draft, and unverified states remain explicit.
6. `AGENTS.md` links to the index and the small set of important current references instead of duplicating their contents.

## Consequences

- Agents have one discoverable entry point without creating branch conflicts.
- Future physical relocation of tracked root documents is a separate documentation change with link checks.
- Routine session detail remains searchable without becoming architectural policy.
