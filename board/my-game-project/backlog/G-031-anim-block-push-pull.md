---
id: G-031
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-024]
contracts: []
labels: [assets, deps]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
Pushing and pulling a block show push and pull animations with the hands on the block, only while the block moves.

## Acceptance
- [ ] Pushing and pulling play push and pull animations with the hands on the block, only while the block moves; standing at a block without input shows a ready pose or normal idle.
- [ ] Letting go (or the block stopping at a wall) returns to normal idle without a visible jump.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- BLOCKED ON THE USER: the animation library has no push or pull animation (`Interaction` only has button, valve and touch). The brief's next sources are Epic sample content, then a free pack; a pack is a new dependency and needs the user's approval. Stays in backlog until the user decides. The rest of F-015 ships without it (brief decision); if the user defers it, drop it from the epic G-032 `depends_on`.
- Assets (once unblocked): `/Game/Characters/Mannequins/Anims/ABP_Indy` (push states), driven by the block properties of `UIndyAnimInstance` (G-023).
- USER DECISION 2026-10-21: the user approves a free pack as the source (new dependency approved in principle; the exact pack is confirmed in NEEDS-YOU before any import). Candidates found by the lead (price not confirmed, check the Fab listing): "Push Set" (fab.com/listings/15f36675-213d-4f55-8ebf-cf481b242876; push-heavy objects, start/loop/stop, blocked case; UE5 Mannequin skeleton, in-place and root-motion) and the "Interaction Animation" pack (fab.com/s/26eba1b1fe30; levers push/pull, not block pushing). Push Set fits best; no pull clip is confirmed. Fab assets download through the user's Epic account/launcher, so the user adds the pack to the project (or tells the lead where it sits); then G-024's skeleton approach applies if it is not on the project's skeleton. UPDATE: both candidates are paid; the user is searching for a free one. CHOSEN PACK: fab.com/listings/5b737d10-b4cd-4294-8f6b-757b9088039d (free per user; push plus other animations; listing not readable by the lead). The user imports it; engineer then checks skeleton compatibility (G-024 approach) and which clips exist. Other clips may feed later F-015 tickets only if the user asks.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
