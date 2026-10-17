---
id: T-025
repo: claude-dashboard
owner: eng-claude-dashboard-T-025
brief: F-004
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/40
---
## Goal
A repeatable way to measure the CPU use of an always-open dashboard tab, plus the "before" numbers for F-004, so the
redesign can show it is lighter than today.

## Acceptance
- [ ] `node scripts/measure-cpu.mjs` (args: URL, seconds, viewport) starts a locally installed Chrome or Edge headless,
      opens the dashboard, waits for a warm-up, then prints the tab's average CPU % over the window (from CDP
      `Performance.getMetrics` `TaskDuration` deltas / wall time); a clear error if no browser is found
- [ ] No new dependency: CDP over Node's built-in `WebSocket`; the browser is found by its usual install paths or a
      `--browser <path>` argument
- [ ] `docs/perf.md` describes the method and records the baseline measured on commit `20fcd90` (today's main):
      3 runs of 120 s each at 1920x1080 and at 390x844, with the median
- [ ] The CPU % calculation is a pure function with a unit test; `npm run typecheck` and `npm test` pass (the test
      suite does not start a browser)

## Notes (lead)
Brief: `team-hq/product/briefs/F-004-cockpit-redesign.md` (acceptance: CPU before/after). The server pushes the full
state every 2 s (`src/server/server.ts:485`); measure with real `~/.claude` data, the server read-only as usual.
Run the dashboard without `--lan` (localhost, no login). Don't touch `src/client` (T-026 runs in parallel there) or
`claude-cli.ts`. If no browser can run headless on this PC, move the ticket to `blocked/` with what you tried.

## Hand-off (engineer writes, max 300 tokens)
Rework run, but the Review section was empty (the earlier run only stopped on a session limit), so there were no
review points to address. Added `scripts/measure-cpu.mjs` (headless Chrome/Edge over CDP with Node's built-in
WebSocket, no dependency; `--browser`, `--warmup`; pure `cpuPercent`), `tests/measure-cpu.test.ts` (no browser) and
`docs/perf.md` (method plus baseline on 20fcd90: median 0.63 % at 1920x1080, 0.62 % at 390x844, 3x120 s each).
typecheck pass, `npm test` 358/358. PR: https://github.com/chrisfaber95/claude-dashboard/pull/40 (commit 394976b).
Reviewer: the PR title is not in Conventional Commits form (`T-025: ...`, per the engineer skill); the baseline
numbers come from the earlier run and this run did not re-measure them. No `src/client` or `claude-cli.ts` changes.

## Review (reviewer writes, one line per round)
round 1: approve - all 4 criteria met by reading the diff; no new dependency, no src/ changes; baseline medians check out arithmetically (not re-measured). CI `check` was still pending at review time, so merge.sh must wait for green.
