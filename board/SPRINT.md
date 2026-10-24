# Sprint summary: F-013 game shell 11 of 12 tickets in, F-012 waits (2026-10-24, phase 3)

F-012 was started first by mistake; engineer G-058 found it needs `IIndySaveable` from F-013 (decision 0016: F-013 first).
F-013 was planned (12 tickets, decision 0017) and run into `epic/F-013`. Nothing of F-012 is merged; `epic/F-012`
is cut from the old `main` and will be deleted and re-cut after F-013 is on `main`.

## Shipped

### my-game-project (all into `epic/F-013`, all approved in round 1)

| Ticket | Title | PR |
| --- | --- | --- |
| G-081 | Save subsystem | #61 |
| G-084 | View settings persist | #62 |
| G-085 | Key bindings | #63 |
| G-086 | HUD widget base (adds UMG, Slate, SlateCore) | #64 |
| G-082 | Saveable existing classes | #65 |
| G-083 | Checkpoint and game mode | #66 |
| G-087 | Menu widget bases | #67 |
| G-088 | Player controller and pause | #68 |
| G-093 | Optional widget bindings (new, for G-089) | #69 |
| G-089 | Empty WBPs, class paths (rewritten, user lays out later) | #70 |
| G-094 | Default widget layouts in C++ (new) | #71 |

### claude-dashboard

Nothing this sprint.

## Open

| Item | Status | Next step |
| --- | --- | --- |
| G-090 main menu map | review, PR #72 approved | user play-test, then `user_ok: true`; `run-tickets.sh my-game-project G-090` |
| G-095 settings fallback | backlog | run before the G-090 check or right after: Settings button opens nothing |
| G-091 checkpoints in levels | backlog, `user_check` | after G-090 and G-095 |
| G-092 epic F-013 | backlog, `user_check` | `epic.sh pr G-092` after G-091; write the PR title and body first |
| G-096 fix swimming map | backlog, `user_check`, base `main` | game mode override, plane collision, exit ledge, global default game mode |
| G-058 | blocked | return to backlog after F-013 is on `main` |
| F-012 G-058..G-079, G-080 | backlog; G-070..G-079 have `user_ok: true` | delete and re-cut `epic/F-012` (`epic.sh open`) after F-013 merges; G-062 drops `deps` (UMG added by G-086) |
| T-103 (claude-dashboard) | ready | not dispatched |
| T-045 | backlog, owner user | approve/deny check from a paired device |

## Waiting on the user

- G-020: delete the leftover folder `N:\worktrees\my-game-project-G-020` (push world tests never run by an engineer).
- G-090: play `L_MainMenu` on `team/G-090` (New Game, Continue, Quit; Settings needs G-095), then set `user_ok: true`.
- Leftover worktree folders in `N:\worktrees` can be deleted (`my-game-project-G-055-merge`, G-089-era scratch dirs).
- Restyle the six `WBP_*` screens in the UMG Designer during the F-013 play-test (the C++ default layout fills in until then).

## Decisions

- [0016](../decisions/0016-f012-babylon-dig-site-level.md): F-012 Babylon dig site level design (F-013 first).
- [0017](../decisions/0017-f013-game-shell.md): F-013 game shell design.

## Metrics

Review rounds: 1 for every ticket above. Known runs: G-082 engineer $0.81, review $0.11; G-093 $0.57 + $0.15;
G-090 $0.42 + $0.09; G-094 review $0.16. Other F-013 run costs are in `logs/`. `plan.sh F-013`: $1.11.
The Sonnet lead's background `run-tickets.sh` was killed by memory pressure twice; child runs kept going and two
resumed wrappers raced on G-094 (merged once, harmless). The first G-089 engineer run found no tool can write a
UMG widget tree, which led to G-093, G-094 and the empty-WBP rewrite.

## Next sprint

1. G-095, then you check G-090 and set `user_ok`; run G-090, then G-091.
2. `epic.sh pr G-092` for F-013, review, merge with your OK.
3. G-096 (swimming map), checked by you in `L_Swimming`.
4. Then `epic.sh open F-012` again and `run-tickets.sh my-game-project G-058 G-059 ...`.
