---
id: T-035
repo: claude-dashboard
owner: eng-claude-dashboard-T-035
brief: F-005
depends_on: [T-034]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
A signed-in device can approve or deny a pending permission request, and every answer is logged.

## Acceptance
- [ ] `POST /api/permissions/:id` with `allow` or `deny` answers a pending request once; unknown, expired or already
      answered -> 404/409 with a fixed message; no "always allow" or bypass option exists
- [ ] Same access as the existing controls (signed-in device, commands enabled, same CSRF/Origin rules); without it
      -> refused, the request stays pending
- [ ] Every allow, deny and expiry is audited: time, device, session, tool, request text (up to 500 chars), outcome;
      `GET /api/approvals` returns the latest 50, newest first, same access as `/api/audit`
- [ ] Tests for each answer path, refusals, double answer and the audit/list; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0005-answer-permission-prompts.md`. Pattern: `GET /api/launches` from T-032
(`src/server/launch.ts`, audit action filter in `audit-log.ts`). Server only; UI is T-036.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
