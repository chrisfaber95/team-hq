# 0015: F-014 swimming, diving and wading: design and ticket split

Date: 2026-10-23. Decided by: the architect (for the planner). Brief: F-014. Repo: my-game-project.

Context: F-014 adds water to the player. Code from F-011 (health, pistol, pickups, debug HUD) exists only on `epic/F-011` (G-047 in backlog).
Traversal modes put the character in `MOVE_Flying`, and `RestoreMovement` drops it into `MOVE_Falling`. The ledge grab needs `IsFalling()`.
## Decision

- **Our own swimming on `MOVE_Flying`, not engine `MOVE_Swimming`.** Engine swimming needs an `APhysicsVolume` with `bWaterVolume`.
  It picks the volume from the capsule centre (so no tunable wading depth), bobs at the surface through buoyancy, and switches modes
  in `PhysicsVolumeChanged`, which fights the traversal component. Flying gives no gravity, full 3D input and step-up, and the traversal moves already use it.
  The cost: other code asks the swim component, not the CMC, whether the character swims.
- **Swimming is a medium, not a traversal mode.** `EIndyWaterMedium { Dry, Wading, Swimming }` lives on a new `UIndySwimComponent`, which acts only while the traversal
  mode is None. A traversal mode would block the whip and the pistol facing, and would need rule exceptions for ledge and push. Ledge and push start
  from swimming as they do from walking. When either ends, `RestoreMovement` sets Falling and the next swim tick returns the character to Swimming if the water is still deep.
- **One volume class, `AIndyWaterVolume`** (`Water/`), with `EIndyWaterKind { Water, AirPocket }`. It is a yaw-only box whose top is the surface. The box has **NoCollision**
  and is found by iterating actors, so it never blocks the camera boom, pistol traces or the whip. It has an optional `Surface` plane mesh with an `EditAnywhere` material.
  Depth = surface Z minus the floor hit by a down trace (the box bottom when nothing is hit), so one volume over a sloped floor gives both shallows and deep water.
- **Medium rule**, pure `FIndyWaterRules::ChooseMedium(Current, bInWater, FloorDepth, Immersion, WadingDepth, Hysteresis)`: the result is Swimming when
  FloorDepth and Immersion (surface minus capsule bottom) are both >= WadingDepth, Wading when the character is in water and walking, and Dry otherwise. Swimming falls back to Wading only below
  `WadingDepth - Hysteresis`. Wading = `AddSpeedModifier("Wading", WadingSpeedFactor)`; jumping and the rest stay as they are.
- **Swimming movement**: input = `FIndyWaterRules::SwimDirection(ControlRotation, Move2D, Vertical)`, with the full camera pitch. Held Jump surfaces and held Crouch dives,
  and these inputs are routed to the swim component while swimming. The buoyancy is neutral. The eye point (capsule top minus `EyeDropFromTop`) is held at or below
  `Surface + HeadAboveWater`, easing at `FloatSpeed` (no snap on entry). The swim component owns facing (yaw only: the aim yaw while aiming, otherwise the move yaw)
  and turns off both CMC orient flags, because Flying lets them pitch the capsule. `SetAiming` leaves the CMC flags alone while swimming. Roll is off while swimming.
- **Air**: a pure `FIndyAirMeter` (its `Tick(Dt, bCanBreathe, ...)` returns the damage) inside `UIndyAirComponent`. The character can breathe when the eye is above the surface or
  inside an AirPocket. Damage goes through `TakeDamage`, so the F-011 death and restart apply. The debug HUD adds `Air: 72 / 100`.
- **Underwater cue**: when the camera point is inside a Water volume (not an AirPocket), the camera's PostProcessSettings tint turns on. This works in both views, with no assets.
- **Defaults** (balanced in F-012): WadingDepth 90 cm, WadingSpeedFactor 0.6, SwimSpeed 300 cm/s (run 500), HeadAboveWater 20 cm, Hysteresis 10 cm, air 100,
  drain 5/s, refill 50/s, drowning 10/s.
- **No code changes** for the pistol, the whip lash or pickups (the overlap already works). Enemies stay out of water (the brief defers this). The test pool checks these in PIE.

## Tickets (build order; one module each; C++ unless noted)

1. **Water volume + rules** (`Water/`): `AIndyWaterVolume`, the two enums, `FIndyWaterRules` (ChooseMedium, depth, SwimDirection).
2. **Swim medium + wading** (`UIndySwimComponent`, character wiring): medium state, wading modifier, enter and leave Flying, `OnMediumChanged`.
3. **Swimming movement** (same component + `IndyCharacter`): 3D input, dive and surface, float clamp, facing and aim, roll blocked, `OnHeadUnderwaterChanged`.
4. **Underwater camera cue** (`IndyCharacter` view update): the post-process tint.
5. **Air meter + air pockets + debug HUD line** (`UIndyAirComponent`, `IndyDebugHUD`). The HUD line is three lines and the meter's only display, so it is not split out.
6. **Traversal from water** (`Traversal/`): the ledge grab while swimming (marked ledges only), the push-block take-hold while swimming, and the return to swimming after either ends.
7. **Swim placeholder animation states** (`Animation/`): `SwimIdle` and `Swim` in `EIndyMoveAnimState`, with clip properties (when empty, the graph stays visible).
8. **Test pool (Content, changes assets)**: map `L_Swimming` with every element the brief lists, a translucent two-sided `M_WaterSurface`, and the
   swim clips set as `ABP_Indy` defaults (a property change, by Python). `user_check: true`, because the PIE check in both views is the feature's acceptance.
9. Epic ticket. No ticket changes Blueprint *logic*. Tickets 2, 3, 4 and 6 touch `IndyCharacter.cpp` and must run one after another.

## What must be tested (automation tests in `Tests/`)

- ChooseMedium: dry, wading and swimming, the swim-to-wade hysteresis, and entry from a fall. Depth on a sloped floor and with no floor hit.
- SwimDirection: looking up, down and level, strafing, dive and surface. The result depends only on the control rotation, so it is the same in both views.
- Float clamp: the eye never rises above the surface plus HeadAboveWater and eases rather than snaps.
- FIndyAirMeter: drain, refill, clamping at 0 and at capacity, damage only at zero, and stopping on breath.
- Ledge (world test like `IndyPushBlockWorldTest`): grab from swimming at a marked ledge, no grab at an unmarked edge. No fall damage on a high jump into deep water.

## Risks

- **F-011 first**: cut `epic/F-014` from `main` only after G-047 merges. Tickets 5 and 8 need health, the HUD and pickups.
- Flying steps up `MaxStepHeight`, so an unmarked edge lower than that above the capsule bottom can be stepped onto. Exits must be marked or taller.
- `RestoreMovement` sets Falling for one frame in water. Check that the medium does not flicker and that `FallStartHeight` resets.
- The whip swing can still start from water. This is unchanged and untested, and the pool has no anchors.
- No new modules, plugins, contracts or migrations, so nothing goes to `NEEDS-YOU.md`.
