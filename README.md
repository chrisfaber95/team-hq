# team-hq

Control repo for a small team of Claude Code sessions: one **lead**, one **engineer** per repo
(one capped run per ticket), and a **reviewer**. They coordinate through the board in `board/`
and one-line cross-session messages. Design: "Multi-Session Agent Team Setup" doc
(claude.ai/artifact/NWjLVADvftSEyHRzPoDJju).

**Current phase: 0 (baseline).** Pilot repo: `claude-dashboard` (`N:\Projects\Claude-dashboard`).

| Path | What |
| --- | --- |
| `CLAUDE.md` | lead rules + message protocol |
| `board/` | tickets (`TEMPLATE.md`), `NEEDS-YOU.md` (your inbox), `SPRINT.md` |
| `budgets.json` | caps, parallelism, repo paths |
| `scripts/dispatch.sh`, `scripts/review.sh` | headless engineer / reviewer runs (phase 2) |
| `.claude/skills/` | `write-ticket`, `engineer`, `review-pr`, `sprint-summary` |
| `.claude/agents/reviewer.md` | reviewer role (read-only on code) |
| `metrics/baseline.md` | phase-0 baseline and per-ticket team metrics |
| `logs/` | run logs and JSON results (gitignored) |

## Phase 0: baseline (do this first)

Work five real tickets in the pilot repo with **one ordinary session**, no team:

```powershell
cd N:\Projects\Claude-dashboard; claude
```

After each merged PR, record tokens / cost / wall time from `/usage` (or the dashboard's usage view)
in `metrics/baseline.md`. **Gate:** baseline averages recorded.

## Phase 1: pilot team, all interactive

Three terminals:

```powershell
# 1. lead (you talk to this one)
cd N:\team-hq; claude --name lead --model opus

# 2. engineer
cd N:\Projects\Claude-dashboard; claude --name eng-claude-dashboard --model sonnet --add-dir N:\team-hq --permission-mode auto --settings N:\team-hq\.claude\engineer.settings.json

# 3. reviewer
cd N:\team-hq; claude --name reviewer --agent reviewer --add-dir N:\Projects\Claude-dashboard
```

Ask the lead to write tickets (`write-ticket`) and message the engineer one ticket at a time; the
engineer follows the `engineer` skill (tell it "work T-001, use the engineer skill at
N:/team-hq/.claude/skills/engineer/SKILL.md" if it doesn't pick it up). The lead forwards review
requests to the reviewer. Check `/list-agents` in the lead to see who is reachable.

**Gate:** ten tickets merged at a cost per PR near the baseline.

## Phase 2: headless engineers

The lead dispatches, reviews and merges through the scripts; you handle `NEEDS-YOU.md`:

```bash
bash scripts/dispatch.sh T-012 claude-dashboard           # engineer run in N:\worktrees\claude-dashboard-T-012
bash scripts/review.sh   T-012 42                         # fresh reviewer for PR #42
bash scripts/dispatch.sh T-012 claude-dashboard --rework  # after "changes requested"
bash scripts/merge.sh    T-012 42                         # after "approved": gates, then git-workflow-manager merges
```

- Caps from `budgets.json` (60 turns / $3 engineer, 2 parallel). On a subscription the dollar cap is a
  usage proxy, not a bill.
- Any run that hits a cap or fails moves its ticket to `blocked/` and writes `NEEDS-YOU.md`.
- Engineers run with `.claude/engineer.settings.json`: deny rules block pushes to `main`,
  force-pushes, `gh pr merge` and edits to team-hq config; a Stop hook
  (`scripts/hooks/stop-tests.sh`) refuses to end a run while typecheck/tests fail. These apply
  only to team engineers, not to your own sessions in the repo. CI runs on every PR.
- Git work goes through the repo's `git-workflow-manager` agent: engineers have it commit, push and
  open the PR ("don't merge"); `merge.sh` has it merge once the ticket's last review line is
  `approve` and CI is green, then moves the ticket to `done/` and removes the worktree.
- Tickets labelled `auth`, `deps`, `contract` or `migration` need your `user_ok: true` in the ticket
  before `merge.sh` will merge; it escalates to `NEEDS-YOU.md` instead.

**Gate:** every run that hits a cap escalates instead of failing silently.

## Your loop

1. Read `board/NEEDS-YOU.md`.
2. Talk to `lead` about goals.
3. Set `user_ok: true` on approved high-risk tickets you accept.
4. End of sprint: lead runs `sprint-summary`, you `/clear` the lead.
