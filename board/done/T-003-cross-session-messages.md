---
id: T-003
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/17
---
## Goal
Session-to-session messages (cross-session `SendMessage` between named sessions such as `lead`,
`eng-*`, `reviewer-*`) show up correctly in the dashboard, with the real sender and receiver names.

## Acceptance
- [ ] The session-to-session transcript format is confirmed from a real transcript on this PC and documented in `docs/architecture.md` "Data sources" (replacing "**unconfirmed**")
- [ ] Incoming messages show the sender's session name (not `unknown`); outgoing ones show the target name
- [ ] Subagent hand-backs are still classified as `subagent`, not `session`
- [ ] A test fixture built from a real, redacted line covers both directions
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
Parsing lives in `src/server/transcripts.ts` (`peerOrigin()`, ~line 235; incoming ~377; outgoing `SendMessage` ~393).
Real examples: the headless runs from 2026-10-08 (session names `reviewer-T-001`, `merge-T-001`) and
any phase-1 session that messaged `lead`. Transcripts are under `N:\ClaudeData\config\projects\`; read them,
never write there, and never copy tokens or secrets into fixtures.

## Hand-off (engineer writes, max 300 tokens)
PR #17 https://github.com/chrisfaber95/claude-dashboard/pull/17 (branch `fix/cross-session-messages`, commit 7bcd092). CI `check` is green. Not merged.
- The lead's examples had no real session message: `reviewer-T-001`'s send to `lead` failed ("not reachable"), and every incoming peer line was a subagent hand-back. I captured the real format with a headless `claude -p -n probe-T-003` that messaged this session, and documented it in `docs/architecture.md`. Incoming messages are `queued_command` attachments whose `origin.name` is the sender and `from` is a `uds:` pipe address. Outgoing messages are `SendMessage` with `to`.
- New `peerName()` returns `name`, else `from` unless it's a `uds:` address, else `unknown`. Outgoing names drop the ListAgents `[ref]`. The transcript viewer now shows incoming session messages; it used to drop attachments. Hand-backs are still `subagent`.
- The fixture is built from real redacted lines and covers both directions. Typecheck is clean and 159/159 tests pass.
- Follow-ups: failed sends are still listed, and an outgoing message to a subagent's agentId still counts as `session`.

## Review (reviewer writes, one line per round)
round 1: approve
