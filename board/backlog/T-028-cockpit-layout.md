---
id: T-028
repo: claude-dashboard
owner: eng-claude-dashboard-T-028
brief: F-004
depends_on: [T-027]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The dashboard reads as a dense, status-first cockpit that fills any screen, from a phone to an ultrawide monitor,
without changing the look of the skins.

## Acceptance
- [ ] Desktop: the page uses the full browser width (no centred `max-width` column) from 1280 px to 3440 px; alerts,
      limits and live sessions are visible without scrolling at 1280x720, 1920x1080 and 3440x1440
- [ ] Phone 390x844 and tablet 820x1180 / 1180x820: alerts and limits are visible without scrolling; no horizontal page
      scroll; the sessions table stays usable (cards or scroll inside its tile)
- [ ] Stronger hierarchy: a compact one-line header; alerts and limits are the first and most prominent tiles, the
      needs-you count and the highest limit % in large type; the alerts tile is visibly highlighted only when non-empty
- [ ] Classic, Co-pilot and Root keep their colours, fonts and artwork; Classic light/dark still follows the OS
- [ ] `npm run typecheck`, `npm test` and `npm run build` pass; layout breakpoints are listed in the hand-off

## Notes (lead)
Brief F-004. Today: `main { max-width: 1200px }` in `src/client/style.scss:101` (and the header at :85), sections
stacked in `index.html`. Skin partials `_skin-copilot.scss` / `_skin-root.scss` may need layout-only fixes; don't
change their tokens or artwork. Wall mode (big-type status-only display) is out of scope.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
