---
id: G-035
kind: ticket
repo: my-game-project
base: epic/F-015
branch: team/G-035
owner: eng-my-game-project
brief: F-015
depends_on: [G-026]
contracts: []
labels: [assets, deps]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: true
pr: https://github.com/chrisfaber95/my-game-project/pull/32
---
## Goal
The free Fab pack the user added (`Content/FreeSampleAnimationSet/`, untracked in the main checkout `N:\Projects\MyGameProject`) is committed on `epic/F-015` so G-031 can use its push animation.

## Acceptance
- [ ] `Content/FreeSampleAnimationSet/Animations/**` is in the PR (Git LFS, per `.gitattributes`), copied from the main checkout's folder; the main checkout is not modified.
- [ ] Of `Demo/` import only the skeleton asset `Demo/Mannequins/Meshes/SK_Mannequin` (the 14 clips use it; plus whatever it strictly references); no meshes, materials, textures, props or maps. Skip the FemaleLocomotionSet clip (uses `SKM_Quinn_Simple_Skeleton`) rather than importing a second skeleton.
- [ ] Skeleton approach as G-024: add the imported pack `SK_Mannequin` to the project `SK_Mannequin`'s compatible skeletons (settings only), so the clips play unchanged on `SKM_Manny_Simple`; no retargeting. If the bone hierarchies differ so it does not work, stop and write it in the ticket.
- [ ] The ticket hand-off lists the clips for push, pull, and anything else useful for F-015 (push heavy loop/start/stop, pull is rope only so far), with root-motion vs in-place.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- User approved the pack as a new dependency on 2026-10-21 (Fab listing 5b737d10-b4cd-4294-8f6b-757b9088039d, "Free Sample Animation Set", ~216 MB, 78 files, one sample clip per set). Not a code dependency: no `*.Build.cs` or `.uproject` change.
- The user's files are untracked in the main checkout; copy them from there into the worktree, do not move or delete them.
- Lead answer to the first run's block: option (a), the G-024 compatible-skeleton way (decision by the lead). Also touches `Content/Characters/Mannequins/Meshes/SK_Mannequin.uasset` (settings only).
- Assets: `/Game/FreeSampleAnimationSet/Animations/...`; unused sets (Cover, DBNO, Lift, Mining, ...) may be imported with the rest of `Animations/`; do not wire them to anything.

## Hand-off (engineer writes, max 300 tokens)
PR #32 (into epic/F-015): 14 clips under Content/FreeSampleAnimationSet/Animations (LFS) + pack Demo/Mannequins/Meshes/SK_Mannequin only. FemaleLocomotionSet clip skipped (needs SKM_Quinn_Simple_Skeleton). Pack skeleton added to project SK_Mannequin compatible_skeletons (settings only, G-024 way); all 14 clips load on it. unreal-editor.sh check: build ok, CompileAllBlueprints 0 errors/0 failed.
Clips for G-031 (all baked root motion in RootMotion folders unless noted):
- Push: PushSet/RootMotion/Heavy/01/A_Push_Heavy_01_Loop (only a loop; no start/stop in the sample)
- Pull: PullSet/Mannequin/RootMotion/Rope/2H/01/A_Pull_Rope_2H_01_Loop
- Other: Ladder A_Ladder_Up_Loop, Stairs A_Stairs_WalkFwd_Up_Loop, NarrowPassage, DashDodgeRoll A_Roll_IdleFwd, MaleLocomotion A_RunFwd_Loop, Cover, DBNO, ItemPickup, Mining, StorageUnits, Survival; Lift is InPlace.
Reviewer: no PIE/ABP check (bone hierarchies not diffed); label assets does not exist.

## Review (reviewer writes, one line per round)
round 0 (lead, not a review): the first run blocked on a question, no code or review findings exist; the answer is in Notes and Acceptance. Start from the clean branch.
round 1: approve - 14 clips + pack skeleton + compatible_skeletons setting only, matches acceptance and Assets scope; base epic/F-015, CI green, build and CompileAllBlueprints run. PIE check still pending (noted limitation).

