---
id: T-012
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-008]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true
pr:
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

## Review (reviewer writes, one line per round)
