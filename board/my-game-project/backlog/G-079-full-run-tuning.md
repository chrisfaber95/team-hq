---
id: G-079
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: [G-070, G-071, G-072, G-073, G-074, G-075, G-076, G-077, G-078]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: true
pr:
---
## Goal
Play the full run in both views, respawn at each checkpoint, quit and continue; check counts and tune enemy numbers.

## Acceptance
- [ ] A full start-to-exit run works, and again after dying and respawning at a checkpoint
- [ ] Mandatory chains cannot be skipped; end-screen counts match placed totals
- [ ] At least three encounters, two checkpoints and one optional secret exist
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Also verifies F-013 criteria that need this level (end screen, restored chains).

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
