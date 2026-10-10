---
id: T-048
repo: claude-dashboard
owner: eng-claude-dashboard-T-048
brief:
depends_on: [T-042, T-047]
contracts: []
labels: [auth]            # renamed LAN_MODE / COMMANDS_ENABLED in src/server/config.ts (LAN mode)
budget_usd: 3
review_rounds: 1
user_ok: true
pr: https://github.com/chrisfaber95/claude-dashboard/pull/60
---
## Goal
The server tests read like the code they test, and the cleanup ends with no exceptions left: both readability
allowlists are empty.

## Acceptance
- [ ] `tests/server/**` and any remaining test files follow `docs/code-style.md` (decision 0006): full-word names,
      no nested ternaries, named constants, a one-line purpose per suite
- [ ] Tests check the same things as before: same number of tests, same assertions; auth, lan and commands tests
      keep every case
- [ ] `LEGACY_FILES` in `eslint.config.js` and both allowlists in `tests/code-structure.test.ts` are empty (remove
      the lists or leave them empty with the "may only shrink" comment); `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass; new and changed code follows `docs/code-style.md`

## Notes (lead)
Split from T-044. Last cleanup ticket: if anything outside `tests/` is still listed (a server or client file a
previous ticket missed), fix it here when small, or move this ticket to `blocked/` with the list. Known leftovers:
`src/server/config.ts` (out of T-042 scope), `tests/measure-cpu.test.ts`, and 3 `eslint-disable id-denylist` on
`Identity.sid` (T-042; keep them if renaming would change a JSON shape, and say so in the hand-off).

## Hand-off (engineer writes, max 300 tokens)
PR #60 https://github.com/chrisfaber95/claude-dashboard/pull/60. LEGACY_FILES is now empty (both code-structure allowlists already were). ~380 short/banned names in tests/server and measure-cpu renamed with a scope-aware TS language-service rename; 4 oversized suites (auth, commands, lan, subagents) split into feature-named files with a shared *-test-setup.ts each; one-line purpose comment on every server test file. src/server/config.ts: LAN_MODE -> isLanMode, COMMANDS_ENABLED -> canRunCommands (call sites in server.ts, state.ts). Same counts as before: 384 test() blocks, 1386 assert calls; typecheck, lint, npm test (414) pass. Kept one eslint-disable id-denylist in the auth test for Identity.sid (renaming would change src types); the 3 in src untouched. Reviewer: check that split files kept every case (esp. auth, lan, commands) and that renamed names read correctly.

## Review (reviewer writes, one line per round)
round 1: approve
