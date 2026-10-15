---
id: T-100
kind: ticket
repo: claude-dashboard
base: epic/F-008
branch:
owner: eng-claude-dashboard
brief: F-008
depends_on: [T-099]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:
---
## Goal
The kingdom moves: mailmen walk the paths from sender to receiver (or to the castle), workers arrive at and
leave their building, active buildings smoke and the castle banner waves while it is up.

## Acceptance
- [ ] A new mailman walks its T-098 route step by step along the paths (direction readable), arrives within a
      few seconds and is gone when the model drops it (30 s); a castle mailman ends at the castle gate; a
      hand-back mailman stays at its building (worker to boss); no all-time connections are drawn
- [ ] Workers appear and leave with a short transition; smoke shows only on `active` buildings and the banner
      waves only while `needsYou` is true
- [ ] With no mailman, no active building and no banner, no animation runs (no running CSS animation, no timer,
      no `requestAnimationFrame`; a test asserts it like T-091's city test)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/messages/` (`kingdom-view.vue` and its parts, `_kingdom.scss`).
- Follow `docs/motion.md` and "Walking" in `docs/isometric.md`: CSS only, transform and opacity only, timing
  tokens, keyed by mailman key, steps from `walkSteps`. No `prefers-reduced-motion` rules (`docs/architecture.md`
  "UI conventions"). Loops (smoke, banner) only for live state and on a handful of elements.
- No CPU measurement in this brief (user, 2026-10-15).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
