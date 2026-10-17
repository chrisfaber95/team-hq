---
name: discovery-interview
description: Interview the user about one new feature in short multiple-choice rounds, then hand over to write-brief. Use when the user wants to design, explore or add a feature.
---

# Discovery interview

Goal: enough clarity for a brief in two or three short rounds. Open-ended chat about ideas is
where design-session tokens go, so keep every round structured.

1. **Pick the repo, then start from its files.** Ask which repo the feature is for if the user has not said it
   (`claude-dashboard` or `my-game-project`). Then read that repo's `<repo>/VISION.md`, `<repo>/ROADMAP.md` and the
   titles and status of every file in `<repo>/briefs/`. Never ask what's already written down, and
   point out an existing or parked brief that covers the same idea.
2. **One round, up to four questions.** Ask with the AskUserQuestion tool. Each question gets two
   to four concrete options; the user can always type their own. Across the rounds, cover:
   - the problem: who has it, and what they do today instead;
   - the user: which kind of user, and how often;
   - success: what changes for them, and how we'd know it worked;
   - scope: what is explicitly out.
   Make the options real proposals from the vision and roadmap, not generic placeholders.
3. **Two or three rounds per feature, at most.** Then draft. Anything still unclear goes into
   the brief under `## Open questions` instead of another round.
4. **Check feasibility only when it matters.** If the idea depends on how the code works today,
   ask the `feasibility` subagent one specific question ("Does the dashboard already track
   X per session, and where?"). Use its summary; never read code yourself.
5. **Research in bounded doses.** At most a few web searches per feature. Save findings to
   `<repo>/research/<topic>.md` (sources plus 5-10 lines) and cite that note in the brief.
6. **End with a decision.** Draft the brief with `write-brief`, show it, and ask with
   AskUserQuestion: approve, revise (what?), or park.
