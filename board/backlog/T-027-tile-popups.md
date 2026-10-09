---
id: T-027
repo: claude-dashboard
owner: eng-claude-dashboard-T-027
brief: F-004
depends_on: [T-026]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The main view shows only what matters at a glance; every other tile opens from a button as a popup that keeps updating
live.

## Acceptance
- [ ] Main view: needs-you alerts, subscription limits plus today's total tokens, live sessions (and the core strip in
      Co-pilot/Root). A fixed button bar opens popups for: projects, session messages, team board, 14-day token usage,
      chat, run a task, devices, activity. Fixed set and order; not user-arrangeable. Buttons for sections that are
      hidden today (team without a board, devices/run when not allowed) stay hidden
- [ ] A popup closes on a click outside it, its close button and Esc; focus returns to its button; one popup at a
      time; `role="dialog"` with a label
- [ ] An open popup keeps updating live without closing, jumping or losing typed input, focus or selection; the
      building dialog and transcript drawer still open from inside the projects / sessions popups
- [ ] Devices and activity content is moved unchanged; every function in them still works
- [ ] Popup open/close state logic is unit-tested; `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief F-004; tile split confirmed by the user 2026-10-09 (lead's split, see the brief's "Questions from lead").
Reuse the dialog pattern of `building.ts` / `.building`. Style popups from the skin tokens in `style.scss` so
Classic, Co-pilot and Root all work without editing the skin look. Grid/page layout is T-028, not here.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
