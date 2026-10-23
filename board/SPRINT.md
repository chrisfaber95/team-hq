# Sprint summary: F-011 and F-014 on main, F-012 planned (2026-10-23, phase 3)

F-011 combat and survival and F-014 swimming and diving are both merged into `main`. F-012 (Babylon dig site level) is
planned into 23 tickets and nothing of it is dispatched yet.

## Shipped

### my-game-project

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| G-046 | Combat test arena (into `epic/F-011`) | #49 | 1 |
| G-047 | Epic F-011 combat and survival, to `main` | #51 | 2 (PR body fixes) |
| G-048 | Fix ViewSettings clamp test (`main`) | #50 | 1 |
| G-049 | Water volume and rules | #52 | 1 |
| G-050 | Swim medium and wading | #53 | 1 |
| G-051 | Swim movement | #54 | 1 |
| G-052 | Underwater camera cue | #55 | 1 |
| G-053 | Air meter and pockets | #56 | 1 |
| G-054 | Traversal from water | #57 | 1 |
| G-055 | Swim animation states | #58 | 1 |
| G-056 | Swimming test pool | #59 | 1 |
| G-057 | Epic F-014 swimming and diving, to `main` | #60 | 1 |

### claude-dashboard

Nothing this sprint.

## Open

| Item | Status | Next step |
| --- | --- | --- |
| F-012 G-058..G-079, epic G-080 | backlog (decision 0016) | `run-tickets.sh my-game-project G-058 G-059 ...` in dependency order; `epic.sh open F-012` first. G-058, G-060, G-065, G-069 have no dependencies |
| G-062 | backlog, `deps` (UMG, Slate, SlateCore), `user_ok: true` | none; approved |
| G-070..G-079, G-080 | backlog, `user_check: true` | the user play-tests each area before it merges |
| F-013 game shell | approved brief, not planned | `plan.sh F-013 my-game-project` after F-012 (may add the UMG modules first) |
| T-103 (claude-dashboard) | ready | not dispatched |
| T-045 | backlog, owner user | approve/deny check from a paired device |

## Waiting on the user

- G-020: delete the leftover folder `N:\worktrees\my-game-project-G-020`. The push world tests
  (`IndyPushBlockWorldTest`) were never run by an engineer; CI only builds.
- Leftover worktree folders in `N:\worktrees` (`my-game-project-G-055-merge`, F-015, G-034, G-037, G-038, scratch
  dirs) can be deleted; `merge.sh` could not remove the G-055 merge folder ("Permission denied").
- F-012's nine area tickets (G-070..G-078) and the tuning ticket (G-079) each need a play-test and `user_ok`.

## Decisions

- [0015](../decisions/0015-f014-swimming-and-diving.md): F-014 swimming and diving design.
- [0016](../decisions/0016-f012-babylon-dig-site-level.md): F-012 Babylon dig site level design.

## Metrics

Engineer runs G-046..G-056: $0.27-0.77 each, $5.43 for 11 tickets; reviews $0.06-0.11 each; epic reviews G-047 $0.14 +
$0.08, G-057 $0.14. `plan.sh`: F-014 $1.35 (first run died with exit 127 and no output, the retry worked), F-012 $1.93.
Rows in `metrics/baseline.md`. The Sonnet lead and `run-tickets.sh` ran a full epic: the batch survived two
memory-pressure kills of the background command (the child runs kept going); reviewer runs failed 3 times on the
account usage limit (G-054) and were re-run. Epic reviews cost one round when the PR title and body are written first.

## Next sprint

1. `epic.sh open F-012 my-game-project`, then `run-tickets.sh my-game-project G-058 G-059 G-060 G-061 G-062 G-063 G-064 G-065 G-066 G-067 G-068 G-069` (engine and widget tickets, no play-tests).
2. Area tickets G-070..G-078: the user play-tests each; run them in small batches.
3. G-079 tuning, then `epic.sh pr G-080`; write the PR title and body first (assets, placeholders, checks).
4. `plan.sh F-013 my-game-project` after F-012.
