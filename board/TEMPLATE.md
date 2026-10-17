---
id: T-000                 # <prefix>-NNN, numbered per repo; prefix in budgets.json repoSettings (decision 0011)
kind: ticket              # ticket | epic (one per brief, the PR epic -> main; decision 0008)
repo:                     # a name from the repos list in CLAUDE.md
base: main                # epic/F-NNN for a brief's tickets; main for epic tickets and tickets without a brief
branch:                   # epic tickets only: epic/F-NNN
owner: eng-<repo>
brief:                    # F-NNN when the ticket comes from a product brief
depends_on: []
contracts: []
labels: []                # low-risk | migration | contract | auth | deps | assets (informational)
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_check: false         # true: the user looks before the merge (asked by the user; Blueprint logic, decision 0010)
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration or with user_check
pr:                       # engineer fills in, e.g. 88
---
## Goal
One or two sentences: the outcome, not the implementation.

## Acceptance
- [ ] Observable, testable criterion
- [ ] The repo's two standard criteria from `write-ticket` (claude-dashboard: checks pass + code style;
      my-game-project: `unreal-editor.sh check` passes + only the listed assets change)

## Notes (lead)
Pointers to files, contracts or decisions. Keep it short.

## Hand-off (engineer writes, max 300 tokens)
What changed, PR link, anything the reviewer must look at.

## Review (reviewer writes, one line per round)
