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
review_rounds: 1
user_check: false
user_ok: false
pr: 28
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
Added `BS_Indy_Walk` (speed 0..200 = WalkSpeed) and `BS_Indy_Jog` (0..500 = RunSpeed) under `/Game/Characters/Mannequins/Anims/Indy/`, direction -180..180, on SK_Mannequin, via Python commandlet. Samples (Fwd 0, Right 90, Left -90, Bwd +-180) only at max speed. PR: https://github.com/chrisfaber95/my-game-project/pull/28 (into epic/F-015, not merged). Checks: `unreal-editor.sh check` passed (0 errors, 0 failed to load); headless reload confirmed axes/samples. Reviewer: headless only, so foot sliding and the preview (acceptance 2) are NOT verified visually; single speed row, so the ABP (G-034) must handle idle/slow speeds. No tests; only the two assets changed.

## Review (reviewer writes, one line per round)
round 1: approve - both assets listed, axes match WalkSpeed 200 / RunSpeed 500, CI green, check passed; foot-sliding preview (criterion 2) not verified visually, and samples exist only at max speed (G-034 must handle idle)
