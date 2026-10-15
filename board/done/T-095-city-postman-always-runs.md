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
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 108
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
Removed the `prefers-reduced-motion` media query around the postman animation in `src/client/features/messages/_city.scss`; it now always runs. Added `tests/client/animations-always-run.test.ts`, which fails if any `src/client` `.scss` or `.vue` file contains `prefers-reduced-motion`. T-091 behavior untouched (only the CSS rule changed). Checks: typecheck, lint, npm test (488 node, 166 vitest) all pass. PR: https://github.com/chrisfaber95/claude-dashboard/pull/108. Reviewer: confirm no other reduced-motion branch remains; no browser run was done.

## Review (reviewer writes, one line per round)
round 1: approve
