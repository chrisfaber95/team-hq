---
id: T-001
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 15
---
## Goal
Prepare the pilot repo for the agent team: CI, a cheap test-runner subagent, universal deny rules,
and a smaller CLAUDE.md.

## Acceptance
- [ ] `.github/workflows/ci.yml` runs `npm ci`, `npm run typecheck`, `npm test` on PRs and pushes to main, and passes on this PR
- [ ] `.claude/agents/test-runner.md` uses `model: haiku`, has no edit tools, returns only failures + summary
- [ ] `.claude/settings.json` denies pushing to main, force-push, reading `.env*` and `.dashboard/**`, and keeps the existing marketplace config
- [ ] Sections moved from `CLAUDE.md` to `docs/architecture.md` are verbatim (nothing lost), with a pointer section; the `.dashboard/` secrets rule is still in CLAUDE.md; the plugin-managed `project-setup` block is unchanged
- [ ] No source or test code changes

## Notes (lead)
Set up by the lead session before the team existed; dogfoods review.sh and merge.sh.

## Hand-off (engineer writes, max 300 tokens)
PR https://github.com/chrisfaber95/claude-dashboard/pull/15 (branch `chore/agent-team-setup`).
Config/docs only. Check especially that the CLAUDE.md move lost nothing: compare the removed lines
with `docs/architecture.md`. Local typecheck + 155/155 tests passed; CI green.

## Review (reviewer writes, one line per round)
round 1: approve
