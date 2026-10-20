---
id: G-028
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-027]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
The whip swing shows attach, swing arc, landing at the anchor and early release; falls and landings play fitting animations.

## Acceptance
- [ ] Attaching the whip, the swing arc and the landing at the anchor each play a matching animation; releasing early plays a falling pose.
- [ ] Falling plays a falling animation; the landing animation scales with the fall tier (light below the damage height, heavy from a damaging fall), refining what G-024 set up.
- [ ] Blends show no pop. Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: `/Game/Characters/Mannequins/Anims/ABP_Indy` (swing and landing states).
- Library: `Update_2/AS_Grappel_Throw`, `AS_Grappel_Jump`, `AS_Grappel_Land` (anim sequences), `FallLoop`, `LandingRoll`, `Pole`.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
