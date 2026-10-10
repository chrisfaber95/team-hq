# Sprint summary: sprint 7 (2026-10-10, phase 2)

The decision 0006 cleanup is finished: `LEGACY_FILES` and both structure allowlists are empty. F-005 is fully built
(T-034..T-036); it ships once the user's T-045 check passes. The user held T-035 over a self-approval gap, and since
then only paired devices may answer prompts (decision 0005 amendment).

## Shipped

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| T-041 | Readable server data side (`auth`); rework = merge main after a conflict | #53 | 2 |
| T-047 | Readable client tests | #56 | 1 |
| T-042 | Readable server http/auth/claude, `server.ts` split into guards + routes (`auth`) | #57 | 1 |
| T-035 | Answer endpoint + approval log, paired devices only (F-005, `auth`) | #58 | 2 |
| T-036 | Approve/deny UI + Approvals popup; no buttons on the PC (F-005, `auth`) | #59 | 1 |
| T-048 | Readable server tests, allowlists empty (relabelled `auth`: LAN-mode config renames) | #60 | 1 |

## Open

| Ticket | Status | Next step |
| --- | --- | --- |
| T-045 | backlog, owner user | user runs allow / deny / expiry / approval log from a paired phone or tablet; failures -> bug tickets; then F-005 shipped in `product/ROADMAP.md` |

No tickets in ready, in-progress, review or blocked. No approved briefs waiting.

## Waiting on the user

- T-045: the approve/deny check above (steps in `board/backlog/T-045-verify-approve-deny.md`).
- Remove the scratch folder `N:\tmp-t044\` (T-044 engineer; its own delete was blocked).
- Leftovers under `N:\worktrees\`: `claude-dashboard-T-036` (the run hung after hand-off and was stopped, so merge.sh
  could not remove it), `_scratch-T048`, and old `claude-dashboard-T-019` / `claude-dashboard-T-030`. Nothing to keep.

## Decisions

- [0005](../decisions/0005-answer-permission-prompts.md): amended 2026-10-10. Only paired devices may answer; the PC is
  refused by socket peer. A same-user session editing the hook copy in `DATA_DIR` is an accepted risk.

## Metrics

6 tickets merged (6 PRs). Engineer + reviewer cost about $8.3 (T-036's engineer cost not logged); merge cost not logged.
2 rounds: T-041 (conflict), T-035 (user hold). Messages 1-2 per ticket (target 3). Rows in `metrics/baseline.md`.

## Notes for next sprint

- **Re-ask `user_ok` when the risk changes.** The user's OK on T-035 came before the loopback gap was known; when the
  user held the merge, the lead reset `user_ok`. Treat a hand-off that reports a new residual security risk as a new question.
- **Blanket approvals:** the classifier blocked the lead from setting `user_ok` on T-048 under "approve everything
  this sprint" (it was relabelled `auth` after that). Ask for an explicit per-ticket OK.
- **Scope creep into `auth`:** T-048 (a tests ticket) renamed LAN-mode config. Check the PR's non-test files before review.
- **Hung run:** the T-036 engineer finished its hand-off but never exited. If a run's message arrives but the
  dispatch doesn't exit, stop it after the merge.
- **Parallel `LEGACY_FILES` edits** went fine with a "merge `origin/main` before hand-off" note in each ticket.

## Next sprint

1. T-045 result from the user -> bug tickets or mark F-005 shipped.
2. Check `product/briefs/` for new approved briefs (none today); ask the designer/user for the next feature.
