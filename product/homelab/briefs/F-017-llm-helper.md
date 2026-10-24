---
id: F-017
title: Local LLM helper - summarize and extract over the tailnet
status: approved
builder: user + Claude on the box (not the team)
priority: must
repos: [homelab]
---
## Problem
Small LLM jobs in the user's scripts (summarizing logs or transcripts, pulling fields or labels out of text) either
cost Claude API money or aren't done at all. The homelab box (F-016) has a GTX 1080 that can run an ~8B model
locally, but nothing on it serves those jobs yet.

## Outcome
Any script on the user's tailnet devices can hand the homelab a summarize or extract job, through a standard API
or a short command, and gets the answer from a local model, or a clear error when the box can't help.
Success: the usage log shows the box doing real work, with calls per caller and job, so the user can see what it
replaces. Depends on F-016.

## User stories
- As the user, I can pipe text into a short command on Windows or on the box and get a summary back, so that shell scripts can use it in one line.
- As the user, I can ask for specific fields or a label from a text and get JSON back, so that a script can act on it.
- As the user, I can call the same jobs from code through a standard OpenAI-compatible API, so that any SDK works.
- As the user, I can see which callers used which jobs, how often and how long they took, so that I know what the box is worth.

## Acceptance criteria
- [ ] One command, `llm`, works the same on the Windows PC and on the box: `llm summarize < file` prints a summary; `llm extract` with a list of wanted fields (or allowed labels) prints JSON.
- [ ] `llm extract` output always parses as JSON with exactly the requested fields, or the command exits non-zero with an error; it never prints half-valid JSON.
- [ ] The same two jobs work through an OpenAI-compatible endpoint at the homelab's tailnet name; the docs show one working example per job from code.
- [ ] Any of the user's tailnet devices can call it without a key; from the home LAN outside Tailscale, the endpoint is refused.
- [ ] When the box is off or unreachable, `llm` exits non-zero within 10 s with a message that says the homelab is unreachable; when a job runs longer than its timeout (default 60 s, settable per call), it exits non-zero with a timeout message. No fallback to a paid API.
- [ ] The jobs run on an ~8B model that sits fully in GPU memory during use (no part on the CPU).
- [ ] Every call, through the CLI or the API, is recorded in a usage log: time, caller name (or `unknown`), job, model, duration, success or failure.
- [ ] One command on the box shows the usage log totals per caller and per job for a chosen period (e.g. last 7 days): count, average duration, failures.
- [ ] The docs in the repo cover: how to call each job (CLI and API), how to name the caller, the timeout and error behaviour, and how to switch the model.

## Out of scope
- Wiring the claude-dashboard or team-hq scripts to the helper: each gets its own brief or ticket in its own repo.
- Embeddings and search, translation, and a chat UI (e.g. Open WebUI).
- Falling back to the Claude API, or queueing jobs while the box is down.
- API keys or access from outside the tailnet.
- Using a local model as a coding agent backend.

## Open questions
- Which model exactly (within ~8B) is the lead's or builder's call at build time; pick the one that does best on a few sample logs.

## Questions from lead
