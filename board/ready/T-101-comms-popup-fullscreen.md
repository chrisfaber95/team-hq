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
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:
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

## Review (reviewer writes, one line per round)
