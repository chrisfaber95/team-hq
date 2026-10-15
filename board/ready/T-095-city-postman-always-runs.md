---
id: T-095
kind: ticket              # ticket | epic (one per brief, the PR epic -> main; decision 0008)
repo: claude-dashboard
base: main                # epic/F-NNN for a brief's tickets; main for epic tickets and tickets without a brief
branch:                   # epic tickets only: epic/F-NNN
owner: eng-claude-dashboard
brief: F-007
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 1
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:                       # engineer fills in, e.g. 88
---
## Goal
City postmen walk on the user's PC: the postman animation no longer sits behind a `prefers-reduced-motion`
rule, which the UI conventions forbid (Windows "Animation effects" is off there, so the postmen never move).

## Acceptance
- [ ] `src/client/features/messages/_city.scss` runs the postman animation unconditionally; no
      `prefers-reduced-motion` rule or reduced-motion branch is left anywhere in `src/client/`
- [ ] A test fails if any `src/client/**/*.scss` or `.vue` file contains `prefers-reduced-motion`
- [ ] Everything T-091 asserts still holds (no postman element and no running animation when none is on screen)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Rule: `docs/architecture.md` "UI conventions" ("Animations always run"). The lead's T-091 notes asked for
  reduced-motion support by mistake; the hand-off said "Reduced motion: postman sits at the receiver".
- Folder: `src/client/features/messages/`; the guard test goes beside the other client tests.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
