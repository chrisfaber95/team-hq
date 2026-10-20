---
id: G-033
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-024]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Walk and run blend spaces (speed by direction) built from the library animations, ready for the animation Blueprint.

## Acceptance
- [ ] A walk blend space and a jog blend space, each on speed and direction, using the library's `Walk` and `Jog` animations (on the skeleton approach from G-024), under `/Game/Characters/Mannequins/Anims/Indy/`.
- [ ] Opening each in the editor preview shows forward, backward and sideways without foot sliding at the sample points; the axes' ranges match the character's walk and run speeds (read them from `AIndyCharacter`).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: `/Game/Characters/Mannequins/Anims/Indy/BS_Indy_Walk`, `BS_Indy_Jog` (new). The MCP cannot make blend spaces: use the Python commandlet with the editor stopped through `unreal-editor.sh stop`, as in G-008.
- Library: `Walk` (Fwd, Bwd, Left, Right loops), `Jog` (Loop_Fwd, Bwd, Left, Right). No animation Blueprint here (G-034).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
