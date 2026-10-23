---
id: G-062
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: [G-061]
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: true
pr:
---
## Goal
Add the level exit trigger and end-screen widget base (treasures and secrets found / total; Back to menu opens the menu map set on the exit).

## Acceptance
- [ ] Entering the exit trigger fires once and opens the end screen
- [ ] The widget base exposes found / total for treasures and secrets
- [ ] Back to menu opens the configured map
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Adds UMG, Slate, SlateCore to Build.cs unless F-013 did first (then drop the deps label); needs user_ok. Line already in board/NEEDS-YOU.md.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
