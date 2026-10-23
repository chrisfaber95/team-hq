---
id: G-086
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: []
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: true
pr:
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

## Review (reviewer writes, one line per round)
