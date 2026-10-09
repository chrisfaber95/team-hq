---
id: T-037
repo: claude-dashboard
owner: eng-claude-dashboard-T-037
brief: F-004
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr: 48
---
## Goal
An always-open dashboard spends less CPU than before F-004: a push only walks the DOM of sections whose content
actually changed and that are on screen.

## Acceptance
- [ ] Per section, the new markup (or its input) is compared with the last one; when equal, `patch.ts` is not called
      for that section at all
- [ ] Sections inside a closed popup are not rendered or patched on pushes; opening the popup renders it from the
      latest state at once, and while open it updates live as today (T-027 criteria still hold)
- [ ] Relative-time ticks still only touch their own text nodes; no regression in focus, selection, scroll, drawer
      or typed input across pushes
- [ ] `node scripts/measure-cpu.mjs` with the `docs/perf.md` method (3 x 120 s) on this branch: median below the
      baseline (0.63 % at 1920x1080, 0.62 % at 390x844); numbers in the hand-off
- [ ] Tests for "unchanged section -> no patch call" and "closed popup -> no render, open -> rendered"; `npm run
      typecheck` and `npm test` pass

## Notes (lead)
From T-029's profile (`team-hq/board/blocked/T-029-f004-cpu-after.md`): after T-028, desktop median 0.67 % vs 0.63 %;
the patcher (`patchChildren`, `attrNames`, `patchHtml`, `patchAttrs`) is ~2/3 of busy time because every section,
including hidden popup sections, is re-walked on each 2 s push. Files: `src/client/patch.ts`, `src/client/app.ts`,
`src/client/popups.ts`. Server stays unchanged (brief). T-034 runs in parallel on the server only.

## Hand-off (engineer writes, max 300 tokens)
PR #48 https://github.com/chrisfaber95/claude-dashboard/pull/48 (client only, server unchanged).
- patch.ts: patchHtml remembers the last markup per element and skips the DOM walk when equal (patchIfChanged, forgetHtml; team clears it when it empties its element).
- Popup sections (projects, comms, team, usage) render only while their popup is open; opening renders from the latest state first (initPopups(onOpen), drawsSection). renderTeam(s, draw) still sets section visibility when closed.
- Tick/focus/drawer code untouched.
- Tests: patchIfChanged skip, drawsSection; typecheck + 380 tests pass.
- CPU (measure-cpu, 3x120 s, localhost, real data): 1920x1080 0.29/0.32/0.32 % (median 0.32, baseline 0.63); 390x844 0.14/0.15/0.16 % (median 0.15, baseline 0.62).
- Reviewer: no browser e2e for open-popup content/focus; check by hand. Branch is 1 commit behind main (no conflict). Commit trailer used plain Claude per repo memory.

## Review (reviewer writes, one line per round)
