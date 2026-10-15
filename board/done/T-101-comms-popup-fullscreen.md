---
id: T-101
kind: ticket
repo: claude-dashboard
base: epic/F-008
branch:
owner: eng-claude-dashboard
brief: F-008
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: https://github.com/chrisfaber95/claude-dashboard/pull/109
---
## Goal
On desktop the Session communication popup uses the full screen, so the kingdom scene can fill it; other
popups and the phone layout stay as they are.

## Acceptance
- [ ] On a desktop-width screen the `comms` popup fills the viewport (small margin allowed) and its content
      area grows with it; every other popup keeps its current size
- [ ] On phone width the `comms` popup looks and scrolls as today; closing (Esc, backdrop, Close) and focus
      return work as before (existing tests stay green)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/popups/` (`popup-shell.vue`, `popups.logic.ts`: e.g. a per-popup size flag that
  becomes a CSS class). Don't touch `features/messages/`: T-097..T-100 work there; the scene fills whatever
  space the popup's content area gives it.
- CSS classes only (no inline styles); light/dark and skins as for the other popups.
- No CPU measurement in this brief (user, 2026-10-15).

## Hand-off (engineer writes, max 300 tokens)
The `comms` popup gets class `popup--full` (`popupFrameClass()` in `popups.logic.ts`, bound in `popup-shell.vue`). `style.scss` makes it fill the viewport and its panel flex-grow, only at `min-width: 801px`; phone is unchanged. Other popups untouched. Test added in `popups.logic.test.ts`. Ran typecheck, lint, `npm test` (662 pass: node 496, Vitest 166). PR: https://github.com/chrisfaber95/claude-dashboard/pull/109 (into epic/F-008). Reviewer: no browser check was done, so look at the desktop layout and that `.panel` scrolls when content overflows.

## Review (reviewer writes, one line per round)
round 1: approve
