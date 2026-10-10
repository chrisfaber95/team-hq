---
id: T-035
repo: claude-dashboard
owner: eng-claude-dashboard-T-035
brief: F-005
depends_on: [T-034, T-042]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 2
user_ok: true
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
Round 2, PR #58 (https://github.com/chrisfaber95/claude-dashboard/pull/58), commit 06b3220, CI `check` green. POST /api/permissions/:id now answers 403 "answering needs a paired device" (request stays pending) when there is no device session, the caller is the loopback PC, or the socket peer is this PC (127.0.0.0/8, ::1, mapped forms, own interface addresses; `isLocalPeer` in auth/loopback.ts). /api/approvals unchanged. typecheck, lint, 414 tests pass.
security-auditor, pass 1: found a real bypass: the PC may create devices (decision 0003), so a session could mint a device, log in with a forged LAN Host and answer. Closed by the socket-peer check. Pass 2: 127.0.0.2 and IPv6 zone gaps, fixed and tested; no remaining bypass reported.
Reviewer: look at `ServerOptions.isLocalPeer` (test seam, constructor only, never env/flag). Limits: a phone behind a same-PC proxy/tunnel is refused; no answering in localhost mode or at the PC (use `claude attach`); DATA_DIR hook copy risk accepted in 0005. Second pass was by code reading, not an exploit run.

## Review (reviewer writes, one line per round)
round 1: approve - all 6 criteria met by the diff (answer route 404/409/400, guards, audit + /api/approvals, hook secret submit-only, hook copy in DATA_DIR, tests). CI `check` was still pending at review time (merge.sh must wait for green). Residual risk for the lead/user, not a blocker: a session can still POST /api/permissions/:id over loopback (forged Origin/X-Dashboard) as the engineer noted; needs a follow-up design decision.
round 2: approve - new criterion met: POST /api/permissions/:id returns 403 (request stays pending) without a device session, for the PC device, or when the socket peer is this PC (isLocalPeer covers 127/8, ::1, mapped, own interface addresses, zone stripped; Host ignored); /api/approvals unchanged; isLocalPeer seam is constructor-only; tests cover forged loopback, minted device + forged Host, isLocalPeer. CI check + GitGuardian green. Still needs user_ok (label auth, currently false) before merge.sh.
