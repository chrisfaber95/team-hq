---
id: T-003
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
