---
id: T-016
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-003
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 2
user_ok: false
pr: 30
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
Added pure `src/client/chat-logic.ts` (`parseIntent`, `answer`, matching by name/project/id prefix, ambiguity lists candidates, message intents `needsConfirm`, tokens only, no DOM/network) plus 20 tests in `tests/chat-logic.test.ts` and architecture.md entries. Typecheck and 309 tests pass. PR: https://github.com/chrisfaber95/claude-dashboard/pull/30. Reviewer: check the phrasing regexes (e.g. attention vs status precedence) and that `ack`/`open` verbs do not swallow other questions.

Round 1 rework (f00eceb): a verb (ack/open/summary) with no session/alert match now falls through to the attention/usage/status intents ("view usage", "clear alerts", "summary of my usage"); `usageReply` guards `usage.totals`; 4 new tests. Typecheck + 313 tests pass, CI `check` green.

## Review (reviewer writes, one line per round)
round 1: changes - (1) ack/open/summary verbs swallow other questions: "view usage", "view sessions", "go to alerts", "clear alerts", "summary of my usage" hit OPEN_RE/ACK_RE/SUMMARY_RE and reply "No session/alert matches ..." instead of usage/status/attention; when the match is `none` and the text also matches the attention/usage/status regexes, fall through to those intents. (2) Add tests for those phrasings (they are untested; the 20 tests only cover the happy path of each verb). (3) `usageReply` reads `state.usage.totals` unguarded while `days` is guarded with `?.`; guard both. Rest is fine: precedence attention>usage>status is sensible, ambiguity lists candidates, tokens only, no DOM/network, message needsConfirm. CI `check` was still IN_PROGRESS at review time; lead confirm it is green before merge.
round 2: approve
