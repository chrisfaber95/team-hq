---
id: T-035
repo: claude-dashboard
owner: eng-claude-dashboard-T-035
brief: F-005
depends_on: [T-034, T-042]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: false            # reset 2026-10-10: user held the merge; set again after round 2
pr: https://github.com/chrisfaber95/claude-dashboard/pull/58
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
- [ ] No self-approval: the hook secret can only submit requests, never answer them; the local answer helper from
      T-034 is removed or needs a separate secret no session can read (not in a project folder, not in the hook's
      settings); a session can't answer its own request with a file it can read
- [ ] The hook script and its settings file run from a copy under `DATA_DIR` written at server start, so a session
      working in the dashboard's own repo can't change the hook that guards it
- [ ] Only a paired device may answer (decision 0005, amendment 2026-10-10): `POST /api/permissions/:id` from
      loopback (this PC) is refused with a fixed message even with valid-looking Origin / `X-Dashboard`, and the
      request stays pending; reading `/api/approvals` keeps its current access
- [ ] Tests for each answer path, refusals, double answer, the self-approval cases (incl. a forged loopback answer)
      and the audit/list; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0005-answer-permission-prompts.md`. Pattern: `GET /api/launches` from T-032
(`src/server/features/launch/launch.ts`, audit action filter in `features/audit-log/audit-log.ts`). Server only; UI
is T-036. The approve/deny store is `features/permissions/permissions.ts`; routes live in `http/routes-*.ts` and
guards in `http/guards.ts` since T-042. Follow `docs/code-style.md`: no new `LEGACY_FILES` or allowlist entries.
- Rework (lead, 2026-10-10): round 1 approved, but the user held the merge over the loopback self-approval gap you
  reported. Add the new "only a paired device may answer" criterion above; nothing else changes. Use the existing
  device-token identity, don't invent a new secret. The `DATA_DIR` hook-copy risk is accepted in 0005: no change.
  Merge `origin/main` before pushing; run the `security-auditor` agent again and put its result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)
PR #58 (https://github.com/chrisfaber95/claude-dashboard/pull/58). Added POST /api/permissions/:id (allow|deny, 404/409, same guards as the other controls), GET /api/approvals (latest 50) and audit action `approval` for allow/deny/expired. Removed the hook-secret answer/list endpoints and scripts/answer-permission.mjs; the hook script is copied to DATA_DIR at start and the settings point at the copy. typecheck, lint, 411 tests pass; security-auditor pass done.
Reviewer: a session can still POST /api/permissions/:id over loopback (loopback = this PC, forged Origin/X-Dashboard) after reading ids from /api/state; closing that needs a design decision (non-PC devices only, or a browser-only secret). DATA_DIR files are writable by a same-user session. Commit trailer uses plain "Claude" per user preference.

## Review (reviewer writes, one line per round)
round 1: approve - all 6 criteria met by the diff (answer route 404/409/400, guards, audit + /api/approvals, hook secret submit-only, hook copy in DATA_DIR, tests). CI `check` was still pending at review time (merge.sh must wait for green). Residual risk for the lead/user, not a blocker: a session can still POST /api/permissions/:id over loopback (forged Origin/X-Dashboard) as the engineer noted; needs a follow-up design decision.
