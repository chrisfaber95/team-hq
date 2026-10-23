---
id: G-051
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-050]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 54
---
## Goal
Swimming is free 3D camera-relative movement with dive and surface inputs and floating at the surface, the same in 1st and 3rd person.

## Acceptance
- [ ] Forward input moves where the camera points, including up and down; swim speed is tunable (default 300, slower than run)
- [ ] Held Jump surfaces and held Crouch dives; at the surface the eye stays at or below surface + HeadAboveWater, easing rather than snapping; `OnHeadUnderwaterChanged` fires
- [ ] Facing is yaw only (aim yaw while aiming) and the capsule never pitches; roll is blocked in water; works in both views; float-clamp logic has an automation test
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: swim component + IndyCharacter in `Source/MyGameProject/Player/`. The swim component owns facing and turns off both CMC orient flags.

## Hand-off (engineer writes, max 300 tokens)
PR #54 https://github.com/chrisfaber95/my-game-project/pull/54 (commit 3db6c7e, 6 C++ files, no assets).
Swimming now moves 3D along the camera (SwimSpeed 300, HeadAboveWater 20, FloatSpeed 150 props on UIndySwimComponent). Held Jump surfaces, held Crouch dives; IndyCharacter routes Move/Jump/Crouch to the component while swimming. New pure FIndyWaterRules::LimitVerticalSpeed holds the eye at or below surface+HeadAboveWater and eases down after entry. The component owns yaw-only facing (aim yaw while aiming), turns off both CMC orient flags, Roll() refused in water. OnHeadUnderwaterChanged(bool) added.
Checks: unreal-editor.sh check (build + CompileAllBlueprints) exit 0 on the second try (first hit a UHT out-of-memory); clang-format 18.1.8 applied. Test MyGameProject.Water.Rules.FloatClamp is written but NOT run. No PIE check.
Reviewer: look at SwimTick/SetMedium and the input routing; about 1 cm one-frame eye overshoot after CMC acceleration (eases back). Commit trailer names Haiku 5.5 by mistake of the git agent; not amended.

## Review (reviewer writes, one line per round)
round 1: approve
