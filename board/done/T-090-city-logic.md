---
id: T-090
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-007
depends_on: [T-089]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 102
---
## Goal
A pure, tested model of the F-007 "city": which shops are on screen and in what state, which workers are
inside them, and which postmen are on the street at a given moment. No rendering (T-091 draws it).

## Acceptance
- [ ] Shops: every running session plus every session that sent or received a session message in the
      last hour, once each. State `active` (running, message in the last 30 s), `idle` with idle time in
      ms (running, none in 30 s), or `stopped` (not running, message in the last hour); a stopped
      session with no message in the last hour is absent
- [ ] Stable positions: a shop keeps its slot while it stays on screen; shops arriving or leaving do not
      move the others (test: add and remove shops across successive calls, the rest keep their positions)
- [ ] Postmen: one per session-to-session message newly seen, from sender shop to receiver shop, also
      when both the sender's `out` and the receiver's `in` record of it are in `messages`; each lives
      30 s from first sighting, then is gone; nothing cumulative remains. A subagent hand-back becomes a
      postman inside the parent's shop, from the worker (`agentId`, T-089) to the boss
- [ ] Workers: each `state: 'working'` subagent appears inside its session's shop; at most 6 drawn, the
      rest as a "+N more" count; done subagents are not shown as working
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/messages/`. Replace `buildMessageGraph` in `messages.logic.ts` (or add
  `city.logic.ts` beside it); keep `feedKey` and `routeText`, the feed still uses them. Until T-091 the
  panel may keep drawing the old graph from the old function, or switch to a placeholder; don't build the
  view here.
- Inputs: `state.sessions` (running), `state.messages` (newest 200; both records of one session message
  can appear), `state.subagents`, and `nowMs`. Pair an `out` with its matching `in` (same two names,
  close `tsMs`); an `in` without its `out` still gets one postman.
- "Newly seen": first sighting is tracked across calls while the popup is open (keyed by `feedKey`); on
  opening, messages with `tsMs` in the last 30 s count as new. Trips run on client time, so the 2 s push
  interval does not make them uneven.
- Brief open questions settled (technical): hand-backs are postmen inside the shop; worker cap 6 + "+N";
  shops stopped over an hour are gone.

## Hand-off (engineer writes, max 300 tokens)
Added `src/client/features/messages/city.logic.ts`: `createCityTracker().update({sessions, messages, subagents, nowMs})` returns `{shops, postmen}`. Shops: active/idle(idleMs)/stopped, stable slots (column/row), workers capped at 6 plus `moreWorkers`. Postmen: one per new message (out/in pair deduped, 30 s life, hand-backs inside the shop, worker to 'boss'). Tests in `tests/client/features/messages/city.logic.test.ts`. Old graph and panel untouched; typecheck, lint, npm test green.
PR: https://github.com/chrisfaber95/claude-dashboard/pull/102
Reviewer: check the pair dedupe (same from/to within 5 s) and that shops are keyed by session name.

## Review (reviewer writes, one line per round)
round 1: approve (diff meets all criteria; CI `check` was still pending at review time, merge.sh must wait for green)
