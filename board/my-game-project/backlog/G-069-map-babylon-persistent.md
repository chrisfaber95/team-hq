---
id: G-069
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: []
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Create L_Babylon plus nine empty sublevels, one per area ticket.

## Acceptance
- [ ] L_Babylon loads with all nine sublevels always loaded
- [ ] Each sublevel is a separate empty file
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Assets: /Game/Babylon/Maps/L_Babylon and nine sublevels named in the PR. Navigation is runtime-generated.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
