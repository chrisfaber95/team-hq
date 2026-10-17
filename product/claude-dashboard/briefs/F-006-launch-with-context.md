---
id: F-006
title: Launch work with context
status: handed-off       # draft | approved | needs-design | parked | handed-off
priority: should         # must | should | could (the user decides)
repos: [claude-dashboard]
---
## Problem
The owner still opens a terminal to begin a piece of work, because starting from the dashboard means
typing one bare prompt into a box with no way to say what background the session should have. Today
the dashboard can start a background session from a project, a prompt and a permission mode, and can
follow up on and stop it. Setting up the work (which project, what the goal is, what the session
should know first) happens outside the dashboard.

## Outcome
The owner starts new work entirely from the dashboard: choose the project, state the goal, add any
background the session should know, and watch it begin. Worked if, over a normal week, every session
the owner starts is launched from the dashboard and none from a terminal.

## User stories
- As the owner, I can pick a project and describe the goal in one place so that the session starts on
  the right work without a terminal.
- As the owner, I can add background notes for the session, kept separate from the goal, so that it
  starts with the context I would otherwise type out by hand.
- As the owner, I can see the session I just launched appear and start running so that I know it
  worked and can follow it.
- As the owner, I can see which sessions were launched from the dashboard and with what goal, so that
  I know what I started.

## Acceptance criteria
- [ ] A launch form lets the owner choose a project, enter a goal, and choose a permission mode from
      the modes the dashboard already offers.
- [ ] The owner can enter optional background notes; the started session receives them together with
      the goal.
- [ ] Launching with an empty goal, or with no project chosen, is refused with a clear message and
      starts nothing.
- [ ] After launching, the new session appears in the dashboard's session list within a few seconds
      and shows as running.
- [ ] If the session cannot be started, the owner sees the reason in the dashboard and no session is
      left half-started.
- [ ] The bypass-permissions mode is not offered.
- [ ] Launching requires the same access token as the existing controls; without it the launch is
      refused.
- [ ] Each launch is recorded with time, project and goal and can be viewed in the dashboard.

## Out of scope
- Saved or reusable recipes, one-click presets.
- Chaining (one session starting another when it finishes).
- Scheduled or timed launches.
- Choosing the model or effort level.
- Token or cost budgets per launch.
- Access from outside the LAN.
- The dashboard deciding by itself what to launch.

## Open questions
- What should "context" include beyond free-text notes (for example, attaching a past session's
  summary or a file)? Kept to free-text notes for now.
- Recipes, chaining and scheduling were all wanted by the owner; they are later briefs, in that
  order to be decided.

## Questions from lead
- 2026-10-09 (lead) Most of the launch path exists ("Run a task" form, `start` audit entry). Technical choices: the notes travel inside the prompt in a marked section after the goal (no system-prompt flag, `claude-cli.ts` unchanged); the launch history comes from the server audit log (`GET /api/launches`), so every device sees it, replacing the per-browser "Recent tasks". Tickets: T-032 (server), T-033 (form, after the F-004 popups).
