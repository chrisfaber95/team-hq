---
id: T-017
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-003
depends_on: [T-016]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_ok: false
pr: 31
---
## Goal
A chat panel in the dashboard, usable at the PC and on a phone, where the user asks what's going on and steers
sessions with a confirm step.

## Acceptance
- [ ] Chat panel with input and reply history (in memory only), usable at desktop width and at 375 px; replies come from T-016's `answer()` on the current state
- [ ] A message intent first shows the session and the exact text with Confirm/Cancel; only Confirm calls `POST /api/sessions/:id/message`; the server's error (e.g. "This session is open in a terminal or editor...") is shown as the reply
- [ ] `ack` calls `POST /api/alerts/dismiss`; `open` opens that session's transcript drawer
- [ ] The chat never calls start, stop or `/api/commands` (a test checks the module's calls); `summary` replies "coming soon" until T-018
- [ ] Pure UI state logic (pending confirm, history) has `node:test` coverage; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0004-chat-without-a-model.md`. Follow "UI conventions" in `docs/architecture.md` (all
skins, no inline styles, `esc()` everywhere, tooltips via `textContent`) and include it in the `frontend-developer`
delegation. Transcript drawer and message call: `src/client/controls.ts`. Not `low-risk`: it sends messages to
sessions, though only through the existing endpoint.

## Hand-off (engineer writes, max 300 tokens)
Chat panel (`chat.ts`, pure `chat-state.ts`, section in index.html, SCSS with tokens only, no inline styles) answering via T-016 `answer()`. Message intents need Confirm; only Confirm posts to `/api/sessions/:id/message` (mode auto/default/plan from the server list; aborts if the session is gone); `ack` posts `/api/alerts/dismiss`; `open` opens the drawer; `summary` says coming soon. `tests/chat.test.ts` scans chat.ts for forbidden endpoints. security-auditor: no critical/high/medium, two lows fixed. Typecheck, 323 tests, build pass. PR: https://github.com/chrisfaber95/claude-dashboard/pull/31. Reviewer: NOT checked in a browser (375 px layout, Classic/Co-pilot/Root skins, Confirm flow); CI `check` was pending at hand-off.

## Review (reviewer writes, one line per round)
