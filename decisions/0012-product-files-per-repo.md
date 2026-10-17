# 0012: Product files per repo

Date: 2026-10-17. Decided by: the user (split the product files like the board), the lead (layout and script changes).

## Context

Decision 0011 split the board per repo, but `product/VISION.md`, `ROADMAP.md`, `briefs/` and `research/` still
described only claude-dashboard. my-game-project had nowhere to put its own vision or briefs.

## Decision

**Folder per repo.** `product/<repo>/{VISION.md,ROADMAP.md,briefs/,research/}`. The dashboard's files moved into
`product/claude-dashboard/`; `product/my-game-project/` starts with a blank vision template for the user to fill in.

**Brief ids stay global.** `F-NNN` is numbered across all repos, as decision 0011 says, so the next brief is the
highest `F-NNN` in any `*/briefs/` plus one.

**Designer and scripts.** The designer asks which repo a feature is for and works only in that folder. The
session-start hook lists `needs-design` briefs from every repo. `epic.sh` and `merge.sh` find a brief with
`find product -path "*/briefs/F-NNN-*.md"`. The lead checks `product/*/briefs/` for approved briefs each sprint.

**Contracts.** `contracts/` stays at the top level and unused: the two repos share no API (decision 0009).

## Consequences

- Old text (sprint summaries, decisions 0001 to 0011, brief bodies) keeps the flat `product/briefs/` paths.
- Each repo's vision, roadmap and research are separate, so the designer reads only what applies.
