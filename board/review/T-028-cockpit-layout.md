---
id: T-028
repo: claude-dashboard
owner: eng-claude-dashboard-T-028
brief: F-004
depends_on: [T-027]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/44
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

## Review (reviewer writes, one line per round)
round 1: approve

## Hand-off
Full-width cockpit grid: max-width removed, compact header, alerts/limits first. Needs-you count and highest limit % in large type; alerts tile highlighted (`has-alerts`) only when non-empty. Skin SCSS untouched. PR: https://github.com/chrisfaber95/claude-dashboard/pull/44
Breakpoints (min-width): <1000px one column (alerts, limits, sessions, core, popup-bar); >=1000px two columns 340-400px | 1fr (left alerts, limits, core, popup-bar; sessions right); >=2200px three columns (alerts/core/bar | sessions | limits). Gauges auto-fit min 150px.
Checks: typecheck, 365 tests, build pass. Playwright at 390x844, 820x1180, 1180x820, 1280x720, 1920x1080, 3440x1440 in all 3 skins: no horizontal scroll, alerts and limits tops in view.
Reviewer look at: at 1280x720 limits bottom is 721px (Co-pilot) and 748px (Root), so last gauge px are below the fold; Classic dark and phone sessions-table scroll not inspected. Branch is 1 commit behind main.
