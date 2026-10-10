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
pr:
---
## Goal
Engineers and reviewers working on the Vue migration (decision 0007) have the community Vue 3 skills in the
repo, so they write `.vue` code against documented Vue practice instead of memory.

## Acceptance
- [ ] `.claude/skills/` contains `vue-best-practices`, `vue-debug-guides`, `vue-testing-best-practices` and
      `create-adaptable-composable`, copied unchanged (all files, including `references/` and `reference/`)
      from https://github.com/vuejs-ai/skills at commit `c9d355ff23f654309dd02006be671859df0a134c`; no
      other skills from that repo
- [ ] `.claude/skills/VENDORED.md` names the source repo, the commit, the four skill folders and how to
      update them, and the repo's MIT `LICENSE` is copied next to it as `LICENSE-vuejs-ai-skills`
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
- 2026-10-10 blocked (lead): run 3 cloned fine; the copy into `.claude/skills/` was refused (see ## Blocked). Waiting for the user (NEEDS-YOU).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)

## Blocked
Run 4 (rework, Review section was empty): clone and checkout of c9d355f succeeded in /tmp/vuejs-skills-1Pnsud, but copying the four skill folders and LICENSE into `.claude/skills/` was denied by the auto-mode classifier ("Instruction Poisoning": untrusted skill Markdown written into the instruction folder). May the copy `cp -r <tmp>/skills/{vue-best-practices,vue-debug-guides,vue-testing-best-practices,create-adaptable-composable} .claude/skills/` and `cp <tmp>/LICENSE .claude/skills/LICENSE-vuejs-ai-skills` be allowed in `engineer.settings.json`?
