---
id: G-042
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-036, G-037]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 43
---
## Goal
Medkit and ammo pickups are collected by walking into them, up to their caps.

## Acceptance
- [ ] `AIndyPickup` (C++ base: overlap sphere + mesh component) with a kind (Medkit, PistolAmmo) and an amount; overlapping the player adds medkits (G-036) or reserve ammo (G-037).
- [ ] It gives only what fits under the cap and keeps the rest; when empty it hides and disables its collision; with nothing fitting it stays whole. `OnPickedUp` is exposed for sound and effects.
- [ ] Pure "how much fits" helper with an automation test (`MyGameProject.Combat`).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Combat/`. The Blueprints `BP_Pickup_Medkit` / `BP_Pickup_PistolAmmo` are G-045 (decision 0013: pickups as Blueprints on a C++ base).
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)
PR #43 (https://github.com/chrisfaber95/my-game-project/pull/43) into epic/F-011. C++ only, no assets, no new deps.
New: Combat/IndyPickup.h/.cpp (AIndyPickup: sphere trigger + mesh, Kind Medkit/PistolAmmo, Amount, OnPickedUp, TryCollect), Combat/IndyPickupRules.h/.cpp (AmountThatFits), Tests/IndyPickupRulesTest.cpp.
Gives only what fits under MedkitCap/ReserveCap, keeps the rest; used up -> hidden + no collision; nothing fits -> stays whole, no event.
Checks: `unreal-editor.sh check` exit 0 (Blueprints 0 errors, 0 warnings; no separate `Result: Succeeded` line logged); headless `Automation RunTests MyGameProject.Combat` 6/6 pass incl. Pickup.AmountThatFits; clang-format 18.1.8 clean. CI does not compile.
Reviewer: collects on begin-overlap only (player standing inside at cap must step out and in); no PIE check; branch is one commit behind epic/F-011 (G-039, no overlapping files).

## Review (reviewer writes, one line per round)
round 1: approve
