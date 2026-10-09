---
id: T-034
repo: claude-dashboard
owner: eng-claude-dashboard-T-034
brief: F-005
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 2
user_ok: true
pr: https://github.com/chrisfaber95/claude-dashboard/pull/46
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
PR #46 (https://github.com/chrisfaber95/claude-dashboard/pull/46). Hook script `scripts/permission-hook.mjs`, store `src/server/permissions.ts`, `--settings` on start/resume only, `/hook/permission[/answer]` (loopback + secret, else 403), `permissions` in pushed state, helper `scripts/answer-permission.mjs`. typecheck + 387 tests pass; security-auditor: no critical/high.
Reached the held prompt on a real session (state `waiting`, request listed); I did NOT answer it. Scratch removed.

**User proof** (in the PR branch checkout, port 4777 free):
1. `mkdir N:\Projects\scratch-proof` ; add `.claude\settings.json` with `{"disabledMcpjsonServers":["playwright"]}` if a parent `.mcp.json` shows an MCP dialog.
2. `npm start` (leave running).
3. Launch: `curl -s -X POST http://127.0.0.1:4777/api/commands -H "Origin: http://127.0.0.1:4777" -H "X-Dashboard: 1" -H "Content-Type: application/json" -d "{\"project\":\"scratch-proof\",\"prompt\":\"Run exactly this shell command and nothing else: touch proof-file.txt\",\"permissionMode\":\"default\"}"`
4. After ~30 s: `node scripts/answer-permission.mjs` lists the id and `touch proof-file.txt`; session shows `waiting`.
5. Allow: `node scripts/answer-permission.mjs <id> allow` -> expect `proof-file.txt` created, session continues. Repeat step 3, then `... <id> deny` -> expect no file, Claude says it was denied.
6. Expiry: leave one unanswered 9 min -> normal prompt (`claude attach`), request "expired" in `/api/state`.

Rework (lead note): merged main (T-038) and moved `permissions.ts` to `src/server/features/permissions/permissions.ts` (test mirrored under `tests/server/features/permissions/`), imports only, allowlist untouched. Pushed ad5edf5; typecheck pass, 390 tests pass (incl. folder-map guard), CI `check` green. Scripts and proof steps above unchanged.

Review: findings left for T-035 (shared hook/answer secret, audit by device, session editing the hook in the dashboard's own repo). Commit trailer uses plain "Claude" per user memory.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met in diff (settings only on start/resume, loopback+secret 403s, hash-compared secret, expiry/abandon, helper, tests); CI `check` was still running at review time, merge.sh must confirm green; label `auth` needs user_ok after the user's allow/deny proof.
round 2: approve - re-checked after rework (move to `features/permissions/`, imports only, no behaviour change); CI `check` and GitGuardian green; `auth` label still needs the user's allow/deny proof before merge.

## Lead (rework, 2026-10-09)
Not a review finding: T-038 merged the folder-map guard (`tests/code-structure.test.ts`). Merge main into the branch and move `src/server/permissions.ts` to `src/server/features/permissions/permissions.ts` (test under the mirrored `tests/` path), imports only, no behaviour change; the guard and all tests must pass. Don't extend the allowlist. Keep the user proof steps in the hand-off valid (update paths if they change).
