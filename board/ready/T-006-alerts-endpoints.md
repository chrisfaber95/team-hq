---
id: T-006
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-001
depends_on: [T-005]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The browser can dismiss an alert and change the usage threshold through two small POST endpoints that go through
every existing request check.

## Acceptance
- [ ] `POST /api/alerts/dismiss` with `{ id }` dismisses an open alert through the T-005 store; an unknown or malformed id gets a 4xx with a fixed error string
- [ ] `POST /api/settings/alerts` with `{ threshold }` accepts an integer 1-100, persists it, and the next state build uses it; anything else gets a 400 with a fixed error string
- [ ] Both endpoints sit behind the existing Host guard, cross-site rejection, same-origin `Origin`, `X-Dashboard: 1` and (in LAN mode) login; tests in `tests/server.test.ts` cover a valid call and a rejected call without `X-Dashboard`/login for each
- [ ] Body size is capped like `/api/commands`; nothing from the request is echoed back
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
Not `low-risk`: new write endpoints on a remote-execution surface. Run `security-auditor` before opening the PR and
mention its result in the hand-off. Follow the `/api/commands` handler in `src/server/server.ts` for body parsing and
checks; don't loosen any rule in the repo's CLAUDE.md "Request checks" list.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
