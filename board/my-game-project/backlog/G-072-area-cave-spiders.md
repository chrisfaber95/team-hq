---
id: G-072
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: [G-061, G-066, G-067, G-069]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: true
pr:
---
## Goal
Build area 2: dark spider room, ledge route with treasures, ladder, wading trench, one optional secret route.

## Acceptance
- [ ] Area built in its own sublevel only; no other sublevel or the persistent map changes
- [ ] Spiders, ledge treasures and a secret reachable only by the optional route are placed
- [ ] The trench is wade-only
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. 

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
