---
id: F-022
title: Scheduled jobs and reusable skills for Claude and the local model
status: approved           # draft | approved | needs-design | parked | handed-off
builder: user + Claude on the box (not the team)
priority: should
repos: [homelab]
---
## Problem
Recurring work still waits for the user to think of it: checking what failed overnight, dependency updates and stale
branches in their repos, reading feeds and GitHub activity, and running their own scripts and reading the output.
F-021 lets the user send Claude on the box a task, but only one at a time and only when they type it. Every task also
starts from zero: a way of working that went well once isn't kept for next time. Hermes Agent (research note
`research/hermes-agent.md`) shows the idea: scheduled jobs plus skills the agent builds up. Its local-model setup
doesn't fit the GTX 1080, so this brief builds the same idea on Claude on the box and the F-017 local model.

## Outcome
The user describes a recurring job once, in plain words on the F-021 page or as a job file in the homelab repo,
and it runs on its schedule. Small text jobs run on the local model and cost nothing. Jobs that need tools or code
run on Claude, under the same rules as an inbox task. The phone only buzzes when something needs the user. After a
task or job goes well, Claude offers to save how it did it as a skill. The user approves by merging, and later tasks
and jobs reuse it. Success: after a month, the user has at least five jobs running across the four kinds below that
they would otherwise do by hand, and the usage log shows most job runs on the local model. Depends on F-017, F-020
and F-021.

## User stories
- As the user, I can type "every weekday at 7:00, tell me what failed overnight" on the page, check the job Claude makes from it, and confirm, so that I set up a job in one step.
- As the user, I can write or change a job as a file in the homelab repo, so that jobs are versioned and rebuildable.
- As the user, I can have four kinds of job: box reports (from the F-020 state), repo chores (ending in a PR), personal digests, and runs of my own scripts with the output summarised.
- As the user, I only get a push when a job fails, opens a PR, asks a question or hits the Claude cap, so that my phone stays quiet.
- As the user, I get an offer from Claude to save a successful way of working as a skill, and I approve it by merging a PR, so that nothing is learned without me.
- As the user, I can keep Claude jobs within a daily cap, so that my own sessions keep their share of the plan.

## Acceptance criteria
- [ ] **Jobs are files.** Every job exists as a readable file in the homelab repo. It holds its schedule, its instruction, which model it uses (local or Claude), the repo it works on (if any) and the skills it uses. A rebuild from the repo (F-016) brings back every job.
- [ ] **From the page.** The user types a job in plain words on the F-021 page. Claude shows the job it made (schedule in words and as the next three run times, model, repo, skills), and the user confirms or cancels. A confirmed job is saved as its file and runs from its next due time without a separate PR. Editing, pausing and deleting a job from the page works the same way.
- [ ] Claude suggests the model for each new job: local for jobs that only summarise or extract from text the job gathers, Claude for anything that needs tools, code or a repo. The user can change it before confirming.
- [ ] **Running.** A job runs within 2 minutes of its due time. If the box was off at that time, a missed job runs once after the box is back, not once for every missed slot.
- [ ] A local job makes no Claude call. Its calls appear in the F-017 usage log with the job's name as the caller.
- [ ] A Claude job runs through the F-021 queue and rules: it shares the two running slots, never runs two on the same repo, has a turn/time cap, ends code changes in a PR (never on `main`, never merged), and box-admin changes take only the F-019 paths. A job can't do anything an inbox task can't.
- [ ] A script job runs only scripts from the homelab repo or an F-018 sync-list repo, as Claude's account on the box (no root).
- [ ] **Claude cap.** Claude runs started by jobs are capped per day (a default the user can change). Above the cap, further Claude jobs wait until the next day and the user gets one push for that day. Local jobs and the user's own inbox tasks are not affected.
- [ ] **Push.** A run pushes only when it fails, opens or updates a PR, asks the user a question, or is held by the cap. Every other result is shown on the page in the job's history (time, result, link to a PR or answer).
- [ ] **Skills.** When an inbox task or a Claude job has succeeded, Claude may offer to save its way of working as a skill. A skill becomes a PR in the homelab repo with a one-line summary and a push. It is used only after the user merges it, and Claude can't merge it.
- [ ] Skills are readable files in the homelab repo. A job names the skills it uses, and an inbox task can use any merged skill. The page lists every skill with its summary and the jobs that use it.
- [ ] Claude never changes a merged skill in place. An improvement is a new PR, like a new skill.
- [ ] The homelab docs cover: writing a job file, the four kinds of job with one example each, how the model is chosen, the cap, when a job pushes, and how skills are proposed and approved.

## Out of scope
- Memory across tasks (F-023) and the dashboard (F-024). This brief only adds the job list and history to the F-021 page.
- Digests from email, calendars, chat apps or any account that needs a new login or secret on the box.
- Claude saving or changing skills without a merged PR (the Hermes-style self-written skills).
- Sending jobs through chat apps (Telegram and the like); the F-021 page stays the only way in.
- Running the real Hermes Agent; a paid API model as a third brain.
- Jobs on repos outside the F-018 sync list, and on the Windows PC.
- Anything reachable from the internet.

## Open questions
- F-021 lists "recurring or scheduled tasks" as out of scope. This brief adds them on top of F-021, which doesn't change.
- Confirming a job on the page saves it to the homelab repo without a PR, but Claude can't push to `main` (F-019). How the page saves the user's confirmed change is the builder's call, as long as only the user's confirmation can activate a job.
- Digests: does a morning digest count as "something that matters" and push? Answer (user, 2026-10-24): no, it shows on the page only.
- First digest sources: public feeds and web pages plus GitHub (via the existing `gh` login). Confirmed by the user, 2026-10-24; email stays out.
- Default daily Claude cap of 10 runs (user OK, 2026-10-24) and the 2-minute start window are defaults for the builder; change them at review if they feel wrong.
- Claude Code's own skills feature may be a good fit for the skill files. Builder's call.
