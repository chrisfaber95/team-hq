---
id: G-035
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-026]
contracts: []
labels: [assets, deps]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: true
pr:
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

## Review (reviewer writes, one line per round)
round 0 (lead, not a review): the first run blocked on a question, no code or review findings exist; the answer is in Notes and Acceptance. Start from the clean branch.

## Blocked
All 15 clips under `Animations/` reference the pack's own skeleton, not the project's: 14 use `/Game/FreeSampleAnimationSet/Demo/Mannequins/Meshes/SK_Mannequin` and the FemaleLocomotionSet clip uses `.../Demo/Mannequins/Meshes/SKM_Quinn_Simple_Skeleton` (read from the assets' package references). Both are in `Demo/`, which the acceptance criteria say not to import, and both are different skeletons from the project's (retargeting is out of scope).
Question: (a) import the `Demo/Mannequins` skeleton assets too, or (b) retarget the clips onto the project skeleton in a separate ticket?
Nothing was committed; the worktree is clean and the main checkout was not touched. Push clip: PushSet/RootMotion/Heavy/01/A_Push_Heavy_01_Loop; pull clip: PullSet/Mannequin/RootMotion/Rope/2H/01/A_Pull_Rope_2H_01_Loop (both root motion; only the LiftSet sample is InPlace).
