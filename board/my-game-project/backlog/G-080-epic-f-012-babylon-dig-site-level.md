---
id: G-080
kind: epic
repo: my-game-project
base: main
branch: epic/F-012
owner: lead
brief: F-012
depends_on: [G-058, G-059, G-060, G-061, G-062, G-063, G-064, G-065, G-066, G-067, G-068, G-069, G-070, G-071, G-072, G-073, G-074, G-075, G-076, G-077, G-078, G-079]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
The first half of the Babylon dig site is playable from start to the exit, in either view.

## Acceptance
- [ ] Start, exit trigger and end-of-level screen exist; areas 1-6 appear in order
- [ ] Mandatory chains (lever/crank/gate, crate/roof/truck, barrels, crate/tunnel) cannot be skipped
- [ ] Three encounters, a sniper, two checkpoints, a secret, and treasure and secret counts on the end screen
- [ ] Full CI green on the epic PR

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Cut epic/F-012 from main after the F-013 and F-014 epics merge. Never dispatched.
