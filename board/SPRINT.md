# Sprint summary: F-011 combat and survival, nearly done (2026-10-23, phase 3)

F-011 tickets G-036..G-045 are merged into `epic/F-011`. G-046 (combat test arena) waits for review and the user's
play-test, then the epic ticket G-047 brings F-011 to `main`. This sprint also changed how the team runs (decision 0014).

## Shipped

### my-game-project (all into `epic/F-011`)

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| G-036 | Health and medkits | #39 | 1 |
| G-038 | Aim camera | #40 | 1 |
| G-037 | Pistol weapon | #41 | 1 |
| G-039 | Enemy base character | #42 | 1 |
| G-042 | Pickup base | #43 | 1 |
| G-040 | Enemy AI controller | #44 | 2 |
| G-041 | Whip lash | #45 | 1 |
| G-044 | Arena restart on death | #46 | 1 |
| G-045 | Enemy and pickup Blueprints | #47 | 1 |
| G-043 | Combat debug HUD | #48 | 1 |

### claude-dashboard

Nothing this sprint.

## Open

| Item | Status | Next step |
| --- | --- | --- |
| G-046 combat test arena | review, PR #49, `user_check: true` | reviewer run, then the user's play-test (PIE was never run headless; numbers untuned) |
| G-047 epic F-011 to `main` | backlog | after G-046: `epic.sh pr G-047`, review, merge (needs F-011 feature review) |
| G-048 fix ViewSettings clamp test | ready | dispatch with `run-tickets.sh`; independent of F-011 |
| F-014, F-013, F-012 | approved briefs | plan with `plan.sh` (one epic at a time, order in `ROADMAP.md`) |
| T-103 (claude-dashboard) | ready | not dispatched |
| T-045 | backlog, owner user | approve/deny check from a paired device |

## Waiting on the user

- Play-test G-046 and set `user_ok: true` (or name defects); numbers are untuned defaults.
- G-020: delete the leftover folder `N:\worktrees\my-game-project-G-020` (merge.sh could not remove it). The push
  world tests (`IndyPushBlockWorldTest`) were never run by an engineer; CI only builds.
- Leftover worktree folders in `N:\worktrees` (F-015, G-034, G-037, G-038, scratch dirs) can be deleted.
- Start the lead with `claude --model sonnet --strict-mcp-config` from now on (decision 0014).

## Decisions

- [0014](../decisions/0014-small-lead-planner-architect.md): lead on Sonnet and cleared per epic, planner and architect
  agents, `run-tickets.sh` batch runner, `--disable-slash-commands` for headless runs (about a third fewer prompt
  tokens per run), engineer skill split into `SKILL.md` + `repo-<repo>.md` (dispatch.sh names both).

## Metrics

Engineer runs about $4.89 for 10 tickets ($0.23-0.90 each; G-040's first run has no JSON result, so only its rework
$0.23 is counted), reviews $1.42; rows in `metrics/baseline.md`. G-040 needed a second round (two fixes). G-046's
engineer run was $0.49. These runs are cheaper than F-015's ($0.54-1.41), so the cost lever is now the lead, not the runs.
Not yet measured: the Sonnet lead, `plan.sh` and `run-tickets.sh` on a real epic.

## Next sprint

1. Review G-046 (`run-tickets.sh my-game-project G-046` resumes it), then the user's play-test and `user_ok`.
2. `epic.sh pr G-047`, feature review against F-011, merge to `main`.
3. G-048 (clamp test), dispatched with `run-tickets.sh`.
4. `plan.sh F-014 my-game-project` for the next epic (first real planner run: check its tickets).
5. Watch the first engineer run for the repo notes file (`repo-<repo>.md`) being read.
