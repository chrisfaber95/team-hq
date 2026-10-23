---
id: G-067
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: [G-058, G-060, G-064]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Create data-only Blueprints: lever, crank, gate, debris, barrel, gas container, treasure and the truck (InterpToMovement loop set by properties).

## Acceptance
- [ ] Each Blueprint compiles with 0 errors
- [ ] The truck follows a fixed loop by component properties only
- [ ] No Blueprint logic nodes are added
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Assets: new BPs under /Game/Babylon/Blueprints, each listed in the PR.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
