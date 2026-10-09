---
id: T-000
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # F-NNN when the ticket comes from a product brief
depends_on: []
contracts: []
labels: []                # low-risk | migration | contract | auth | deps
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:                       # engineer fills in, e.g. 88
---
## Goal
One or two sentences: the outcome, not the implementation.

## Acceptance
- [ ] Observable, testable criterion
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
Pointers to files, contracts or decisions. Keep it short.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
