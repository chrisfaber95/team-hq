---
id: G-066
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: [G-065]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Create the spider, scorpion and sniper Blueprints (defaults only) and BP_SniperAIController.

## Acceptance
- [ ] Each Blueprint compiles and differs from its parent by defaults only
- [ ] The sniper uses hold position
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Spider and scorpion from the F-011 dog, sniper from the guard. Assets: new BP_Spider, BP_Scorpion, BP_Sniper, BP_SniperAIController.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
