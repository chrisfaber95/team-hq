---
id: G-060
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Add a Treasure kind to the existing IndyPickup in Combat/.

## Acceptance
- [ ] A treasure is collected on overlap and cannot be collected twice
- [ ] Treasure id is exposed for counting
- [ ] A rules test covers the Treasure kind
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Counted by the level stats ticket.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
