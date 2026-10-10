---
id: T-036
repo: claude-dashboard
owner: eng-claude-dashboard-T-036
brief: F-005
depends_on: [T-035, T-033, T-044]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true
pr:
---
## Goal
The owner sees what a waiting session asks permission for and approves or denies it from the dashboard, and can look
back at past answers.

## Acceptance
- [ ] A session with a pending request shows the tool name and the full command or target (as text, wrapped, never
      HTML) with Approve and Deny buttons, in live sessions and in the needs-you alerts
- [ ] Approve / Deny calls T-035's endpoint; the request disappears when answered or expired, and the session no
      longer shows as waiting once it continues; errors (expired, already answered, no access) show a fixed message
- [ ] An "Approvals" popup in the button bar lists the approval log (time, device, session, tool, request, outcome)
- [ ] Updates go through the in-place patcher (an open request never jumps or loses focus); pure logic unit-tested;
      `npm run typecheck` and `npm test` pass

- [ ] On this PC (the `pc` device) the request shows without Approve / Deny and with a fixed hint: answer from a paired
      phone or tablet, or with `claude attach` here (decision 0005 amendment: the server refuses the PC with 403
      "answering needs a paired device"; show that message if it ever comes back)

## Notes (lead)
Design: `team-hq/decisions/0005-answer-permission-prompts.md` incl. the 2026-10-10 amendment (only paired devices
answer). Endpoints from T-035: `POST /api/permissions/:id`, `GET /api/approvals`. Popups in
`src/client/features/popups/`, patcher in `src/client/app/patch.ts`, alerts and sessions in `src/client/features/`.
Follow `docs/code-style.md`: no new `LEGACY_FILES` or allowlist entries. Runs in parallel with T-048 (server tests),
which empties `LEGACY_FILES`: merge `origin/main` before handing off and keep both sides' removals.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
