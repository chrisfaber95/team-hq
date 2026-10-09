---
id: T-016
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-003
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
A pure client module understands the chat's fixed questions and commands and answers them from the current
`DashboardState`, so the chat panel (T-017) only has to render.

## Acceptance
- [ ] `parseIntent(text, state)` recognises `status` ("what's running?"), `attention` ("what needs me?"), `usage` (tokens, limits), `message` ("send/tell <session>: <text>"), `ack` ("acknowledge/dismiss <alert>"), `open` ("open <session>"), `summary` ("summarize <session>") and falls back to `help`; a few phrasings each, case-insensitive
- [ ] Sessions and alerts are matched by name, project or id prefix; no match or several matches gives a reply listing the candidates instead of guessing
- [ ] `answer(intent, state)` builds the reply text from the same fields the dashboard shows (live sessions and status, open alerts, token totals, limit windows with percentage and reset); tokens only, never cost; `help` lists everything the chat can do
- [ ] Message intents carry the resolved session and the exact text, and are marked "needs confirm"; nothing in this module calls the network
- [ ] `node:test` coverage per intent incl. ambiguous and unknown input; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0004-chat-without-a-model.md`. New `src/client/chat-logic.ts`, pure like `mood.ts` and
`alerts-logic.ts`; reuse `moodOf` for session status. Keep it text-in/intent-out so a voice front-end can reuse it
later. No UI in this ticket.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
