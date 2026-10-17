---
id: F-007
title: Live session communication (the city)
status: handed-off
priority: must
repos: [claude-dashboard]
---
## Problem
The "Session communication" popup draws every session that ever sent a message on a circle, with
one cumulative edge per sender/receiver pair. It shows all connections of all time, and sessions
that are not running are only dimmed to 50 %. The user finds the function misunderstood: it should
show agents sending messages to each other as it happens, and agents being idle when they are not.
Today the user has to read the feed on the right to know what is going on now.

## Outcome
Opening the popup shows a small city that answers "who is working, who is talking, who is idle?"
at a glance. The user uses it to watch the team work. Worked if the user confirms in the browser
that live traffic and idle agents are obvious without reading the feed, and the popup does not
undo the F-004 CPU gains.

## The city (look and feel)
- Each agent session is a **shop** in the city. The shop is the boss.
- Its **subagents are workers inside the shop**; they are visible while working and leave when
  done.
- A **message between two sessions is a postman** who runs from the sender's shop to the
  receiver's shop, once per message seen.
- A shop that is running but quiet looks calm/idle; a shop that is not running looks closed.

## User stories
- As the user, I can see which shops are open (sessions running), so that I know who is on the
  team right now.
- As the user, I can see a postman run between two shops when a message is sent, so that I can
  watch the team coordinate.
- As the user, I can see the workers (subagents) inside a shop, so that I know the agent is busy
  delegating.
- As the user, I can see how long a quiet shop has been idle, so that I notice one that has gone
  silent.
- As the user, I can still read the last 40 messages in the feed, so that I have the history.

## Acceptance criteria
- [ ] The city shows running sessions plus sessions that sent or received a message in the last
      hour; each appears once as a shop.
- [ ] A running shop with a message in the last 30 seconds looks active; a running shop without
      one looks idle and shows its idle time (e.g. "idle 12 min").
- [ ] A session that is not running but messaged in the last hour looks closed and is labelled
      "stopped"; a stopped session with no message in the last hour is not shown.
- [ ] Each subagent that is currently working appears as a worker inside its parent's shop;
      when it is done it is no longer shown as working (it may linger briefly or leave).
- [ ] For each session-to-session message newly seen, one postman travels from the sender's shop
      to the receiver's shop; direction is clear from the movement. After the trip nothing
      remains on the street: no cumulative all-time connections are drawn.
- [ ] A postman's trip or trail stays visible for about 30 seconds after the message is first
      seen.
- [ ] Subagent messages are shown inside the shop (a postman between the boss and the worker),
      not between shops.
- [ ] Shops keep a stable position while they are on screen (no jumping when others come or go).
- [ ] The feed keeps showing the last 40 messages, unchanged in content.
- [ ] With the popup closed, nothing about it is computed (as today); with it open, the added CPU
      stays at F-004 levels, measured the same way as F-004. Animation only runs while something
      is moving.
- [ ] Layout and animation work at phone width.

## Out of scope
- Real-time push events: messages are still found by scanning transcripts on each state push
  (about every 2 s), so "live" means "recently seen".
- Replay or scrubbing back in time.
- Sending messages from the popup.
- Exact running status of subagents from Claude itself; "working" stays inferred from recent
  transcript activity (silent for over 5 minutes counts as done).
- Subagent history older than what the dashboard already keeps (15 minutes after finishing).

## Open questions
- Is a subagent's own result hand-back (not a message between sessions) also a postman inside
  the shop? Assumed yes, via the subagent messages already collected.
- Does a shop with many workers (up to 24 are tracked per session) need a cap or "+N more"?
  Left to the lead and engineers.
- Shops closed for over an hour: gone, or a faded "closed" row? Brief says gone.
- The 30 s window and 2 s push interval make short trips uneven; the lead may flag back here.

## Questions from lead
