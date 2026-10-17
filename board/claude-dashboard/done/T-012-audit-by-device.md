---
id: T-012
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-008]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 27
---
## Goal
Every command and session action in the audit log names the device that made it, and the log can be read through the
API filtered by device.

## Acceptance
- [ ] Each `audit()` entry for start, message, stop and device create/revoke has `device` (name) and `deviceId` (`pc` for the loopback exemption); old entries without them still parse
- [ ] `GET /api/audit?device=<id>` (any signed-in device) returns the newest entries first, at most 200, optionally filtered by device id; only allowlisted fields (`ts`, `action`, `device`, `deviceId`, `project`, `session`, `mode`, `ok`, `prompt` already cut to 200 chars); malformed lines skipped
- [ ] The file read is bounded (last 1 MB of `commands.log` at most); errors give a fixed string
- [ ] Tests with a fixture log (temp `DASHBOARD_DATA_DIR`) for the filter, limit, malformed lines and device fields on new entries; `npm run typecheck` and `npm test` pass

## Notes (lead)
`audit()` is in `src/server/claude-cli.ts`; the calls are in `src/server/server.ts`. The request needs to carry the
device from T-008's auth check. `commands.log` lives in `.dashboard/`, which holds secrets: serve only the parsed,
allowlisted fields, never the raw file or anything else from that folder. Run `security-auditor` before the PR.
Can run in parallel with T-009/T-010 only if it doesn't touch the same lines of `server.ts`; the lead dispatches it after T-009.

## Hand-off (engineer writes, max 300 tokens)
All audit() calls in server.ts now spread one `actor` {device: name, deviceId} ('This PC'/'pc' for the loopback exemption and localhost mode). This changes the T-008/T-009 entries that held the id in `device`; the reader maps id-looking `device` values on old lines to deviceId. New src/server/audit-log.ts + GET /api/audit[?device=<id>]: any signed-in device, last 1 MB of commands.log at most, newest first, max 200 after the filter, malformed lines skipped, allowlisted fields only (ts, action, device, deviceId, project, session, mode, ok, prompt<=200), filter regex [A-Za-z0-9_-]{1,64} else 400, unreadable log -> fixed 500. PR: https://github.com/chrisfaber95/claude-dashboard/pull/27. typecheck ok, npm test 271 pass; build not run (no client change).
security-auditor: no Critical/High/Medium. Low, not changed: L1 each request reads/parses up to 1 MB (a signed-in device could spam; short cache would fix), L2 first line always dropped on a mid-file start, L3 filter matches deviceId only. Any signed-in device can read all prompts (as specified). Reviewer: check the allowlist in toAuditEntry and the route placement after the login gate. Named-device entry is tested end to end with a fake CLI in lan.test.ts. No auth label in the repo; PR title is T-012 form.

## Review (reviewer writes, one line per round)
round 1: approve
