---
id: G-086
kind: ticket
repo: my-game-project
base: epic/F-013
branch: team/G-086
owner: eng-my-game-project
brief: F-013
depends_on: []
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: true
pr: 64
---
## Goal
HUD widget base and FIndyHudRules; add UMG, Slate, SlateCore to Build.cs.

## Acceptance
- [ ] Health always shown (bottom-left); ammo only when armed; air meter only while underwater
- [ ] FIndyHudRules has an automation test for each visibility rule
- [ ] Nothing else is shown by the HUD
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. UI/ module. New dependency: NEEDS-YOU line exists; set user_ok before merge. Armed means aiming. Aim crosshair stays in the HUD widget.

## Hand-off (engineer writes, max 300 tokens)
PR #64 (https://github.com/chrisfaber95/my-game-project/pull/64) into epic/F-013. Added `UI/IndyHudRules` (pure: health always, ammo when armed=aiming, air when can't breathe, crosshair when aiming), `UI/IndyHudWidget` (abstract UUserWidget; optional BindWidget HealthText/AmmoText/AirText/Crosshair; NativeTick reads the pawn and applies the rules), `Tests/IndyHudRulesTest.cpp` (one test per rule), and UMG/Slate/SlateCore in Build.cs (public deps; approved, user_ok true). No Content assets changed; bottom-left layout comes with WBP_Hud (ticket 9). AIndyDebugHUD left for ticket 8.
Checks: `unreal-editor.sh check` (build + CompileAllBlueprints) passed, exit 0; clang-format 18.1.8 clean. Automation tests compiled, NOT run (no local run; CI doesn't run them). No visual check.
Reviewer: NativeTick visibility logic, SetShown using HitTestInvisible, public vs private deps in Build.cs.

## Review (reviewer writes, one line per round)
round 1: approve
