---
id: T-034
repo: claude-dashboard
owner: eng-claude-dashboard-T-034
brief: F-005
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
Sessions the dashboard starts or continues hand their permission prompts to the dashboard, which holds them as
pending requests, and an allow or deny returned through the hook really lets the session go on.

## Acceptance
- [ ] `startTask` and `continueSession` add `--settings <file>` holding only a `PermissionRequest` hook that runs the
      repo's hook script (no dependency); nothing is written to user Claude config; other CLI calls are unchanged
- [ ] The hook posts tool name, full tool input and session id to a `127.0.0.1`-only endpoint with the hook secret
      (random, in `DATA_DIR`, created on first start, never in state or responses); wrong/missing secret -> 403
- [ ] Pending requests (id, session, tool, request text, time) are in the pushed state; the hook waits for an answer
      and prints the documented allow / deny decision; on timeout, a dashboard that is down, or a bad secret it exits
      with no decision (normal prompt) and the request shows as expired
- [ ] Proof on this PC, written in the hand-off with the commands used: a dashboard-started session asking for
      `touch` continues and runs it after allow, and continues without running it after deny. Answer through a test
      helper or the endpoint from T-035 (not by hand-editing files), on a harmless command in a scratch project
- [ ] Unit tests for the hook script (decision output, timeout, no dashboard) and the store; `npm run typecheck`
      and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0005-answer-permission-prompts.md`. Findings from spike T-030 (hook stdin fields, `waiting`
status, `--strict-mcp-config` needed in scratch folders) are in `team-hq/board/done/T-030-*.md`. Touches
`claude-cli.ts` (auth). If the allow/deny proof fails, stop and move the ticket to `blocked/` with what you saw.
The answer endpoint for devices is T-035; a minimal internal answer path for the proof is fine.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
