---
id: G-013
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-012]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: https://github.com/chrisfaber95/my-game-project/pull/17
---
## Goal
The player mounts, climbs and dismounts marked ladders.

## Acceptance
- [ ] Interacting facing a ladder volume mounts it; while on it, move input goes up/down only, at a tunable speed.
- [ ] Reaching the top dismounts onto the platform, reaching the bottom steps off to the floor; jump drops the player off.
- [ ] A ladder-shaped object without a ladder volume cannot be mounted.
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Uses the mode component (G-012) and volumes (G-011). Top and bottom exits are derived from the volume's box ends.

## Hand-off (engineer writes, max 300 tokens)
PR #17 (https://github.com/chrisfaber95/my-game-project/pull/17), into epic/F-010. C++ only, no assets.
- New `UIndyLadderComponent` (Traversal/) on `AIndyCharacter`; new IA_Interact (E / gamepad top face button) calls TryMount.
- Mount: Ladder-kind volume within MountRange, faced by the view heading; unmarked geometry is never found. Climb: only move Y, along the volume's up axis at ClimbSpeed. Feet at top/bottom end dismount (top onto platform, bottom steps back); jump drops off.
- Tunables + OnLadderMounted/OnLadderDismounted exposed with Category "Traversal|Ladder".
- Ran: `unreal-editor.sh check` - build ok, CompileAllBlueprints 0 errors. No PIE check done.
- Reviewer: look at exit placement (TopExitDistance), that the ladder volume's local Z is the climb axis (upright volumes assumed), and PIE with a placed volume.

## Review (reviewer writes, one line per round)
round 1: approve
