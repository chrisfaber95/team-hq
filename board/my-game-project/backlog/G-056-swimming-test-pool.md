---
id: G-056
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-052, G-053, G-054, G-055]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
A test pool map lets the player complete every F-014 behaviour in both views.

## Acceptance
- [ ] `L_Swimming` has shallows, deep water, a two-level tunnel with an air pocket, an underwater treasure, an underwater block and a marked exit ledge
- [ ] The pool can be completed in 1st and 3rd person; pistol and whip work at the surface and underwater; treasure is collected by swimming into it
- [ ] `M_WaterSurface` is see-through and visible from below; the swim clips are set as `ABP_Indy` defaults; `CompileAllBlueprints` reports 0 errors
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: Content only; no Blueprint logic.
Assets: /Game/.../L_Swimming (map, next to the other test maps), /Game/.../M_WaterSurface (translucent, two-sided), ABP_Indy (property defaults for the swim clips, by Python commandlet).
Unmarked edges must be taller than MaxStepHeight. `user_check`: the PIE check in both views is the acceptance.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
