---
id: F-001
title: Needs-attention alerts
status: handed-off
priority: must
repos: [claude-dashboard]
---
## Problem
The user runs several Claude sessions and today watches the terminals to notice when one is
waiting for input, when usage is nearing a limit, or when work has finished. The dashboard shows
state, but nothing tells the user that something needs them.

## Outcome
The user can leave the terminals alone and trust the dashboard to show what needs them. It worked
if the user stops watching terminals and still answers waiting sessions and avoids surprise limits.

## User stories
- As the user, I see a "Needs attention" list with a count badge so that I know at a glance
  whether anything needs me.
- As the user, I get a toast when a new alert arrives so that I notice it while looking elsewhere
  in the dashboard.
- As the user, I can dismiss an alert, and it clears itself once resolved, so that the list stays
  accurate.
- As the user, I set the usage percentage at which I'm warned so that the warning fits how I work.

## Acceptance criteria
- [ ] When a live session changes to the waiting ("Needs you") state, an alert naming that session appears in the list and as a toast.
- [ ] The alert clears by itself when that session leaves the waiting state.
- [ ] When any usage window (5-hour or 7-day) reaches the user's set percentage, one alert appears showing the window, percentage and reset time.
- [ ] The usage alert clears by itself when utilization drops below the threshold (e.g. after a reset).
- [ ] The threshold is a setting in the dashboard, persists after a reload, and changing it applies to the next check.
- [ ] When a team-hq ticket moves into the review column, an alert naming the ticket appears; it clears when the ticket leaves review or the user dismisses it.
- [ ] The header shows a badge with the number of open alerts; it is hidden at zero.
- [ ] The user can dismiss any alert; a dismissed alert does not return unless its condition clears and happens again.
- [ ] The same condition never creates duplicate alerts, including across SSE refreshes and page reloads.
- [ ] Alerts are shown only to clients that already have access to the dashboard.

## Out of scope
- Taking actions from an alert (approve, restart, kill a session): alert only.
- Browser/desktop (OS-level) notifications: backlog.
- Delivery outside the LAN (push to phone etc.): backlog.
- PR-opened alerts: needs a new data source, so only "ticket moved to review" counts as work finished in v1.
- Spoken briefings, daily summaries, user-defined alert rules.

## Open questions
- Does the session "waiting" state actually fire on a permission prompt? Needs checking against a real session.
- Is a PR-opened alert wanted soon enough to justify a new GitHub data source?

## Questions from lead
