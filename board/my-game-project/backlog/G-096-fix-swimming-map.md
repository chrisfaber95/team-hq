---
id: G-096
kind: ticket
repo: my-game-project
base: main
branch:
owner: eng-my-game-project
brief: F-014
depends_on: []
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
The swimming test pool `L_Swimming` plays as designed: the player spawns as Indy, swims in the deep water, and can climb out at the exit ledge. New maps get `AIndyGameMode` without an override.

## Acceptance
- [ ] `L_Swimming` has the `AIndyGameMode` override and a PlayerStart on the shore inside the map
- [ ] The `M_WaterSurface` plane has the NoCollision preset; nothing else solid covers the water at the surface
- [ ] The water volume encloses the deep area and the tunnel; its top is the surface
- [ ] From the water the player grabs the exit ledge and climbs out (hold W towards the face): the LEDGE volume is a marked ledge whose top is within `GrabHeightTolerance` of the capsule top when floating at the surface (see `IndyLedgeComponent::TryGrab`); move the volume or add a lower marked step, do not change the grab code unless a defect is shown
- [ ] A world test loads `L_Swimming` (or builds the same layout), swims to the exit ledge and checks the character ends up on the ledge; it fails on the old map
- [ ] `AIndyGameMode` is `GlobalDefaultGameMode` in `Config/DefaultEngine.ini`
- [ ] `unreal-editor.sh check` passes
- [ ] Only the assets under Assets: and `Config/DefaultEngine.ini` change

## Notes (lead)
Found in the G-090 play-test. Assets: `/Game/Maps/Greybox/L_Swimming`, `M_WaterSurface` if the collision is on the material or its mesh. Findings: (1) no game mode override, so the template first-person pawn spawned (blue mannequin, no swimming, no V toggle); (2) the water plane had the Default (blocking) collision preset, so the character walked on the surface; the user fixed both by hand in the G-090 working tree, so check the main checkout for his uncommitted map changes before editing and redo them if absent; (3) climbing out of the water does not work. Cause not confirmed: probably the exit ledge height or marking. Reproduce in the editor first and say which condition of `TryGrab` fails. Keys: W/A/S/D swim, Space surface, Left Ctrl dive, V toggles the view.
The PIE check in both views is the user's (`user_check`), at `L_Swimming`.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
