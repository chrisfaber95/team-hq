---
id: F-024
title: Homelab dashboard - one page for jobs, live activity and what the box is worth
status: approved           # draft | approved | needs-design | parked | handed-off
builder: user + Claude on the box (not the team)
priority: should
repos: [homelab]
---
## Problem
After F-020, F-021 and F-022 the box has three separate tailnet views: the read-only health overview, the task inbox
and the job list. None of them shows what is happening right now, what's coming up, or whether the box is paying
for itself. The dashboards people show off for Hermes Agent are part of the appeal: open one page and see the
assistant at work.

## Outcome
One homelab page on the box's tailnet name, good on the phone and on a desktop, brings together the F-020 overview,
the F-021 inbox and the F-022 jobs. It adds three views: a jobs timeline, live activity, and usage and value. It
should be pleasant to look at, not a plain status table. Success: the user opens this page in place of SSH or the
separate views, and can tell at a glance whether all is well, what's running and what the box saved this week.
Depends on F-020, F-021 and F-022. A view in the claude-dashboard comes later, as a separate brief in that repo.

## User stories
- As the user, I can see every job's past runs and its upcoming runs on one timeline, and start one now, so that I know what the box does and when.
- As the user, I can watch what Claude and the local model are doing right now, with each run's log as it happens, so that the box doesn't feel like a black box.
- As the user, I can see how much work went to the local model and how much to Claude, how much of my plan the jobs used, and the time the jobs saved, so that I know what the box is worth.
- As the user, I open one page in place of three, so that the phone shows everything in one place.

## Acceptance criteria
- [ ] **One page.** The page at the homelab's tailnet name holds the F-020 overview, the F-021 inbox (task form, queue, history, memory list from F-023) and the F-022 jobs. The three separate views are gone or redirect to it. The F-020 health part stays read-only.
- [ ] Reachable from the user's tailnet devices only; from the home LAN outside Tailscale and from the internet it is refused. It shows no secrets.
- [ ] It works on the user's phone (no sideways scrolling) and on a desktop browser.
- [ ] **Jobs timeline.** It shows the last 7 days of job runs and the next 24 hours of planned runs per job. Each past run shows its result (ok, failed, PR, held by cap), and each run links to its history entry.
- [ ] A "run now" button starts a job outside its schedule, through the same queue, rules and Claude cap as a scheduled run.
- [ ] **Live activity.** The page shows every inbox task and job running right now, which model it uses, and how long it has run. Opening one shows its log as it happens, at most 5 seconds behind. A finished run leaves the live view within 10 seconds.
- [ ] Cancelling a running task or job from the live view works like the F-021 cancel.
- [ ] **Usage and value.** Per day and per week, the page shows: local-model calls (from the F-017 log), Claude runs from jobs against the F-022 daily cap, and Claude runs from inbox tasks.
- [ ] It shows the estimated time saved per job kind and in total for the week, from a per-job "minutes this saves" value the user sets on the job (no value means nothing is counted).
- [ ] **Look.** The page has a clear visual design of its own (not a bare table), in light and dark, approved by the user (`user_check: true`).

## Out of scope
- The claude-dashboard view of the homelab (a later brief in the claude-dashboard repo).
- Browsing and editing memory beyond the F-023 list, and a skills browser beyond the F-022 list.
- New health checks, graphs of health over time, or hardware trends (F-020 leaves these out too).
- Showing Claude usage of the user's own sessions on other machines.
- Anything reachable from the internet.

## Open questions
- "Claude usage against your plan": the box may not be able to read the plan's real usage. The page counts the box's own Claude runs against the F-022 cap. Showing real plan usage is the builder's call if it's available.
- Visual direction: open. It could borrow from the claude-dashboard's isometric look (see the dashboard visual direction draft) or have its own. Settle it with the user when the build starts.
