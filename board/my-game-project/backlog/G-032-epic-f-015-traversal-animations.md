---
id: G-032
kind: epic
repo: my-game-project
base: main
branch: epic/F-015
owner: lead
brief: F-015
depends_on: [G-025, G-031]
contracts: []
labels: []
budget_usd: 0
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
F-015 Traversal, whip, fall and crouch/roll animations: every move shows a matching animation in both camera views, in the F-010 test map.

## Acceptance
- [ ] Every acceptance criterion of `product/my-game-project/briefs/F-015-traversal-animations.md` holds (feature review against the brief). The brief has `user_check: true`, so merging needs `user_ok: true`.
- [ ] Full CI green on the epic PR.

## Notes (lead)
Epic ticket, never dispatched. `bash scripts/epic.sh open F-015 my-game-project` before G-023 is dispatched; `epic.sh pr G-032` once the others are done.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
