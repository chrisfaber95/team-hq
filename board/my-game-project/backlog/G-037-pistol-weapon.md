---
id: G-037
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-036]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The player can fire a pistol where the crosshair points, with a magazine, reserve ammo and reload.

## Acceptance
- [ ] A `UIndyPistolComponent` on `AIndyCharacter`: while aiming, Fire (left mouse, gamepad right trigger) does a hitscan from the camera through the screen centre (the same in both views) and applies tunable point damage to what it hits; when not aiming, left mouse stays the whip (G-017).
- [ ] Magazine size and reserve cap are tunable; a shot uses one round; an empty magazine cannot fire and broadcasts `OnDryFire`; Reload (R, a free gamepad button) fills the magazine from reserve over a tunable time; no reserve means reload does nothing. `AddReserveAmmo` returns how much fit under the cap.
- [ ] Fire rate is limited by a tunable interval; a shot during reload is ignored.
- [ ] Pure ammo/reload rules with an automation test (`MyGameProject.Combat`).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Combat/` (after G-036, same folder). Aim state already exists (`AIndyCharacter::SetAiming`, `IndyAim`, G-006); this ticket only uses it. Camera zoom is G-038; crosshair and ammo text are G-043.
- Gamepad face button left is roll; name the reload button you picked in the hand-off.
- No pistol mesh in hand here (a visual follow-up; `Content/Weapons/Pistol` exists). Damage goes through `UGameplayStatics::ApplyPointDamage`, so enemies (G-039) need nothing special.
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
