# team-hq: how the agent system works today

Snapshot 2026-10-17, phase 3. Read-only description. Nothing here is a proposal.

## 1. Roles

| Role | Session name | Runs where | Model | How it starts | Lifetime |
| --- | --- | --- | --- | --- | --- |
| Lead | `lead` | `N:\team-hq`, interactive terminal | opus | you start it | until `/clear` after a sprint |
| Engineer | `eng-<repo>-<ticket>` | worktree `N:\worktrees\<repo>-<ticket>`, headless | sonnet | `scripts/dispatch.sh` | one run per ticket |
| Reviewer | `reviewer-<ticket>` | `N:\team-hq` plus the repo read-only, headless | sonnet | `scripts/review.sh` | one run per PR |
| Merger | `merge-<ticket>` | throwaway worktree, headless | the repo's `git-workflow-manager` (haiku) | `scripts/merge.sh` | one run per merge |
| Epic PR | `epic-<ticket>` | headless | `git-workflow-manager` | `scripts/epic.sh pr` | one run per epic |
| Designer | `designer` | `N:\team-hq\product`, interactive | sonnet | you start it | only in your design sessions |

The lead never writes product code. It writes tickets, contracts, decisions and board files, and is the only role that commits team-hq.

Repos: `claude-dashboard` (`N:\Projects\Claude-dashboard`, ids `T-NNN`) and `my-game-project` (`N:\Projects\MyGameProject`, Unreal Engine 5.8, ids `G-NNN`, one engineer at a time with its own editor and the Unreal MCP).

## 2. The board

`board/<repo>/<stage>/<id>-<slug>.md`, stages `backlog, ready, in-progress, review, done`, plus `blocked`. A ticket's state is its folder. Engineers and the reviewer move files with plain `mv`. Other files: `board/NEEDS-YOU.md` (your inbox, append-only), `board/SPRINT.md` (rewritten each sprint), `board/TEMPLATE.md`.

Ticket front matter: id, kind, repo, base, branch, owner, brief, depends_on, contracts, labels, budget_usd, review_rounds, user_check, user_ok, pr. Body: Goal, Acceptance, Notes, Hand-off, Review. The Review section's `round N: approve|changes` lines are what `merge.sh` reads.

## 3. The workflow

1. You give the lead goals; it writes tickets (`write-ticket` skill) and checks `product/*/briefs/` for approved briefs.
2. Epic work: `scripts/epic.sh open F-NNN <repo>` creates branch `epic/F-NNN`; ticket PRs merge into it.
3. `scripts/dispatch.sh <id> <repo>` starts an engineer. It checks `maxParallel`, creates the worktree and branch `team/<id>`, runs `npm ci`, moves the ticket to `in-progress/`, then runs `claude -p`. For the game repo it also builds and starts a per-worktree Unreal Editor.
4. The engineer implements, tests, has `git-workflow-manager` commit, push and open a PR ("don't merge"), writes the hand-off, moves the ticket to `review/`, and sends the lead one line.
5. `scripts/review.sh <id> <pr#>` starts a fresh reviewer, which writes `round N: approve|changes` in the ticket and stops.
6. On `changes`: `dispatch.sh <id> <repo> --rework`. After 2 rounds the ticket goes to `blocked/`.
7. On `approve`: `scripts/merge.sh <id> <pr#>` checks the gates, has `git-workflow-manager` merge, moves the ticket to `done/`, removes the worktree and fast-forwards your checkout.
8. When an epic's tickets are done: `epic.sh pr <epic-id>`, then review and merge as above.
9. Sprint end: `sprint-summary` skill writes `SPRINT.md` and commits team-hq; you `/clear` the lead.

## 4. Caps (`budgets.json` and the scripts)

| Run | Turns | USD | Minutes | Other |
| --- | --- | --- | --- | --- |
| Engineer | 60 | 3 | 45 (game: 75) | `maxParallel` 2 overall, 1 for the game repo |
| Reviewer | 25 | 1 | 15 | 2 review rounds |
| Epic reviewer | 40 | 2 | 25 | |
| Merger | 20 | 1 | 15 | hardcoded in `merge.sh`, not in `budgets.json` |
| Epic PR | 25 | 1 | 15 | hardcoded in `epic.sh`, not in `budgets.json` |

On a subscription the dollar cap is a usage proxy. A run that hits a cap or fails moves its ticket to `blocked/` and appends to `NEEDS-YOU.md`.

## 5. What each role may do

### Enforced (settings files, hooks, scripts)

| Role | Settings file | Allowed | Denied |
| --- | --- | --- | --- |
| Lead | `.claude/settings.json` | `dispatch/review/merge/baseline.sh`, `gh pr view/diff/checks/list`; mode `auto` | `Edit` under `N:\Projects` and `N:\worktrees`, `gh pr merge`, force pushes |
| Engineer | `.claude/engineer.settings.json`, passed by `dispatch.sh` | the unreal-editor script, `mcp__unreal` tools, two vue-skills git commands | `gh pr merge`, push to main, force push, `git branch -D`, `git checkout main*`, reading `.env*` and `.dashboard/**`, editing team-hq `CLAUDE.md`, `contracts/`, `scripts/`, `.claude/`, `budgets.json` |
| Merger | `.claude/merger.settings.json` | `gh pr merge/view/checks` | force push, `gh release`, all `Edit` and `Write`; cross-session messages refused |
| Epic PR | `.claude/epic.settings.json` | `git fetch/merge/push`, `gh pr create/view/list` | push to main, `gh pr merge`, all `Edit` and `Write` |
| Designer | `product/.claude/settings.json` | `Edit` under `product/**`, WebSearch, WebFetch | `Edit` on board, scripts, decisions, contracts, `.claude`, project and worktree dirs; `git push`, `gh pr` |

Other enforcement:
- Engineer Stop hook `scripts/hooks/stop-tests.sh` (1200 s timeout) refuses to end a run while typecheck and tests (game: `TEAM_CHECK`) fail. It skips docs-only changes and never blocks twice in a row.
- `merge.sh` checks in shell: last review line is `round N: approve`; the PR is open on the right base; all CI checks are green; for epics every child ticket is done; `user_ok: true` for labels `auth`, `deps`, `contract`, `migration` or `user_check: true`.
- Caps: `--max-turns`, `--max-budget-usd`, `timeout`, `maxParallel`.

### Stated only in prose (not enforced)

- **Reviewer** (`.claude/agents/reviewer.md`): tools are `Read, Grep, Glob, Bash, Edit, Skill`, run with `--permission-mode auto` and no deny list. "Edit only the ticket and `NEEDS-YOU.md`", "Bash only for listed commands", "never merge or push" are prose.
- **Tickets are trusted text.** Nothing stops an engineer or reviewer from changing `user_ok`, `labels` or `user_check`, or moving a ticket to `done/`.
- **Engineer:** "one module at a time", "do not delegate to subagents"; `git push origin <other-branch>` is allowed; no deny on `rm`, writing outside the worktree or network access; `mcp__unreal` is allowed wholesale.
- **Messaging routes** (engineer to lead only, reviewer sends none): no outbound restriction, only `crossSessionInbound` settings.
- **Who commits team-hq:** only the lead by rule.

## 6. Where agents and rules live

| Place | Contents |
| --- | --- |
| `N:\ClaudeData\config\CLAUDE.md` | your global instructions (graphify) |
| `team-hq\CLAUDE.md`, `README.md` | lead rules, message protocol, merge gates, escalation list, hand-run commands |
| `team-hq\.claude\` | `settings.json` (lead), `engineer/merger/epic.settings.json`, `agents\reviewer.md`, `skills\` (`write-ticket`, `engineer`, `review-pr`, `sprint-summary`) |
| `team-hq\product\` | designer: `CLAUDE.md`, `.claude\settings.json`, `agents\feasibility.md` (haiku, read-only), skills `discovery-interview`, `write-brief`, SessionStart hook `pending-briefs.sh` |
| `team-hq\decisions\` | 0001 to 0011 |
| `team-hq\contracts\` | stub only, no contracts yet |
| `Claude-dashboard\` | `CLAUDE.md` (238 lines), `.claude\agents\` (13 agents), `agents-archive\` (4), `project-params.md` (95 lines), `settings.json` (denies push to main, force push, reading `.env*` and `.dashboard/**`), `settings.local.json` |
| `MyGameProject\` | `CLAUDE.md` (214 lines), `.claude\agents\` (3: `code-reviewer`, `git-workflow-manager`, `test-runner`), `project-params.md` (27 lines), `settings.json`, `settings.local.json` |

Duplication between the repos: `code-reviewer.md` is identical in both; `git-workflow-manager.md` differs in 5 diff lines; `test-runner.md` differs in 41. The merger and epic runs use the repo's `git-workflow-manager`, so that file is part of the team system but lives outside team-hq.

## 7. What you can see today

- Count files in `board/*/in-progress/`; tail `logs/<id>.log`; look at `N:\worktrees\` and `git worktree list`; `/list-agents` in the lead; the lead gets a notification when a background `dispatch.sh` exits.
- `logs/` (gitignored) holds per ticket: `<id>.log` (a dispatch line and an exit line with subtype, turns, cost), `<id>.json` (engineer result, written only when the run ends), `<id>.review.json`, `<id>.merge.json`, `<id>.epic.json`, `<id>.baseline.json`; plus `editor-<repo>.pid` and `.log`.
- Real transcripts are Claude's normal session files under the session names in section 1.
- Dashboard Team popup (`Claude-dashboard/src/server/features/team/team.ts`, `src/client/features/team/team-panel.vue`): read-only; shows per-stage counts, up to 20 tickets in in-progress/review/blocked (id and title), and the open `NEEDS-YOU` lines. It still reads the old flat board layout, so it probably shows little until ticket T-103 merges (not verified in the running app).

## 8. Gaps

- No "currently running" file or heartbeat. The board folder changes only at start and end of a run.
- No progress against caps while a run is in flight; the result JSON appears only at the end, a timed-out run leaves a `no-json-result` marker.
- Effective permissions are spread over the files in section 6 and nothing assembles them per role.
- Orphaned worktrees, leftover editors and stale `in-progress` tickets after a crash are found and cleaned by hand (README).
- `NEEDS-YOU.md` is about 18 KB and mostly resolved history; open items are mixed in.
- Cost per sprint has to be summed from individual JSON files; `metrics/baseline.md` is hand-maintained.
- Merger and epic caps are hardcoded in the scripts.
- Small inconsistencies: decision 0001 describes an idle notice for the verdict while `review.sh` exiting is the real signal in phase 2; README's hand-run engineer command shows `--permission-mode auto` while enforcement lives in `engineer.settings.json`.
