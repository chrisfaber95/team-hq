---
id: G-077
kind: ticket
repo: my-game-project
base: epic/F-012
branch:
owner: eng-my-game-project
brief: F-012
depends_on: [G-063, G-065, G-066, G-067, G-069]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
Build area 6 first part: dark room with coins, niche lever waking reinforcements with their text card, crate to pull to reveal the passage.

## Acceptance
- [ ] Area built in its own sublevel only; no other sublevel or the persistent map changes
- [ ] The lever wakes the reinforcements and shows the card
- [ ] The passage is reachable only after pulling the crate
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0016-f012-babylon-dig-site-level.md. Prerequisites for the whole brief: F-014 epic (G-057) and the F-013 epic merged to main before epic/F-012 is cut. Order 2, 8, 17, 20.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
