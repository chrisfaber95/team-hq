---
id: T-006
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-001
depends_on: [T-005]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 20
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
Added POST /api/alerts/dismiss {id} (must be an alert open now; 400 invalid id, 404 unknown) and POST /api/settings/alerts {threshold} (integer 1-100, else 400) in src/server/server.ts, using readJson (64 KiB cap), fixed error strings, response only {ok:true}. Both sit after the existing Host/cross-site/Origin/X-Dashboard/login checks. PR: https://github.com/chrisfaber95/claude-dashboard/pull/20. typecheck ok, npm test 196 pass; CI was pending at hand-off.
security-auditor: no Critical/High; Medium was a wrong test assertion (fixed). Lows accepted: dismiss runs a full buildState; save() failures are silent; alert text must be escaped by the client (T-007). Reviewer: note the login/401 tests are in tests/lan.test.ts, since server.test.ts has no auth. PR title is T-006 form, not Conventional Commits.

## Review (reviewer writes, one line per round)
round 1: changes - tests/server.test.ts does not isolate TEAM_HQ_DIR (defaults to the real N:\team-hq in config.ts), so 'POST /api/alerts/dismiss' fails locally whenever a ticket sits in board/review (got ['session:wait-1','ticket:T-006']); set process.env.TEAM_HQ_DIR to a missing/temp dir before importing, as tests/team.test.ts does, and re-run npm test. Endpoint code, checks order, caps and fixed errors are fine.
