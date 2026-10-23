---
id: G-057
kind: epic
repo: my-game-project
base: main
branch: epic/F-014
owner: lead
brief: F-014
depends_on: [G-049, G-050, G-051, G-052, G-053, G-054, G-055, G-056]
contracts: []
labels: []
budget_usd: 0
review_rounds: 1
user_check: false
user_ok: false
pr: 60
---
## Goal
In a test pool the player can wade through shallows, swim freely, dive under, hold their breath, run out of air, find air pockets, climb out, fight and pick up treasure, in both camera views.

## Acceptance
- [ ] All acceptance criteria of `product/my-game-project/briefs/F-014-swimming-and-diving.md` (water volumes, swimming and diving, air, actions in water, test pool).
- [ ] Full CI green on the epic PR.

## Notes (lead)
- Tickets: G-049..G-056. Never dispatched; `epic.sh pr G-057` once they are all in `done/`.
- Run `epic.sh open F-014 my-game-project` only after G-047 (F-011) has merged to main.
- Design: `decisions/0015-f014-swimming-and-diving.md`.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
round 1: approve
