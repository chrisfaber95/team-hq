---
id: T-094
kind: ticket              # ticket | epic (one per brief, the PR epic -> main; decision 0008)
repo: claude-dashboard
base: main                # epic/F-NNN for a brief's tickets; main for epic tickets and tickets without a brief
branch:                   # epic tickets only: epic/F-NNN
owner: eng-claude-dashboard
brief:                    # F-NNN when the ticket comes from a product brief
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 1
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 105
---
## Goal
CI runs the test suite only where it guards `main` (pushes to `main`, PRs into `main`); PRs into an
`epic/*` branch run typecheck and lint only (decision 0008, "Light CI per ticket").

## Acceptance
- [ ] In `.github/workflows/ci.yml`, `npm run typecheck` and `npm run lint` run on every PR and push as today;
      `npm test` runs only when `github.event_name == 'push' || github.base_ref == 'main'`
- [ ] The job keeps its name `check` (merge.sh and branch rules read it), and this PR itself (into `main`)
      still runs the tests and is green
- [ ] Changed text follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- One file: `.github/workflows/ci.yml` (step-level `if:` on the test step). No workflow for `epic/*` pushes
  is needed; epic PRs into `main` get the full run.
- If `docs/architecture.md` or the README describes CI, update that sentence.

## Hand-off (engineer writes, max 300 tokens)
ci.yml: `npm test` step now has `if: github.event_name == 'push' || github.base_ref == 'main'`; typecheck and lint unchanged; job still `check`. PR: https://github.com/chrisfaber95/claude-dashboard/pull/105. Reviewer: confirm this PR (into main) shows tests running in CI; the skip path only shows on a PR into an epic/* branch. No docs mentioned CI. No local checks run (workflow-only).

## Review (reviewer writes, one line per round)
round 1: approve
