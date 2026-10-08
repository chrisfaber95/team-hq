# team-hq

Control repo for a small team of Claude Code sessions: one **lead**, one **engineer** per repo
(one capped run per ticket), and a **reviewer**. They coordinate through the board in `board/`
and one-line cross-session messages. Design: "Multi-Session Agent Team Setup" doc
(claude.ai/artifact/NWjLVADvftSEyHRzPoDJju).

**Current phase: 1 (pilot team).** Phase 0 baseline done: ~$2.16 and 32 turns per merged PR (`metrics/baseline.md`). Pilot repo: `claude-dashboard` (`N:\Projects\Claude-dashboard`).

| Path | What |
| --- | --- |
| `CLAUDE.md` | lead rules + message protocol |
| `board/` | tickets (`TEMPLATE.md`), `NEEDS-YOU.md` (your inbox), `SPRINT.md` |
| `budgets.json` | caps, parallelism, repo paths |
| `scripts/dispatch.sh`, `review.sh`, `merge.sh` | headless engineer / reviewer runs and the gated merge |
| `scripts/baseline.sh` | ordinary non-team session per ticket, for baseline measurements |
| `.claude/skills/` | `write-ticket`, `engineer`, `review-pr`, `sprint-summary` |
| `.claude/agents/reviewer.md` | reviewer role (read-only on code) |
| `metrics/baseline.md` | phase-0 baseline and per-ticket team metrics |
| `logs/` | run logs and JSON results (gitignored) |

## Running the agents by hand

### Start the interactive sessions

One terminal (PowerShell) each. The `--name` matters: sessions message each other by name.

```powershell
# lead: you talk to this one
cd N:\team-hq; claude --name lead --model opus

# engineer: works in the repo, sees the board through --add-dir, runs with the engineer guardrails
cd N:\Projects\Claude-dashboard; claude --name eng-claude-dashboard --model sonnet --add-dir N:\team-hq --permission-mode auto --settings N:\team-hq\.claude\engineer.settings.json

# reviewer: read-only on code, writes its verdict in the ticket
cd N:\team-hq; claude --name reviewer --agent reviewer --add-dir N:\Projects\Claude-dashboard
```

Run `/list-agents` in any of them to check that the other three are reachable.

### What to type in each

Normally you only talk to the **lead**: "next goals: ...", "write tickets for X", "run T-005".
It messages the engineer and the reviewer for you.

To drive a session yourself, skipping the lead:

| Session | Type this | It ends by |
| --- | --- | --- |
| lead | `Move T-005 to ready and send it to eng-claude-dashboard.` | messaging the engineer |
| engineer | `Work T-005 with the engineer skill. Create branch team/T-005 from origin/main first.` | opening a PR (via `git-workflow-manager`, no merge), ticket to `review/`, one line to `lead` |
| reviewer | `Review T-005, PR #19, with the review-pr skill.` | a `round N: approve` or `changes` line in the ticket; it sends no message |
| lead, after approval | `Merge T-005: bash scripts/merge.sh T-005 19` | PR merged, ticket in `done/` |

If the engineer doesn't pick up the skill, point it at `N:/team-hq/.claude/skills/engineer/SKILL.md`.

### Between tickets, sprints and restarts

- **Engineer:** `/clear` after each ticket. In phase 1 it works in your main checkout, so it
  switches branches there.
- **Reviewer:** `/clear` after each PR, so it never carries one PR into the next.
- **Lead:** at the end of a sprint, ask for `sprint-summary`, then `/clear`.
- **Closed a terminal?** Run the same command with `--resume <name>` added, e.g.
  `claude --resume lead --name lead --model opus`. Pass the engineer's `--settings` and
  `--add-dir` again; flags aren't saved with the session.

### Headless runs (no terminal needed)

From `N:\team-hq`, in Git Bash or with `bash` from PowerShell. Each run is one fresh, capped
session; output goes to `logs/<id>.log` and `logs/<id>*.json` (turns, tokens, cost).

```bash
bash scripts/dispatch.sh T-012 claude-dashboard           # engineer in its own worktree N:\worktrees\claude-dashboard-T-012
bash scripts/review.sh   T-012 42                         # fresh reviewer for PR #42
bash scripts/dispatch.sh T-012 claude-dashboard --rework  # engineer again after "changes requested"
bash scripts/merge.sh    T-012 42                         # gates, then git-workflow-manager merges
bash scripts/baseline.sh claude-dashboard T-020           # ordinary non-team session (baseline measurements)
```

To stop a headless run, press Ctrl+C in its terminal. Then move the ticket from `in-progress/`
back to `ready/` and remove its worktree:
`git -C N:\Projects\Claude-dashboard worktree remove --force N:\worktrees\claude-dashboard-T-012`.

## Phase 0: baseline (done)

Two tickets (T-002, T-003) worked by ordinary sessions with `scripts/baseline.sh`; results and the
same-method comparison with the team are in `metrics/baseline.md`.

## Phase 1: pilot team, all interactive

The three interactive sessions above. The lead writes tickets (`write-ticket`), messages the
engineer one ticket at a time, sends review requests with an idle notice, and merges with
`scripts/merge.sh` (decision `decisions/0001`).

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
