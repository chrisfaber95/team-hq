---
name: write-brief
description: Write or update a feature brief in <repo>/briefs/ from an interview, and on the user's approval mark it approved, add it to <repo>/ROADMAP.md and hand it to the lead. Use after discovery-interview, or to answer the lead's questions in a needs-design brief.
---

# Write a brief

## New brief

1. Id: the highest `F-NNN` in any `*/briefs/` (ids are global across repos), plus one. File: `<repo>/briefs/F-NNN-short-kebab-name.md`.
2. Fill in this template. Keep it to about a page: the lead turns it into tickets, so every
   acceptance criterion must be observable and testable.

```markdown
---
id: F-001
title: Short feature name
status: draft            # draft | approved | needs-design | parked | handed-off
priority: should         # must | should | could (the user decides)
repos: [claude-dashboard]
---
## Problem
Who has it, and what they do today instead.

## Outcome
What changes for the user; how we'll know it worked.

## User stories
- As a <user>, I can <action> so that <benefit>.

## Acceptance criteria
- [ ] Observable, testable behaviour

## Out of scope

## Open questions

## Questions from lead
```

3. Checks before showing it to the user:
   - every acceptance criterion can be tested without asking anyone;
   - no implementation design (files, types, endpoints); that's the lead's and engineers' call;
   - out of scope is filled in, even if only with one line;
   - `priority` is what the user chose, not your guess.

## On the user's decision

- **Approve:** set `status: approved`; add a line to `<repo>/ROADMAP.md` in priority order
  (`- [F-001](briefs/F-001-short-name.md) Short feature name (must)`); send `lead` one line:
  `F-001 approved: product/briefs/F-001-short-name.md`.
- **Revise:** change what the user asked for, show it again, ask again.
- **Park:** set `status: parked` and stop. It stays in `briefs/` for a later session.

## Answering the lead (needs-design)

Read the brief's `## Questions from lead`. Answer product questions with the user (a short
AskUserQuestion round if needed), write each answer directly under its question, update the
affected sections, set `status: approved` again, and send `lead` one line:
`F-001 answered: product/briefs/F-001-short-name.md`.
