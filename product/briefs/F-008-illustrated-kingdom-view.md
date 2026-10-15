---
id: F-008
title: Session communication as an isometric kingdom
status: approved
priority: should
repos: [claude-dashboard]
---
## Problem
F-007 made the Session communication popup show live traffic and idle agents, but the user did not
get the look they wanted: a 2.5D (isometric) village like the Tribal Wars screenshot they supplied
(round wall with towers, castle, timber houses with tiled roofs, market square, dirt paths).
Today the popup does not read as a place, and the user cannot see at a glance which agents need
them.

## Outcome
The popup is a small isometric kingdom the user can watch. The user is the king in the castle;
the team and their projects are the town around it. Worked if the user confirms in the browser
that it looks like a village in the spirit of the reference, and that they can tell from the
scene alone who is working, who is idle, who is talking, and whether anyone has a question for
them. CPU levels are not a goal for this brief: no CPU measurement or CPU test is required (user
decision 2026-10-15).

## The kingdom (look and feel)
- **Castle = the user (the king).** It sits at the centre. Whenever a session needs the user
  (an open question or needs-attention item, see F-001), the castle shows it visibly, for
  example a flag or banner, and a mailman arrives at the castle.
- **Main court = team-hq sessions** (lead, engineers, reviewer, designer): the buildings nearest
  the castle, around the central square.
- **Districts = projects.** Each project is its own district of buildings; each building is a
  session of that project. Districts are visually separate (own area, paths in between).
- **Workers = subagents.** A working subagent is a person busy at or in its parent building and
  leaves when done. The session building is the boss.
- **Mailmen = messages.** A message between sessions is a mailman who runs along the paths from
  the sender's building to the receiver's. Messages to or from the user go to or from the castle.
- **Building state:** running and active (message in the last 30 s) looks busy (for example lit
  windows, smoke); running but quiet looks calm and shows "idle N min"; not running looks closed.
- **Setting:** wall with towers around the town, a central square with a well and market stalls,
  dirt paths between districts, grass and trees. It is drawn in the dashboard's own isometric
  style, not a copy of the screenshot.
- The reference image (the user's Tribal Wars screenshot) is the mood target only.

## User stories
- As the user, I can see the castle show when something needs me, so that I know where I am
  needed without opening the feed.
- As the user, I can see my team's sessions around the court and each project as a district, so
  that I know who works on what.
- As the user, I can see workers at a building, so that I know the agent is delegating.
- As the user, I can watch mailmen run between buildings, so that I see the team talk as it
  happens.

## Acceptance criteria
- [ ] The view is an isometric (2.5D) scene with a castle, buildings with roofs, paths, a central
      square and a boundary wall with towers.
- [ ] The castle is always present and is clearly distinct from the session buildings.
- [ ] When at least one session needs the user's attention, the castle shows a visible marker; with
      none, the marker is not shown.
- [ ] team-hq sessions stand in the main court around the square; sessions of each other project
      stand together in their own district.
- [ ] Each session appears as exactly one building, labelled with its name, using the same
      roster rule as F-007 (running, or messaged in the last hour).
- [ ] Building state is distinguishable without reading text: active, idle (with "idle N min"),
      closed ("stopped").
- [ ] Each currently working subagent appears as a worker at its parent's building; none are shown
      for finished ones.
- [ ] A new session-to-session message produces one mailman who travels along the paths from the
      sender's building to the receiver's building; no all-time connections are drawn.
- [ ] A message involving the user is shown as a mailman to or from the castle.
- [ ] Buildings keep stable positions while they are on screen, and a new district or building
      appears without moving existing ones.
- [ ] The message feed (last 40) is unchanged.
- [ ] On desktop the popup may use the full screen, and the scene fills it.
- [ ] On phone the scene is a vertical scroll: the castle at the top, then team-hq (main court),
      then each project district below it; labels stay readable.
- [ ] Nothing about the scene is computed while the popup is closed.

## Out of scope
- Photographic or painted art, or art copied from the screenshot or any game (the reference is
  mood only; no third-party assets).
- 3D / WebGL.
- Replay, time scrubbing, sending messages from the scene.
- Changing how messages and subagents are detected (same data as F-007).
- Day/night cycle and weather.

## Open questions
- Which building type each session gets (lead = tallest hall, engineers = workshops, and so on) or
  one house type with different signs: left to the lead and the user's browser check.
- How many sessions and districts should fit before the scene needs scrolling or zooming.
- What exactly counts as "needs the user": assumed the existing needs-attention (F-001) items and
  open questions; the lead should confirm against the data.

## Questions from lead
