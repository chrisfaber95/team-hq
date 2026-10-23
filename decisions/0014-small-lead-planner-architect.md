# 0014: Small lead, planner and architect agents, batch runner, trimmed overhead

Date: 2026-10-23. Decided by: the user (small lead, planner and architect agents, `/clear` per epic, trim overhead),
the lead (the scripts and numbers below).

## Context

The lead ran on Opus in one interactive session per sprint. Its context grew all sprint and was re-read on every
wake-up (once per dispatch, review and merge step), while most of its work was routing. Headless team runs are
cheap by comparison (`metrics/baseline.md`: engineer about $1-2, review about $0.15, merge about $0.14).

## Decision

- **Lead on Sonnet**, started with `--strict-mcp-config`, `/clear` after each epic. State lives in the board,
  `SPRINT.md` and `board/EPICS.md`. Try Haiku after one clean epic.
- **`scripts/run-tickets.sh <repo> <id>...`** chains dispatch, review, rework and merge for a list of tickets and
  wakes the lead once (DONE or STOP). The step scripts still own claude runs, gates and `NEEDS-YOU.md`.
- **`planner` agent** (sonnet, `scripts/plan.sh F-NNN <repo>`): approved brief to tickets, using `write-ticket`.
  The lead no longer writes tickets, so that transcript stays out of its context.
- **`architect` agent** (opus, subagent of the planner): technical design as a `decisions/` file for briefs that
  touch several modules or change a data shape. Contracts, dependencies, migrations, auth stay proposals that
  escalate to `NEEDS-YOU.md`.
- **Overhead:** headless runs get `--disable-slash-commands` (they read their skill by path). Measured with the
  same one-turn prompt on Sonnet (prompt tokens, cached plus new): default 26.3k, `--strict-mcp-config` 24.4k,
  plus `--disable-slash-commands` 17.6k. So the connectors cost about 2k and the unused skill list about 7k per
  session; the floor is the system prompt, tools and `CLAUDE.md`.

## Consequences

- A headless run saves about 9k prompt tokens (about a third); small per run, but it is paid by every run.
  The larger saving is the lead: far fewer turns, a cheaper model, and a short context after each epic.
- The lead's `CLAUDE.md` text is also loaded by engineers; keep lead-only text short (limit 200 lines).
- Open: measure a full epic's lead cost against the Opus lead before making Sonnet the only mode; consider
  trimming the 103-line engineer skill.
