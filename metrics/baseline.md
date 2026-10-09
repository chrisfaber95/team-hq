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
| T-004 | #18 (c5bedb6), +448/-2 in 10 files | 66 requests (sonnet + haiku test-runner), 8 subagents | $1.26 | 1 ($0.16) | 4 (target 3) | yes; ~10 min kickoff to merge; lead $0.46, merge $0.10 |
| T-005 | #19 (7b45491), +309/-3 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.13 |
| T-006 | #20 (f312270), +85/-1 | (interactive, not logged) | - | 2 (round 1: tests read real TEAM_HQ_DIR) | 6 | yes; merge $0.13 |
| T-007 | #21 (968c43f), +254/-12 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.16; not checked in a browser |
| T-008 | #22 (a9c9296), +614/-97 | (interactive, not logged) | - | 2 (round 1: auditor L3, revoke not persisted) | 6 | yes; merge $0.15 (2nd run; 1st refused, merge.sh fixed) |
| T-009 | #23 (69709e2), +286/-19 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.15 |
| T-010 | #24 (01eed20), +338/-8 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.14; not checked in a browser |
| T-014 | #25 (023c934), +187/-8 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.14 |
| T-011 | #26 (6a24066), +605/-28 | (interactive, not logged) | - | 2 (round 1: dependency policy file) | 6 | yes; merge $0.15; not tried on a phone |
| T-012 | #27 (440ce2f), +341/-13 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.13 |
| T-013 | #28 (9429891), +339/-16 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.14; not checked in a browser |
| T-015 | #29 (3f78b71), +272/-26 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.13 |
| T-016 | #30 (b558edc), +420/-1 | (interactive, not logged) | - | 2 (round 1: verbs swallowed other questions) | 6 | yes; merge $0.14 |
| T-017 | #31 (1d9bdf6), +396/-1 | (interactive, not logged) | - | 1 | 3 | yes; merge $0.14; not checked in a browser |

# Same-method comparison (transcript pricing)

All sessions priced from their transcripts, main session plus subagents, at list rates: input, cache write at 1.25x input,
cache read as listed, output. This reads ~20-25% below Claude Code's own estimate (transcripts appear to undercount thinking
output), so compare rows with each other, not with the table above. The token column in the table above counts only the
main model; use these rows for tokens.

| Ticket | Mode | PR size | Work sessions | Review + merge | Coordination | Total |
| --- | --- | --- | --- | --- | --- | --- |
| T-002 | baseline (opus, 1 session) | +184/-7, 3 files | $1.53 (2.76M in, 90% cache, 17k out) | ~$0.20 | - | ~$1.73 |
| T-003 | baseline (opus, 1 session) | +104/-15, 5 files | $1.82 (3.36M in, 93% cache, 25k out) | ~$0.20 | - | ~$2.02 |
| T-004 | team phase 1 (sonnet engineer) | +448/-2, 10 files | $1.26 (3.33M in, 89% cache, 9k out) | $0.26 | lead $0.46 (opus) | $1.98 |

Reading (one team ticket, so not yet a trend):
- Per PR, the team ($1.98) is level with the baseline ($1.73-2.02), on a PR 2.4-4x larger.
- The engineer on sonnet was the cheapest work session despite the biggest change; the cheaper model is part of that.
- Lead overhead is 23% of the ticket ($0.46 on opus). It should shrink per ticket once the lead runs several tickets per sprint.
- Messages: 4 against a target of 3 (lead->eng, eng->lead, lead->reviewer, reviewer->lead). Every route is in the design, so
  the target of 3 per ticket was too tight; either raise it to 4 or have the lead use an idle notice instead of the reviewer's message.
- From T-005 the engineer skill skips code-reviewer and documentation-engineer (b992eec), which should cut engineer cost further.
