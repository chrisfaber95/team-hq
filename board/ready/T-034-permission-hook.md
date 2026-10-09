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
- [ ] Proof steps for the user in the hand-off: exact commands to start the PR branch's dashboard, launch a session
      in a scratch project that asks for `touch`, and answer it allow / deny through a small answer helper you ship
      (e.g. `node scripts/answer-permission.mjs <id> allow|deny`), with what to expect each time. You may run the
      steps up to the held prompt; don't answer a held prompt yourself (the classifier refused that in T-030; the
      user runs the answer step before setting `user_ok`)
- [ ] Unit tests for the hook script (decision output, timeout, no dashboard) and the store; `npm run typecheck`
      and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0005-answer-permission-prompts.md`. Findings from spike T-030 (hook stdin fields, `waiting`
status, `--strict-mcp-config` needed in scratch folders) are in `team-hq/board/done/T-030-*.md`. Touches
`claude-cli.ts` (auth). The answer endpoint for devices is T-035; the helper only needs a local path (hook secret).
If the user's proof fails, T-035/T-036 stop and F-005 goes back to the user (decision 0005, Consequences).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
