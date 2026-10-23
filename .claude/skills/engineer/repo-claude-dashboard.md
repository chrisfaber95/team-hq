# Engineer notes: claude-dashboard

- Style: the repo's `docs/code-style.md` (team-hq decision 0006 until it exists): files in their feature folder,
  full-word names, small modules. For `src/client/` changes, also read the repo's UI conventions.
- For `.vue` files or other Vue work, load the repo's `vue-best-practices` skill yourself (component tests:
  `vue-testing-best-practices`; a Vue runtime warning: `vue-debug-guides`). It is a skill, not a subagent:
  it loads into your own context. If it is not in your skill list (headless runs may not load the repo's skills),
  Read `.claude/skills/<name>/SKILL.md` in the worktree instead. Where it disagrees with decision 0007 or the
  repo docs, those win.
