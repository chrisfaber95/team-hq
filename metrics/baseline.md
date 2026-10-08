# Phase 0 baseline

One normal Claude Code session (no team) works real tickets in the pilot repo. The user settled on two (T-002, T-003); T-004 moved to the
backlog to become a phase-1 team ticket.

How it ran: `scripts/baseline.sh`, one headless `claude -p` session per ticket on the default model, auto
mode, in its own worktree, stopping at an open PR (merging goes through review.sh + merge.sh).
**Known bias:** the session could see team-hq via `--add-dir`, so it also used the team `engineer` skill
(branch `team/<id>`, hand-off, tried to message `lead`). Expected effect: a few extra turns at most.
Record each merged PR; the team has to beat the averages.

Read numbers from `/usage` in the session, or the Claude-dashboard usage view.

| Ticket | PR | Session | Input tokens | Output tokens | Est. cost (USD) | Wall time | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| T-002 | #16 MERGED (f25a6a2) | baseline-T-002 (15 turns, success) | 674633 (97% cache) | 6930 | 2.07 | 7 min | + team review 11 turns $0.14, merge 7 turns $0.14 |
| T-003 | #17 MERGED (8747d80) | baseline-T-003 (49 turns, success) | 2396848 (97% cache) | 24738 | 2.24 | 9 min | + team review 11 turns $0.15, merge 7 turns $0.14; session spawned a probe session |

**Average per merged PR (2 tickets):** session turns 32, input tokens ~1.54M (97% cache), output ~15.8k, session cost $2.16 (+ ~$0.29 review/merge = ~$2.45 with gates), wall time 8 min.

# Team runs (phase 1+)

| Ticket | PR | Engineer turns | Engineer cost | Review rounds | Messages | Merged without user edits? |
| --- | --- | --- | --- | --- | --- | --- |
| T-001 | #15 | (set up by hand) | - | 1 (15 turns, $0.23) | 0 | yes; merge.sh run 32 s |
