---
id: F-023
title: Assistant memory - Claude on the box remembers you, the box and past tasks
status: approved           # draft | approved | needs-design | parked | handed-off
builder: user + Claude on the box (not the team)
priority: should
repos: [homelab]
---
## Problem
Every F-021 inbox task and F-022 job starts from zero. The user has to repeat preferences ("small PRs", "answer in
short lines"). Claude rediscovers what runs where on the box and how each project builds and deploys. A question like
"why did the deploy fail again?" can't use the answer from last week. The user corrects the same thing more than once.

## Outcome
Claude on the box keeps a memory with three kinds of entry: how the user likes things, facts about the box and the
repos, and a searchable history of past tasks and answers. Every inbox task and Claude job starts with it. The memory
is readable files in the homelab repo, and the user can browse, edit and delete entries on the page, so nothing is
remembered behind their back. Success: corrections stop repeating (the user doesn't make the same PR comment twice
in a month), and look-ups like "when did this last fail?" are answered from history with a link to the earlier task.
Depends on F-021; used by F-022.

## User stories
- As the user, I correct Claude once (in a PR comment or a task answer) and it remembers, so that I don't repeat myself.
- As the user, I can rely on Claude knowing what runs on the box and how my repos build and deploy, so that tasks start faster and guess less.
- As the user, I can ask about something that happened before and get an answer that points to the earlier task, so that history is useful.
- As the user, I can see, edit and delete every memory entry on the page, so that I stay in control of what it knows.

## Acceptance criteria
- [ ] **Three kinds.** Memory holds three kinds of entry: preferences (how the user likes things), facts (about the box and each repo), and task history (one entry per finished inbox task or Claude job: what was asked, the result, the PR or answer link).
- [ ] Every entry shows its kind, the repo it's about (or "box" or "general"), when it was added or changed, and its source (the task, job or PR comment it came from, or "added by you").
- [ ] **Learning.** When the user corrects Claude in a PR comment on an inbox or job PR, or in a task answer, Claude saves a preference entry linked to that comment. The test: the same correction in a later task is no longer needed.
- [ ] When a task finds out something lasting about the box or a repo (a new service, a changed deploy step), Claude saves or updates a fact entry instead of adding a duplicate.
- [ ] **Using.** Every inbox task and Claude job starts with the preferences, the facts for its repo (or the box), and access to search the task history. Local-model jobs don't use memory.
- [ ] A look-up task about something past ("when did X last fail?") that has a matching history entry answers with that entry's date and a link to the earlier task.
- [ ] **Files.** Memory lives as readable files in the homelab repo. Every change, by Claude or the user, is a commit that says who made it and why. A rebuild from the repo (F-016) brings the memory back complete.
- [ ] **Page.** The F-021 page lists the memory by kind and repo, with a search box. The user can edit or delete any entry and add one by hand. A deleted entry is no longer used by the next task.
- [ ] Memory never holds credentials. Test: a task that sees a fake token in a log saves no entry containing it.
- [ ] The homelab docs cover: the three kinds, where memory lives, how to edit it on the page or in the repo, and how to reset it.

## Out of scope
- Memory for the local model or F-017 helper calls.
- Memory shared with Claude sessions on the Windows PC, team-hq or the claude-dashboard.
- Remembering anything about people other than the user, or personal data beyond preferences on how to work.
- Automatic forgetting or expiry of entries (the user deletes by hand).
- Anything reachable from the internet.

## Open questions
- Memory commits go to the homelab repo, but Claude can't push to `main` (F-019), and a PR per memory entry would be noisy. Builder's call (for example a separate memory repo or a branch Claude may push to), as long as every change is a commit and the user can see it.
- Memory grows. How much each task loads, and how old history entries are summarised, is the builder's call. Facts and preferences are always loaded in full.
- Claude Code has memory features of its own (CLAUDE.md files, auto memory) that may cover part of this. Builder's call.
