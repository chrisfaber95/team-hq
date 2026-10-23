---
id: G-058
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Add IIndyActivatable, AIndySwitch (lever and crank) and AIndyGate in Source/MyGameProject/Level/.

## Acceptance
- [ ] A switch with a target list activates each target; a crank only works after its lever
- [ ] A gate opens when activated and blocks the player when closed
- [ ] A world automation test passes for lever, then crank, then gate
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Implement IIndySaveable from F-013. Assets: none.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)

## Blocked
IIndySaveable (F-013) is not in epic/F-012, main or any branch (epic/F-012 = c4c780b, F-014 only). The ticket says to implement it. Merge the F-013 epic into epic/F-012 first, or may I define IIndySaveable myself?
