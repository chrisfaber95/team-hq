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
review_rounds: 1
user_check: true
user_ok: true
pr: 59
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
Content only, built by Python commandlet; no C++ or Blueprint logic changed. PR: https://github.com/chrisfaber95/my-game-project/pull/59 (into epic/F-014).
- New map `Content/Maps/Greybox/L_Swimming`: dry shore, 60 cm shallows, 600 cm deep water, two-level flooded tunnel with an AirPocket volume, medkit pickup underwater as the treasure (no treasure asset exists), underwater IndyPushBlock, LEDGE volume marking the exit ledge (other edges are tall columns/walls), PlayerStart, lights.
- New `M_WaterSurface` (translucent, two-sided, unlit) on a no-collision plane at Z=0 (AIndyWaterVolume has no Surface mesh property).
- `ABP_Indy` MoveAnimations: SwimIdle=anim_SwimIdle, Swim=anim_Swim_Surface_Fwd, both loop.
- Checks: `unreal-editor.sh check` passed (build OK; CompileAllBlueprints 0 errors, 0 failed to load); a headless reload printed the material flags, the two ABP rows and all map actors.
- Reviewer/user: headless renders nothing, so the PIE check in 1st and 3rd person (pistol, whip, treasure, ledge exit, air pocket) is still open (user_check). `assets` label doesn't exist in the repo, so it was not applied.

## Review (reviewer writes, one line per round)
round 1: approve
