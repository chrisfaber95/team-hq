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
pr:                       # engineer fills in, e.g. 88
---
## Goal
`scripts/measure-cpu.mjs` can measure with a popup open, and `docs/perf.md` records the CPU of today's
Session communication popup as the F-007 "before" number.

## Acceptance
- [ ] `node scripts/measure-cpu.mjs <url> <seconds> <viewport> --popup comms` opens that popup after load
      (before the warm-up) and fails clearly if it cannot; without `--popup` it behaves as before
- [ ] The option parsing is a pure function with a unit test (the suite still never starts a browser)
- [ ] `docs/perf.md` gets a "Before F-007" table: current main, comms popup open, same PC and method as
      F-004, 3 runs x 120 s at 1920x1080 and 390x844 with medians, plus a popup-closed run of the same sitting
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `scripts/` (with `tests/measure-cpu.test.ts` and `docs/perf.md`). Method and F-004 numbers are
  in `docs/perf.md`; popup ids in `src/client/features/popups/`.
- Measure on main before T-091 merges, or the "before" is lost.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
