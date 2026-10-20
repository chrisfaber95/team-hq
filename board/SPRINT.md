# Sprint summary: sprint 14 (2026-10-18 to 2026-10-20, phase 3)

F-010 (Traversal) is built and on `main` (epic PR #25). F-015 (animations) is ticketed on `epic/F-015`; its first four
tickets are merged (G-023..G-025, G-033, G-034 below); the lead holds before G-026 at the user's request.

## Shipped

### my-game-project (all rounds 1 unless noted)

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| G-011 | Traversal volumes | #15 | 1 |
| G-012 | Traversal mode component | #16 | 1 |
| G-013 | Ladder | #17 | 1 |
| G-014 | Climbable wall | #18 | 2 |
| G-015 | Ledge hang | #19 | 1 |
| G-016 | Push/pull block | #20 | 1 |
| G-017 | Whip anchor targeting | #21 | 1 |
| G-018 | Whip swing arc | #22 | 2 |
| G-019 | Fall damage | #23 | 1 |
| G-020 | Traversal test map `L_Traversal` (+ push fixes: grab position, floor clearance, no top grab) | #24 | 3 |
| G-021 | Epic F-010 to `main` | #25 | 1 |
| G-022 | Editor script stops by worktree | - (tooling) | 0 |
| G-023 | `UIndyAnimInstance` state | #26 | 1 |
| G-024 | Skeleton approach: library skeleton made compatible with the project's | #27 | 1 |
| G-033 | Walk/jog blend spaces (unused for now, see decisions) | #28 | 1 |
| G-034 | `ABP_Indy` (copy of `ABP_Unarmed`) + slot animation player, jump/fall/landing | #29 | 2 |
| G-025 | Ladder animations | #30 | 1 |

### claude-dashboard

Nothing this sprint (T-103 ready, not dispatched).

## Open

| Item | Status | Next step |
| --- | --- | --- |
| G-026 wall, G-027 ledge, G-028 whip/fall, G-029 crouch/roll, G-030 first person | backlog | user says go; one at a time, fill the `MoveAnimations` table of `ABP_Indy` |
| G-031 block push/pull animation | backlog, needs user | no push/pull clip in the library: pick a source or defer |
| G-032 epic F-015 | backlog | `epic.sh pr G-032` when the rest is done; brief has `user_check`, so it needs `user_ok` |
| F-011, F-014, F-013, F-012 | approved briefs | ticket one epic at a time after F-015 (order in `ROADMAP.md`) |
| T-103 (claude-dashboard) | ready | not dispatched |
| T-045 | backlog, owner user | approve/deny check from a paired device |

## Waiting on the user

- Delete the leftover worktree folders `N:\worktrees\my-game-project-G-013`, `-G-016`, `-G-020`; `-G-034` is kept for the user's own check (`logs/G-034.keep`; delete it after).
- G-031: choose an animation source for block push/pull (Epic sample content or a free pack = new dependency), or defer it.
- Play-test F-015 so far in `L_Traversal` (ladder; jump/fall/landing): hands on rungs, no pop at mount/dismount, standing pose after the top dismount, landing weight. The engineer flagged the dismount plays in place after the component moved the character.
- G-020 note: the new push world tests (`IndyPushBlockWorldTest`) were never run by an engineer; CI only builds.
- Dashboard browser checks and T-045 from earlier sprints; the phone/tablet app design session (decision 0007 "Later").

## Decisions

- No new decision file. Lead calls this sprint: (1) the animation library's skeleton is made compatible with the project's (G-024) instead of retargeting; (2) agents cannot author AnimGraphs, so `ABP_Indy` is a copy of `ABP_Unarmed` and library animations play through its slot from C++ with a per-move `MoveAnimations` table (G-034); (3) F-015 `user_check` only on G-031 and the epic, at the user's request; (4) `merge.sh` keeps a worktree when `logs/<id>.keep` exists.

## Metrics

Engineer runs cost $0.38-0.77 for a normal ticket; about $13.7 for the sprint's 17 tickets including reruns, reviews about
$2.8. Rows are in `metrics/baseline.md`. Money went to rework: G-024 ($2.50 over four runs: a too-big ticket, one run that
mistook `--rework` for a fix, one turn-cap stop at $1.31) and G-034 ($1.53: blocked on AnimGraph authoring). Two bugs
reached the user's play-test on G-020 (push block clipped, then stuck on the floor) because pushing was reasoned, not played.
Infrastructure: orphaned headless editors held port 8001 twice (G-017, G-023); a leftover worktree blocked a re-dispatch (G-023).

## Next sprint

1. G-026 climbable wall, then G-027 ledge, G-028 whip/fall, G-029 crouch/roll, G-030 first-person views (one at a time, user's go).
2. Settle G-031 (animation source for block push/pull) with the user.
3. `epic.sh pr G-032` and the feature review once the others are done.
4. Ticket F-011 (combat and survival) after F-015 is on `main`.
5. Make `dispatch.sh --rework` safe for a first implementation after a block (it told the engineer to fix review findings that did not exist).
