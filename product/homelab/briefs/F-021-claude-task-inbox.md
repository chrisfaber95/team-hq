---
id: F-021
title: Claude task inbox - send Claude on the box a task from the phone
status: approved         # draft | approved | needs-design | parked | handed-off
builder: user + Claude on the box (not the team)
priority: should
repos: [homelab]
---
## Problem
Small jobs for the user's own repos and the box itself (a broken dashboard button, "make service Q start on boot",
"why did last night's deploy fail?") wait until the user is at a PC with an SSH session and a Claude session open.
Claude on the box (F-016) and its dev clones (F-018) are idle the rest of the time, and from a phone there is no way
to hand them work.

## Outcome
From the phone, over Tailscale, the user types a task on a page on the box and picks a repo. Claude on the box
picks it up, asks one question back if the task is unclear, and ends with an open PR (or, for a look-up, an answer
on the page) plus a push notification. The user reviews and merges on GitHub, or sends it back with a PR comment.
Claude never merges. Success: in a normal week, small fixes, box-admin changes and look-ups go from typed on the
phone to PR or answer without the user opening SSH or sitting at a PC. Depends on F-016 and F-018; uses F-019
(machine changes and the push channel) and F-020 (the tailnet page next to the overview).

## User stories
- As the user, I can type a task on a tailnet page on my phone and pick one of my repos, so that work starts while I'm away.
- As the user, I get one question back on the page when the task is unclear, so that Claude doesn't guess.
- As the user, I get a push with the PR link when a fix is ready, and I review and merge it on GitHub, so that nothing lands without me.
- As the user, I can comment on the PR to send it back, so that rework doesn't need a separate tool.
- As the user, I can ask a question about a repo or the box and read the answer on the page, so that a look-up doesn't need a PR.
- As the user, I can ask for a box-admin change and have it go through the same rules as F-019, so that the inbox never gives Claude more rights.
- As the user, I can see the queue and every past task, and cancel one, so that I stay in control of what runs.

## Acceptance criteria
- [ ] **Page.** The task page answers on the box's tailnet name from any of the user's tailnet devices, including the phone; from the home LAN outside Tailscale and from the internet it is refused.
- [ ] A task is a repo plus free text. The repo choice lists exactly the F-018 sync-list repos plus the homelab repo; no other repo can be chosen or reached by a task.
- [ ] **Queue.** At most two tasks run at once, and never two on the same repo; further tasks wait in a queue shown on the page, in order, and start by themselves when a slot frees up.
- [ ] Every task has a turn/time cap. A task that hits it stops, keeps its branch, shows "stopped at cap" on the page and sends a push.
- [ ] The user can cancel a queued or running task from the page; a cancelled task makes no further commits or comments.
- [ ] **Ask back.** When Claude judges a task unclear, it posts one question on that task's page entry, sends a push, and does nothing else until the user answers there; the answer continues the same task.
- [ ] **Result.** A code task ends with an open PR in the chosen repo (never on `main` directly) and a push with the PR link; the page shows the PR link and a short summary of the change.
- [ ] Claude can't merge a PR or push to `main` of any repo through the inbox; both fail.
- [ ] A look-up task ("why did ...?") ends with an answer on the page and a push, and makes no commit, branch or PR.
- [ ] A task's work never changes the user's own dev clones or the deploy clones on the box.
- [ ] **Rework.** A review comment by the user on an inbox PR puts the task back in the queue; Claude pushes its changes to the same PR and sends a push when done. Comments from any other GitHub account are ignored.
- [ ] **Box admin.** A task in the homelab repo can only use the F-019 paths: allowlisted actions run at once, everything else becomes an F-019 approve-by-PR change. A task asking for something F-019 forbids ends with that reason on the page, not a workaround.
- [ ] **History.** The page lists every task with repo, text, status (queued, running, waiting for you, PR open, answered, stopped at cap, cancelled, failed), start and end time, and its PR link if any; the list survives a reboot.
- [ ] Nothing about the inbox needs an inbound port from the internet; push and GitHub traffic are outbound only.

## Out of scope
- team-hq: the inbox has nothing to do with the lead, the board or the engineers on Windows.
- Repos outside the F-018 sync list (and so MyGameProject); cloning repos on demand.
- Claude merging anything, auto-merge for small changes, and pushing to `main`.
- Sending tasks through GitHub issues, ntfy replies, chat apps, voice or email.
- Recurring or scheduled tasks.
- Rights beyond F-019 for box-admin tasks; driver, kernel, disk and reboot changes stay manual.
- Showing the inbox in the claude-dashboard (would be a separate dashboard brief).
- Anything reachable from the internet.

## Open questions
- Push access: the inbox needs Claude on the box to push branches and open PRs (F-018 left this open). It needs a GitHub credential that can do that but can't merge or push to `main`, e.g. branch protection plus a fine-grained token. Builder's call at build time, within the "can't merge or push to main" criterion.
- The cap values (turns/time per task, and whether a rework round gets a fresh cap) are defaults for the builder; change them at review if they feel wrong.
- When is a task "unclear" enough to ask? Builder's call; at most one question per round so the user isn't pinged repeatedly.
- Who builds it?
  Answer (user, 2026-10-24): the user and Claude on the box. **Not for the team: the lead does not plan tickets for this brief.**

## Questions from lead
