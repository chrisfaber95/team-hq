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
| T-020 | #32 (6b8a519), +164/-0 | 4 (headless) | $0.54 | 1 ($0.14; 1st run hit session limit, $0.08) | 1 | yes; merge $0.16; phase 2 headless |
| T-018 | #33 (6422eea), +291/-10 | 1 + 4 (2 runs; 1st hit session limit) | $0.78 + $0.67 | 1 ($0.16) | 1 | yes; merge $0.13 |
| T-019 | #34 (cdc7c1b), +338/-14 | 1 (headless; process hung ~18 min after finishing) | $1.88 | 1 ($0.22) | 1 | yes; merge $0.15; auth, user_ok |
| T-021 | #35 (a005b0f), +121/-4 | 4 (headless) | $0.52 | 1 ($0.16) | 1 | yes; merge $0.14 |
| T-022 | #36 (26eaf9d), +69/-13 | 20 (headless) | $0.39 | 1 ($0.15) | 1 | yes; merge $0.12 |
| T-023 | #37 (3d7b7cc), +32/-3 | 6 (headless) | $0.31 | 1 ($0.13) | 1 | yes; merge $0.13; auth, user_ok |
| T-024 | #38 (20fcd90), +178/-40 | 4 (headless) | $1.03 | 1 ($0.18) | 1 | yes; merge $0.15; auth, user_ok; user verified on a phone |
| T-025 | #40, +255/-0 | 2 runs (1 hit session limit) | $0.78 | 1 ($0.16) | 1 | yes; CI pending once, re-merged |
| T-026 | #39, +306/-64 | 1 | $0.77 | 1 ($0.16) | 1 | yes |
| T-027 | #41, +363/-86 | 2 runs (1 hit session limit) | $0.86 | 1 ($0.18) | 1 | yes |
| T-028 | #44, +95/-13 | 1 | $0.74 | 1 ($0.13) | 1 | yes |
| T-029 | #49, +17/-0 | 2 (1 blocked: CPU not lower -> T-037) | $0.68 | 1 ($0.12) | 2 | yes |
| T-030 | no PR (spike, closed) | 1 (blocked by classifier) | $0.40 | - | 1 | n/a; findings -> decision 0005 |
| T-031 | #42, +30/-2 | 1 | $0.62 | 1 ($0.14) | 1 | yes; auth, user_ok |
| T-032 | #43, +147/-14 | 1 | $0.59 | 1 ($0.15) | 1 | yes |
| T-033 | #45, +167/-91 | 1 | $0.79 | 1 ($0.15) | 1 | yes |
| T-034 | #46, +535/-8 | 3 (rework for T-038 guard; 1 hit session limit) | $2.25 | 2 ($0.38) | 2 | merge agent refused twice (classifier) until the user's proof; auth, user_ok |
| T-037 | #48, +93/-18 | 2 | $0.91 | 2 ($0.29) | 2 | yes |
| T-038 | #47, +177/-2 | 1 | $0.44 | 1 ($0.14) | 1 | yes |
| T-039 | #51, +462/-454 | 1 | $0.78 | 1 ($0.15) | 1 | yes; auth, user_ok |
| T-040 | #52, +224/-207 | 2 | $1.05 | 2 ($0.30) | 2 | yes; auth, user_ok |
| T-043 | #54, +1788/-1198 | 1 | $1.72 | 1 ($0.62) | 1 | yes |
| T-044 | #55, +751/-538 | 2 (1 blocked: scope split) | $2.01 | 1 ($0.21) | 2 | yes; auth, user_ok |
| T-046 | #50, +1557/-112 | 1 | $0.51 | 1 ($0.17) | 1 | yes; deps, user_ok |
| T-041 | #53, merged 50d28f5 | 2 (rework: merge main) | $1.66 | 2 ($0.55) | 2 | yes; auth, user_ok |
| T-047 | #56, +295/-292 | 1 | $0.90 | 1 ($0.14) | 1 | yes |
| T-042 | #57, +1452/-826 | 1 | $2.27 | 1 ($0.28) | 1 | yes; auth, user_ok |
| T-035 | #58, +358/-124 | 2 (user held: loopback gap) | $2.31 | 2 ($0.27) | 2 | yes; auth, user_ok after rework |
| T-036 | #59, +429/-8 | 1 (run hung after hand-off, stopped; cost not logged) | - | 1 ($0.17) | 1 | yes; auth, user_ok |
| T-048 | #60, +2289/-2209 | 1 | $1.46 | 1 ($0.16) | 1 | yes; relabelled auth, user_ok |
| T-060 | #61, +2906/-820 (lockfile) | 4 | $0.38 | 1 ($0.15) | 1 | yes; deps |
| T-049 | #62, +9/-6 | 4 | $0.24 | 1 ($0.10) | 1 | yes; deps; merge re-run after CI pending |
| T-058 | #63, +65/-14 | 6 | $0.44 | 1 ($0.12) | 1 | yes; auth, user_ok |
| T-055 | #64, +370/-84 | 4 | $0.78 | 1 ($0.21) | 1 | yes |
| T-059 | #65, +28966/-0 (vendored Markdown) | 59 over 6 runs | $0.79 | 1 ($0.16) | 6 | no: user copied files and committed (classifier blocks agents in .claude/) |
| T-057 | #66, +118/-17 | 1 | $0.64 | 1 ($0.14) | 1 | yes; auth, user_ok |
| T-056 | #67, +64/-23 | 26 | $0.53 | 1 ($0.13) | 1 | yes; auth, user_ok |
| T-050 | #68, +1281/-1929 | 4 | $1.02 | 1 ($0.21) | 1 | yes; deps |
| T-061 | #69, +25/-15 | 4 | $0.33 | 1 ($0.25, 2 runs: session limit) | 1 | yes after one merge re-run (classifier refusal) |
| T-051 | #70, +183/-8 | 4 | $0.38 | 1 ($0.18, 2 runs: session limit) | 1 | yes |
| T-054 | #72, +124/-3 | 5 over 2 runs (session limit) | $0.48 | 1 ($0.14) | 1 | yes |
| T-053 | #71, +207/-7 | 30 over 2 runs (session limit) | $0.73 | 1 ($0.14) | 1 | yes; with T-054 broke lint on main, fixed in T-052 |
| T-052 | #73, +175/-58 | 4 | $0.49 | 1 ($0.19) | 1 | yes |
| T-062 | #74 | 6 over 1 run | $0.38 | 1 ($0.11, 1 runs) | 1-2 | yes |
| T-063 | #75 | 4 over 1 run | $0.45 | 1 ($0.14, 1 runs) | 1-2 | yes |
| T-064 | #79 | 4 over 1 run | $0.46 | 1 ($0.17, 1 runs) | 1-2 | yes |
| T-065 | #83 | 6 over 1 run | $0.38 | 1 ($0.16, 1 runs) | 1-2 | yes |
| T-066 | #92 | 12 over 2 runs (conflict rework / session limit) | $0.64 | 2 ($0.22, 2 runs) | 1-2 | yes |
| T-067 | #94 | 7 over 2 runs (conflict rework / session limit) | $0.80 | 2 ($0.34, 2 runs) | 1-2 | yes |
| T-068 | #76 | 21 over 2 runs (conflict rework / session limit) | $0.71 | 2 ($0.25, 2 runs) | 1-2 | yes |
| T-069 | #77 | 14 over 3 runs (conflict rework / session limit) | $0.86 | 3 ($0.29, 3 runs) | 1-2 | yes |
| T-070 | #78 | 20 over 1 run | $0.41 | 1 ($0.14, 1 runs) | 1-2 | yes |
| T-071 | #95 | 14 over 3 runs (conflict rework / session limit) | $1.07 | 2 ($0.39, 4 runs) | 1-2 | yes |
| T-072 | #85 | 12 over 3 runs (conflict rework / session limit) | $1.02 | 2 ($0.26, 2 runs) | 1-2 | yes |
| T-073 | #89 | 32 over 2 runs (conflict rework / session limit) | $1.01 | 2 ($0.37, 2 runs) | 1-2 | yes |
| T-074 | #98 | 4 over 1 run | $0.44 | 1 ($0.15, 1 runs) | 1-2 | yes |
| T-075 | #88 | 23 over 1 run | $0.54 | 1 ($0.15, 1 runs) | 1-2 | yes |
| T-076 | #90 | 4 over 1 run | $1.05 | 1 ($0.20, 1 runs) | 1-2 | yes |
| T-077 | #93 | 5 over 1 run | $0.45 | 1 ($0.17, 1 runs) | 1-2 | yes |
| T-078 | #84 | 9 over 2 runs (conflict rework / session limit) | $1.01 | 2 ($0.46, 3 runs) | 1-2 | yes |
| T-079 | #87 | 27 over 1 run | $0.59 | 1 ($0.15, 1 runs) | 1-2 | yes |
| T-080 | #91 | 53 over 3 runs (conflict rework / session limit) | $1.26 | 3 ($0.44, 3 runs) | 1-2 | yes |
| T-081 | #96 | 26 over 3 runs (conflict rework / session limit) | $1.24 | 2 ($0.29, 2 runs) | 1-2 | yes |
| T-082 | #81 | 4 over 1 run | $1.05 | 1 ($0.21, 1 runs) | 1-2 | yes |
| T-083 | #86 | 4 over 1 run | $0.57 | 1 ($0.16, 1 runs) | 1-2 | yes |
| T-084 | #99 | 6 over 1 run | $0.67 | 1 ($0.23, 1 runs) | 1-2 | yes |
| T-085 | #80 | 4 over 1 run | $0.46 | 1 ($0.13, 1 runs) | 1-2 | yes |
| T-086 | #82 | 14 over 3 runs (conflict rework / session limit) | $0.93 | 2 ($0.34, 2 runs) | 1-2 | yes |
| T-087 | #100 | 4 over 1 run | $1.31 | 1 ($0.25, 1 runs) | 1-2 | yes |
| T-088 | #97 | 1 over 1 run | $0.34 | 1 ($0.11, 1 runs) | 1-2 | yes |
| T-089 | #101 | 19 over 1 run | $0.29 | 1 ($0.13, 1 runs) | 1 | yes; merge re-run (CI pending) |
| T-090 | #102 | 4 over 1 run | $0.56 | 1 ($0.14, 1 runs) | 1 | yes |
| T-091 | #104 | 6 over 1 run | $0.68 | 1 ($0.18, 1 runs) | 1 | yes |
| T-092 | #103 | 5 over 1 run | $0.51 | 1 ($0.12, 1 runs) | 2 | yes |
| T-093 | #106 | 8 over 1 run | $0.35 | 1 ($0.11, 1 runs) | 2 | yes |
| T-094 | #105 | 4 over 1 run | $0.19 | 1 ($0.10, 1 runs) | 1 | yes |
| T-095 | #108 | 4 over 1 run | $0.27 | 1 ($0.11, 1 runs) | 1 | yes |
| T-096 | #107 | 4 over 1 run | $0.28 | 1 ($0.13, 1 runs) | 1 | yes |

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
