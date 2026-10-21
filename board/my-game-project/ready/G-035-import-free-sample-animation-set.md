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
- [ ] The `Demo/` and `Maps/` folders of the pack are NOT imported (duplicate mannequin, meshes, materials, test map) unless an animation asset references them; if one does, stop and write it in the ticket.
- [ ] The animations open without errors against the project's skeleton (G-024 approach); if they use a different skeleton, stop and write which one in the ticket (no retargeting in this ticket).
- [ ] The ticket hand-off lists the clips for push, pull, and anything else useful for F-015 (push heavy loop/start/stop, pull is rope only so far), with root-motion vs in-place.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- User approved the pack as a new dependency on 2026-10-21 (Fab listing 5b737d10-b4cd-4294-8f6b-757b9088039d, "Free Sample Animation Set", ~216 MB, 78 files, one sample clip per set). Not a code dependency: no `*.Build.cs` or `.uproject` change.
- The user's files are untracked in the main checkout; copy them from there into the worktree, do not move or delete them.
- Assets: `/Game/FreeSampleAnimationSet/Animations/...`; unused sets (Cover, DBNO, Lift, Mining, ...) may be imported with the rest of `Animations/`; do not wire them to anything.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
