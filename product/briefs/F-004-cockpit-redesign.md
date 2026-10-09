---
id: F-004
title: Cockpit redesign (in-place updates and new layout)
status: handed-off
priority: must
repos: [claude-dashboard]
---
## Problem
Chris uses the dashboard on a desktop second screen, on a phone over the LAN, and wants it on a
spare tablet. Today it looks like a normal website, with equal weight on every block. Every live
update rebuilds whole sections, so the page feels heavy, and on a phone the scroll position jumps
while he reads. He cannot read overall status at a glance, which is the opposite of the
Jarvis/KITT "AI manager" goal in VISION.md.

## Outcome
The dashboard feels like a cockpit: a status wall that updates in place and never jumps. Success:
Chris can read what needs him and how much allowance is left from across the room in about 2
seconds, and an always-open screen is noticeably lighter on resources than today.

## User stories
- As Chris, I see needs-you alerts and token usage/limits at the top at all times so that I know
  what matters without scrolling.
- As Chris, I see live values change in place so that nothing flickers, reloads or loses my place.
- As Chris on a phone, I can scroll, keep a drawer open and select text while updates arrive so
  that reading is never interrupted.
- As Chris on a desktop monitor, I get a layout that uses the full screen width so that the
  status wall fills my second screen instead of sitting in a narrow column.
- As Chris, I open less important tiles from a button as a popup so that the main view stays
  uncluttered but the data is one click away.
- As Chris, I get one layout that works on a desktop monitor, a phone and a wall tablet so that I
  can use whichever screen is nearest.
- As Chris, I keep the look of the current skins so that the redesign changes layout, not the
  visual identity I already chose.

## Acceptance criteria
- [ ] Needs-you alerts and token usage/limits are visible without scrolling on a desktop, a
      phone-sized and a tablet-sized screen.
- [ ] On a desktop screen the layout uses the full browser width (no narrow centred column) at
      common sizes from 1280 px to ultrawide.
- [ ] Less important tiles are not shown in the main view; each has a button that opens its data
      in a popup, and the popup closes again with a click outside it, a close button or Esc.
- [ ] An open popup keeps updating live and does not jump or close when updates arrive.
- [ ] Which tiles are primary (always visible) and which sit behind a button is fixed in this
      version; the user cannot rearrange them.
- [ ] A live update changes only the values that changed; a section that did not change is not
      redrawn.
- [ ] On a phone-sized screen, scroll position is unchanged after live updates arrive.
- [ ] An open drawer, a text selection and keyboard focus survive live updates.
- [ ] No visible flicker on live updates in a normal browser.
- [ ] Updates arrive as they happen (push), with no manual refresh needed.
- [ ] CPU use of an always-open dashboard tab is measured before and after, and is lower after.
- [ ] The layout is clearly different from today's page-style layout: a dense, status-first
      cockpit with a stronger visual hierarchy.
- [ ] Every skin that exists today still works, with its visual design unchanged.
- [ ] Every existing dashboard function (limits, projects, live sessions, session messages, token
      usage, transcript drawer, alerts, chat, team board) is still reachable and works.
- [ ] Light and dark mode still follow the OS.

## Out of scope
- Login, pairing, devices, audit and settings pages (unchanged for now).
- Voice control.
- User-arrangeable or hideable panels (fixed layout for now).
- Wall mode (status-only display with big type); planned for later.
- Server or API changes; the data feed stays as it is.
- Redesigning the skins themselves (their look stays; only the layout changes).
- Rebuilding on a new UI framework.

## Open questions
- Which tiles count as "less important" and go behind a button? Proposed: primary = needs-you
  alerts, token usage/limits, live sessions; behind a button = projects, session messages, team
  board. The lead may propose the final split; the user confirms.
- The transcript drawer is polled rather than pushed; it was not named as a pain, so it is left
  as is unless the lead finds it is part of the problem.

## Questions from lead
- 2026-10-09 (lead) Tile split, confirmed by the user: main view = needs-you alerts, limits plus today's total tokens, live sessions (and the Co-pilot/Root core strip). Behind buttons = projects, session messages, team board, 14-day token usage, chat, run a task, devices, activity (devices/activity content unchanged, only moved).
- 2026-10-09 (lead) Transcript drawer polling is left as is; T-026 only makes sure an open drawer survives live updates.
- 2026-10-09 (lead) Push already exists (SSE, full state every 2 s); the server stays unchanged. The client skips identical pushes and patches only what changed.
