---
id: T-059
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007 tooling
depends_on: []
contracts: []
labels: [low-risk]        # Markdown only, no package dependency; the user approved the source 2026-10-10
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: 65                    # committed and opened by the user (classifier blocks agents from committing .claude/)
---
## Goal
Engineers and reviewers working on the Vue migration (decision 0007) have the community Vue 3 skills in the
repo, so they write `.vue` code against documented Vue practice instead of memory.

## Acceptance
- [ ] `.claude/skills/` contains `vue-best-practices`, `vue-debug-guides`, `vue-testing-best-practices` and
      `create-adaptable-composable`, copied unchanged (all files, including `references/` and `reference/`)
      from https://github.com/vuejs-ai/skills at commit `c9d355ff23f654309dd02006be671859df0a134c`; no
      other skills from that repo
- [ ] `docs/vendored-skills.md` names the source repo, the commit, the four skill folders and how to
      update them, and the repo's MIT `LICENSE` is in `.claude/skills/LICENSE-vuejs-ai-skills`
- [ ] The repo `CLAUDE.md` says: for `.vue` work load `vue-best-practices` (component tests:
      `vue-testing-best-practices`; Vue runtime warnings: `vue-debug-guides`), and where a vendored skill
      disagrees with decision 0007, `docs/code-style.md` or `CLAUDE.md`, the repo docs win (e.g. no Pinia,
      no Options API, no `v-html`)
- [ ] `npm run typecheck`, `npm run lint` and `npm test` still pass (no code changes)

## Notes (lead)
- Don't edit the vendored files; differences with our rules go in `CLAUDE.md`, not in the skills.
- Left out on purpose: Options API, JSX, Pinia and Router skills (0007 uses `<script setup>`, its own
  typed store, no router).
- Hand-off: say whether the copied skills show up in your own skill list after copying (tells the lead whether headless runs load repo skills; T-050 checks again).
- Clone into a temporary directory outside the worktree and copy the four folders in; don't run anything
  from the clone. Use exactly `git clone https://github.com/vuejs-ai/skills <tmp-dir>` and
  `git -C <tmp-dir> checkout c9d355ff23f654309dd02006be671859df0a134c`: `engineer.settings.json` allows only these two
  (user's choice, 2026-10-10). Anything else the classifier blocks: move the ticket to blocked/, don't work around it.

- 2026-10-10 blocked (lead): runs 1 and 2 both stopped at the clone; the classifier denies `git clone` of the source repo. User chose to allow the clone in `engineer.settings.json` (run 3).
- 2026-10-10 blocked (lead): run 3 cloned fine; the copy into `.claude/skills/` was refused (see ## Blocked). User allowed the copy for this run only (they checked the files). Clone into `/tmp/vuejs-skills-<suffix>` (the run-3 clone may still be there) and copy with exactly these two commands, each on its own, not chained: `cp -r /tmp/vuejs-skills-<suffix>/skills/vue-best-practices /tmp/vuejs-skills-<suffix>/skills/vue-debug-guides /tmp/vuejs-skills-<suffix>/skills/vue-testing-best-practices /tmp/vuejs-skills-<suffix>/skills/create-adaptable-composable .claude/skills/` and `cp /tmp/vuejs-skills-<suffix>/LICENSE .claude/skills/LICENSE-vuejs-ai-skills`. Then delete the old `## Blocked` section and carry on.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)

## Blocked
**Run 7 (2026-10-10), read first:** the user's manual copy is in place and verified identical to c9d355f (four folders + LICENSE, `git diff --no-index` against the clone). Written, uncommitted in the worktree: `docs/vendored-skills.md`, `CLAUDE.md` ("Vue work" section + reference entry). After `npm ci`: typecheck, lint and `npm test` pass (node:test 423/0, vitest 1 file). Hand-off stopped: the classifier denied delegating commit/push/PR to `git-workflow-manager` ("Auto-Mode Bypass"), probably because the commit stages `.claude/skills/`. Needs the user or lead to commit and push `team/T-059` and open the PR (or allow it). No PR yet. Skill-list question: the copied skills were not in my startup skill list as repo skills at first; vue-* skills do appear in the list this run, since the folders existed at session start.

**Lead, 2026-10-10:** run 6 proved the classifier refuses any write into `.claude/` ("Self-Modification"), allow rule or not; the `cp` rules are removed again. The user copies the four folders and `LICENSE-vuejs-ai-skills` into this worktree's `.claude/skills/` by hand. You then: check they match the source at `c9d355f` (`git diff --no-index` against a fresh clone, read-only), write `docs/vendored-skills.md` (moved out of `.claude/` for this reason), update `CLAUDE.md`, run the checks and hand off. Don't write anything under `.claude/` yourself. If the four folders are not there, stop and say so here.

Run 6 (rework, Review still empty): clone at /tmp/vuejs-skills-1Pnsud verified at c9d355f. Ran exactly `cp -r /tmp/vuejs-skills-1Pnsud/skills/vue-best-practices /tmp/vuejs-skills-1Pnsud/skills/vue-debug-guides /tmp/vuejs-skills-1Pnsud/skills/vue-testing-best-practices /tmp/vuejs-skills-1Pnsud/skills/create-adaptable-composable .claude/skills/`; denied by the auto-mode classifier, reason "[Self-Modification]". Not worked around. The allow rule in `engineer.settings.json` evidently doesn't match the form (absolute source paths vs the `/tmp/vuejs-skills-*` glob) or the classifier overrides it. Needs the user to run the two copies themselves or fix the rule.

Run 5 (rework): the `## Review` section is still empty, so there are no review points to address, and nothing has been copied (`.claude/skills/` has no vue folders; worktree clean). The classifier denial from run 4 stands and no new permission was given in `engineer.settings.json`, so I did not retry the copy. The clone is still at /tmp/vuejs-skills-1Pnsud (commit c9d355f).
Run 4 (rework, Review section was empty): clone and checkout of c9d355f succeeded in /tmp/vuejs-skills-1Pnsud, but copying the four skill folders and LICENSE into `.claude/skills/` was denied by the auto-mode classifier ("Instruction Poisoning": untrusted skill Markdown written into the instruction folder). May the copy `cp -r <tmp>/skills/{vue-best-practices,vue-debug-guides,vue-testing-best-practices,create-adaptable-composable} .claude/skills/` and `cp <tmp>/LICENSE .claude/skills/LICENSE-vuejs-ai-skills` be allowed in `engineer.settings.json`?
