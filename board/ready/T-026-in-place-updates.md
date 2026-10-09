---
id: T-026
repo: claude-dashboard
owner: eng-claude-dashboard-T-026
brief: F-004
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
Live updates change only the values that changed: a push leaves unchanged sections and nodes untouched, so nothing
flickers, scrolls or loses the reader's place.

## Acceptance
- [ ] A push whose data equals the previous one writes nothing to the DOM; relative times ("3m ago", session uptime)
      still advance through their own light tick that only updates those text nodes
- [ ] A changed push updates only the changed nodes in projects, live sessions (incl. recent), session messages,
      token usage, limits, team and alerts: rows are keyed (session id, project name, message, day), unchanged rows
      and sections keep their DOM nodes; the limits gauge animation does not restart
- [ ] Across pushes these survive: scroll position (also at 390 px width), keyboard focus, a text selection inside a
      section, the open transcript drawer, an open `<details>`, usage legend toggles, typing in a form
- [ ] The patch logic is unit-tested (against a small fake DOM in `tests/`, no jsdom/happy-dom dependency), including
      "unchanged node kept" and "only changed text written"; `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief: `team-hq/product/briefs/F-004-cockpit-redesign.md`. Cause: `src/client/app.ts` `renderProjects`,
`renderSessions`, `renderComms` and `renderUsage` set `innerHTML` on every 2 s push (`server.ts:485` sends the full
state each time); limits/team/alerts skip identical HTML but rebuild the whole section on any change. `core.ts` is the
in-place pattern to follow. Technical choice: no framework and no new dependency; a small keyed patcher or per-row
updates, your call. Layout is out of scope (T-027/T-028 follow). Server and transcript-drawer polling stay as they are
(brief). Don't touch `claude-cli.ts`.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
