# Sprint summary: sprint 6 (2026-10-09 to 2026-10-10, phase 2)

Three designer briefs handed off (F-004, F-005, F-006) and a user-requested code cleanup (decision 0006) started.
F-004 and F-006 are built; F-005 is half done and now waits behind the server cleanup.

## Shipped

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| T-025 | CPU measurement script + baseline (F-004) | #40 | 1 |
| T-026 | In-place live updates (patcher) (F-004) | #39 | 1 |
| T-027 | Secondary tiles as popups (F-004) | #41 | 1 |
| T-028 | Full-width cockpit layout (F-004) | #44 | 1 |
| T-037 | Patch only changed sections, skip closed popups (F-004) | #48 | 2 |
| T-029 | CPU after F-004: 0.63 -> 0.16 % desktop, 0.62 -> 0.10 % phone | #49 | 1 |
| T-030 | Permission-answer spike (F-005): closed without PR, findings in decision 0005 | - | - |
| T-031 | Continue ended terminal sessions (F-005, `auth`) | #42 | 1 |
| T-034 | Permission hook for dashboard sessions (F-005, `auth`; user ran the proof) | #46 | 2 |
| T-032 | Launch with goal + notes, `/api/launches` (F-006) | #43 | 1 |
| T-033 | Launch form + Recent launches (F-006) | #45 | 1 |
| T-038 | `docs/code-style.md` + structure guard test (cleanup) | #47 | 1 |
| T-046 | ESLint readability rules (`deps`) | #50 | 1 |
| T-039 | Move server files into feature folders (`auth`) | #51 | 1 |
| T-040 | Move client files into feature folders (`auth`) | #52 | 2 |
| T-043 | Readable client shell | #54 | 1 |
| T-044 | Readable client features (`auth`; split, client only) | #55 | 1 |

## Open

| Ticket | Status | Next step |
| --- | --- | --- |
| T-041 | review, approved, user_ok | PR #53 conflicts with main: `dispatch.sh T-041 claude-dashboard --rework` (merge main), re-review, merge |
| T-042 | backlog (after T-041), user_ok | server http/auth/claude renames, `server.ts` split |
| T-035 | backlog (after T-034, T-042) | answer endpoint + log; must close self-approval + hook-location gaps |
| T-036 | backlog (after T-035) | approve/deny UI + Approvals popup |
| T-045 | backlog (after T-036), owner user | user's end-to-end approve/deny check via the buttons |
| T-047 | backlog (after T-044) | client tests readable |
| T-048 | backlog (after T-042, T-047) | server tests readable; empties both allowlists |

## Waiting on the user

- Go for the T-041 rework run (the user asked not to start runs yet).
- Remove the engineer's scratch folder `N:\tmp-t044\` (its own delete was blocked).
- Until T-035 merges, approve/deny is for the user's own testing only (shared secret, hook in repo).

## Decisions

- [0005](../decisions/0005-answer-permission-prompts.md): answer permission prompts via a hook only in dashboard-started sessions (accepted).
- [0006](../decisions/0006-code-structure-and-naming.md): code grouped by feature, readable names; ESLint added on 2026-10-10.

## Metrics

17 tickets closed (16 PRs). Engineer + reviewer cost about $19.4 (T-041 so far $1.83 more); merge cost is not logged.
Most tickets merged in 1 round; 2 rounds: T-034 (guard rework), T-037, T-040. Messages 1-2 per ticket (target 3).
Rows added to `metrics/baseline.md` "Team runs".

## Notes for next sprint

- **Classifier limits:** engineers may not answer held permission prompts; the merge agent refuses a merge when the
  approval line carries an unmet condition; the lead's `gh pr merge` is denied by settings. Plan proofs as user steps.
- **Session limit** stopped 3 runs (T-025, T-027, T-034); `--rework` resumed each without loss.
- **Board writes from other sessions:** the cleanup session committed tickets, decision 0006 and skill edits directly.
  Fine when the user drives it, but it re-ordered F-005; check `git log` at sprint start.
- **Scope check before dispatch:** tickets written outside the lead (T-041, T-044) under-labelled auth work and
  over-scoped lint cleanup; relabel/split before dispatching.
- **Parallel branches + lists:** tickets that edit `LEGACY_FILES` / allowlists conflict when merged in parallel
  (T-041). Merge one, then rebase the other before review.

## Next sprint

1. T-041 rework (merge main) -> re-review -> merge.
2. T-042 (server http/auth renames, `auth`).
3. T-047 (client tests) in parallel with T-042.
4. T-035 after T-042, then T-036, then the user's T-045.
5. T-048 last (empties the allowlists).
