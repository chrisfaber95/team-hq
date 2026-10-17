---
id: F-003
title: Ask-the-dashboard chat
status: handed-off
priority: must
repos: [claude-dashboard]
---
## Problem
Chris checks terminals by hand to learn what his Claude sessions are doing, what needs him and how
much allowance is left. This is true at the PC and from a phone on the LAN. It costs attention,
and it is the opposite of the Jarvis/KITT "AI manager" goal in VISION.md.

## Outcome
A typed chat panel in the dashboard answers "what's going on?" in one question and performs a few
safe actions. Success: Chris checks terminals noticeably less often to find out session status.

## User stories
- As Chris, I can type a question like "what's running?" or "what needs me?" so that I get the
  answer without opening terminals.
- As Chris, I can ask about token usage and limits so that I know how much allowance is left.
- As Chris, I can tell the chat to send a message to a session so that I can steer it from my
  phone.
- As Chris, I can acknowledge a needs-attention alert from the chat so that I clear it without
  hunting for it.
- As Chris, I can ask to jump to a session so that its transcript opens in the dashboard.
- As Chris, I can ask for a summary of a session so that I see what it did without reading the
  whole transcript.

## Acceptance criteria
- [ ] The chat panel works in a desktop browser and on a phone-sized screen on the LAN.
- [ ] Asking what is running, what needs attention, and token usage/limits returns an answer that
      matches what the dashboard shows at that moment.
- [ ] Answers appear within about 10 seconds of sending the question.
- [ ] "Send a message to session X: ..." shows the session and the exact text first; nothing is
      sent until Chris confirms.
- [ ] A message to a session that cannot receive messages (e.g. a terminal session) gives a clear
      explanation instead of failing silently.
- [ ] "Acknowledge alert ..." clears that alert in the dashboard.
- [ ] "Open session X" opens that session's transcript view.
- [ ] A question the chat does not understand gets a reply listing what it can do.
- [ ] The chat is only usable by a signed-in device, under the same rules as the rest of the
      dashboard (F-002).
- [ ] The chat cannot start or stop sessions or run shell commands.
- [ ] Answers use tokens only, never cost figures.

## Out of scope
- Voice input or output, wake word, custom voice or personality.
- Starting or stopping sessions, and running shell commands.
- Access from outside the LAN.

## Open questions
- Chris chose answers from dashboard data with no model (fixed question types). A session
  summary may need a model; either leave it out of v1 or use a basic non-model recap. Needs a
  decision.
- Should "send message" be allowed from every signed-in device, or only some? Today there is no
  per-device permission for it.
- Voice is the later direction; this brief should leave room for it.

## Questions from lead
- Answered by the user in the lead session, 2026-10-09 (decision 0004): summaries default to a no-model recap, with a
  dashboard setting to switch to one cheap-model call through the CLI; every signed-in device may send messages.
  Voice is left room for: the chat parses text to intents in a module a voice front-end can reuse.
