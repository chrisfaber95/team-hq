---
id: T-029
repo: claude-dashboard
owner: eng-claude-dashboard-T-029
brief: F-004
depends_on: [T-025, T-028, T-037]
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 1
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/49
---
## Goal
Show that the F-004 dashboard uses less CPU than before, and close the brief's remaining checks.

## Acceptance
- [ ] `docs/perf.md` records the "after" numbers on main after T-028, with the same method, runs and viewports as the
      T-025 baseline; the median is lower than the baseline at both viewports (if not: profile, record the top cost,
      move the ticket to `blocked/`)
- [ ] `docs/architecture.md` describes the in-place update and popup structure in a few lines
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief F-004 acceptance "CPU use ... measured before and after, and is lower after". The browser checks (three skins,
phone/tablet/desktop, no flicker, drawer/selection survive) go to the user via `NEEDS-YOU.md` when this merges.

## Hand-off (engineer writes, max 300 tokens)
Rework after T-037 (Review section empty; followed the lead note: main already contains T-037, so no merge needed). Re-measured on 230235b with the T-025 method (3 x 120 s, 15 s warm-up, real data, port 4790, commands off): 1920x1080 median 0.16 % (baseline 0.63 %), 390x844 median 0.10 % (baseline 0.62 %); both lower. Added the "After F-004" section to docs/perf.md and an in-place update/popup paragraph to docs/architecture.md. Docs only: typecheck/tests skipped per project-params. PR: https://github.com/chrisfaber95/claude-dashboard/pull/49 (commit ac2cca1). Reviewer: check the numbers are plausible (large drop vs baseline; data differs from baseline day, noted in perf.md) and that architecture.md matches patch.ts/drawPopup.
## Review (reviewer writes, one line per round)
round 1: approve

## Blocked
Measured on main a5190ca (after T-028), same method as baseline (3 x 120 s, 15 s warm-up, real data, port 4790, commands off):
- 1920x1080: 0.66 / 0.73 / 0.67 -> median 0.67 % vs baseline 0.63 % (NOT lower)
- 390x844: 0.56 / 0.60 / 0.55 -> median 0.56 % vs baseline 0.62 % (lower)

Desktop profile (60 s, idle excluded, self time): "(program)" 121 ms; patcher `patchChildren` 69 ms, `attrNames` 58 ms, `patchHtml` 50 ms, `patchAttrs` 30 ms, `patchNode` 11 ms (patcher total ~220 ms of ~330 ms busy, about 2/3). GC 38 ms.
Top cost: the in-place patcher (`src/client/patch.ts`) re-walks and diffs every section's whole DOM on each 2 s push, including the hidden popup sections that now stay rendered; the desktop layout renders more sections than before.
Question: skip patching when the section markup string is unchanged (or when popup is closed), as a new ticket, or accept and relax the criterion? No docs/code changed; docs/perf.md and architecture.md not written.

## Lead (2026-10-09)
Fix, not relax: T-037 makes the patcher skip unchanged sections and closed popups and measures itself. After T-037 is done, this ticket is re-run with `--rework`: merge main into the branch first, then re-measure and write `docs/perf.md` / `architecture.md` as specified. Depends on T-037.
