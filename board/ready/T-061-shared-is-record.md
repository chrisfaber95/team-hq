---
id: T-061
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007 typing follow-up
depends_on: [T-056, T-057]
contracts: []
labels: [auth]            # touches auth/devices-file.ts and limits.ts imports; behaviour unchanged
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr:
---
## Goal
There is one `isRecord` type guard for parsed JSON, shared by server and client, instead of a copy per module.

## Acceptance
- [ ] One exported `isRecord(value: unknown): value is Record<string, unknown>` in `src/shared/`, with its own test
- [ ] The copies in `src/server/auth/devices-file.ts`, `src/server/transcripts/transcript-line.ts` and `src/server/features/json/json-guards.ts` (and any other found by `git grep isRecord`) are removed and import the shared one; `json-guards.ts` is deleted if nothing else is left in it
- [ ] Behaviour unchanged: every existing test passes without edits to its expectations
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Three copies landed in one round: T-058 (`devices-file.ts:14`, narrows to `object`), T-055 and T-057. Check that callers of the `object` version still type-check with the `Record` version.
- T-056 may have added a fourth copy or import; `git grep isRecord` finds them all.
- `src/shared/` today holds only `types/`; put the guard in its own file next to it (e.g. `src/shared/guards.ts`) and say in `docs/code-style.md` that JSON guards live there. T-051 (client store) uses it too.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
