---
id: T-036
repo: claude-dashboard
owner: eng-claude-dashboard-T-036
brief: F-005
depends_on: [T-035, T-033]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
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

## Notes (lead)
Design: `team-hq/decisions/0005-answer-permission-prompts.md`. Popups from T-027 (`src/client/popups.ts`), patcher
from T-026 (`src/client/patch.ts`), cockpit layout from T-028. Waits for T-033 (same client files).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
