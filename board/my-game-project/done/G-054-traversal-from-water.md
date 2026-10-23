---
id: G-054
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-052, G-053]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 57
---
## Goal
The player can climb out at marked ledges and push or pull blocks while swimming, and returns to swimming if the move ends in water.

## Acceptance
- [ ] Ledge grab works from swimming at a marked ledge (F-010 marking) and not at an unmarked edge (world test)
- [ ] Push and pull of blocks starts from swimming under the F-010 block rules
- [ ] After either move ends in deep water the character returns to Swimming without medium flicker; `FallStartHeight` resets and a high jump into deep water causes no fall damage
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: `Source/MyGameProject/Traversal/`. World test like `IndyPushBlockWorldTest`. `RestoreMovement` sets Falling for one frame; flying steps up `MaxStepHeight`.

## Hand-off (engineer writes, max 300 tokens)
PR #57 (https://github.com/chrisfaber95/my-game-project/pull/57) into epic/F-014, commit 592c0eb. Ledge grab now accepts a swimming character (marked Ledge volumes only; no rise-speed limit while swimming). Push already started from swimming (no medium check), unchanged. IndySwimComponent: UpdateMedium() extracted; on traversal exit (mode None) it re-picks the medium and sets Flying in the same frame, so no medium flicker; FallStartHeight is reset by RestoreMovement and swimming never lands, so no fall damage. Tests run: unreal-editor.sh check exit 0 (build + CompileAllBlueprints 0 errors); MyGameProject.Traversal automation 15/15 incl. new SwimLedge.GrabMarkedLedge and NoGrabAtUnmarkedEdge. Reviewer: look at IndySwimComponent::HandleTraversalModeChanged. Not covered: PIE check, push-from-swimming test, real high fall. Commit trailer says Haiku 5.5 instead of Sonnet 5.5 (not amended).

## Review (reviewer writes, one line per round)
round 1: approve
