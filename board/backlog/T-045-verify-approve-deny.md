---
id: T-045
repo: claude-dashboard
owner: user                # a check the user runs; no engineer run (the classifier refuses agents answering prompts)
brief: F-005
depends_on: [T-036]
contracts: []
labels: []
budget_usd: 0
review_rounds: 0
user_ok: false
pr:
---
## Goal
The user confirms on a real session that approving or denying a permission prompt from the dashboard works. T-034
merged without this proof at the user's choice (2026-10-09); this closes that gap.

## Acceptance
- [ ] Allow: a dashboard-launched session in a scratch project asks to `touch proof-file.txt`; Approve in the
      dashboard -> the file exists and the session continues
- [ ] Deny: same request; Deny -> no file, the session continues and says it was denied
- [ ] Expiry: an unanswered request falls back to the normal prompt (`claude attach`) and shows as expired
- [ ] Each of the three appears in the approval log with time, device, session and command
- [ ] Anything that fails becomes a bug ticket from the lead; F-005 is not marked shipped until all four pass

## Notes (lead)
Steps: T-034's hand-off (`board/done/T-034-permission-hook.md`, "User proof"), with the dashboard's Approve/Deny
buttons from T-036 on a **paired phone or tablet** (the PC is refused since T-035; `scripts/answer-permission.mjs` is gone). Scratch
project under `N:\Projects`, harmless command only. Until this passes, use approve/deny only for your own testing.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
