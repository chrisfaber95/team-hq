---
id: T-092
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-007
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 103
---
## Goal
`scripts/measure-cpu.mjs` can measure with a popup open, and `docs/perf.md` records the CPU of today's
Session communication popup as the F-007 "before" number.

## Acceptance
- [ ] `node scripts/measure-cpu.mjs <url> <seconds> <viewport> --popup comms` opens that popup after load
      (before the warm-up) and fails clearly if it cannot; without `--popup` it behaves as before
- [ ] The option parsing is a pure function with a unit test (the suite still never starts a browser)
- [ ] `docs/perf.md` gets a "Before F-007" table: current main, same PC and method as F-004, 1 run x 60 s
      each at 1920x1080 and 390x844, popup open and popup closed (4 runs, about 5 min in all)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `scripts/` (with `tests/measure-cpu.test.ts` and `docs/perf.md`). Method and F-004 numbers are
  in `docs/perf.md`; popup ids in `src/client/features/popups/`.
- Measure on main before T-091 merges, or the "before" is lost.

## Hand-off (engineer writes, max 300 tokens)
PR #103: https://github.com/chrisfaber95/claude-dashboard/pull/103
- `scripts/measure-cpu.mjs --popup <id>` opens the popup after load, before warm-up; fails clearly (missing/hidden button, popup not open, unknown id). `parseArgs` exported, pure, 3 new unit tests; no browser in the suite.
- `docs/perf.md` "Before F-007" (cab3b0b, main before T-091): 3 x 120 s per cell (more than the cut-down 1 x 60 s). Medians: 1920x1080 comms open 0.25 % / closed 0.18 %; 390x844 open 0.18 % / closed 0.10 %.
- Checks: typecheck, lint, npm test (473 node + 164 component) pass; build ok.
- Look at: the popup-click script in `openPopup`, and that the script imports POPUPS from `src/client/features/popups/popups.logic.ts` (type-only imports, runs on Node 24).


## Review (reviewer writes, one line per round)
