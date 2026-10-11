# Sprint summary: sprint 10 (2026-10-11, phase 2)

Decision 0007 steps 3 and 4 are done: every client panel is a Vue component, one root `App.vue` replaced `app.ts`,
and `patch.ts`, `dom.ts`, `escape.ts` and `timeSpan` are gone ("no `v-html`" replaces "always `esc()`"). The user
approved all tickets up front and asked the lead to run the sprint without asking. 27 tickets merged; main CI green.

## Shipped

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| T-062 | shared `relative-time.vue` | #74 | 1 |
| T-063 | open-popup ref, popup buttons from state | #75 | 1 |
| T-064 / T-065 / T-066 / T-067 | projects / team / messages / usage popup panels | #79 / #83 / #92 / #94 | 1 / 1 / 2 / 2 |
| T-068 / T-069 | core strip / tooltip | #76 / #77 | 2 / 3 |
| T-070 / T-071 | permission requests (`auth`) / approvals log (`auth`) | #78 / #95 | 1 / 2 |
| T-072 / T-073 | sessions panel / alerts panel | #85 / #89 | 2 / 2 |
| T-074 / T-075 | summary setting / audit panel | #98 / #88 | 1 / 1 |
| T-076 / T-077 / T-088 | devices panel / QR via `import()` / token cleared on close (all `auth`) | #90 / #93 / #97 | 1 / 1 / 1 |
| T-078 / T-079 / T-080 / T-081 | chat / launch form / transcript drawer / session actions | #84 / #87 / #91 / #96 | 2 / 1 / 3 / 2 |
| T-082 / T-083 | building scene / building dialog | #81 / #86 | 1 / 1 |
| T-084 | one popup shell from `POPUPS` | #99 | 1 |
| T-085 / T-086 | login / pair pages (`auth`) | #80 / #82 | 1 / 2 |
| T-087 | root `App.vue`, `index.html` skeleton, string-HTML helpers deleted | #100 | 1 |

Only one review found a real defect (T-080: drawer stayed on "error" after a failed first load); every other second
or third round was a re-check after merging `main`.

## Open

| Ticket | Status | Next step |
| --- | --- | --- |
| T-045 | backlog, owner user | user's approve/deny check from a paired device |

## Waiting on the user

- **Browser check of the whole Vue client** (NEEDS-YOU 2026-10-11, sprint 10 line); it replaces the T-050/T-052 check.
- T-045: approve/deny check (steps in `board/backlog/T-045-verify-approve-deny.md`).
- Remove `N:\tmp-t044\` (and `N:\tmp-vue-skills\` if still there).
- Design session: phone/tablet app + voice (trusted LAN certificate, access away from home Wi-Fi, voice approvals).

## Decisions

No new decision file. Applied [0007](../decisions/0007-client-on-vue-and-vite.md) steps 3-4 in full.

## Metrics

Engineer $20.10, reviewer $6.28 for 27 PRs (rows in `metrics/baseline.md`). Bundle after T-087: 158 kB (56.7 kB gzip);
the QR library is its own chunk (T-077). About $6 of that went to conflict-only rework and re-review runs.

## Notes for next sprint

- **Panels conflicted with each other.** Every panel ticket edited `app.ts` (and often `index.html`, `eslint.config.js`
  legacy list, `docs/architecture.md`), so each merge made the other open PRs conflict: 11 tickets needed a
  merge-only rework, T-069 and T-080 a 3rd round. With `App.vue` this hotspot is gone; for any future fan-out, build the
  shared registration point first, or land tickets one at a time.
- **Review before rework, land serially.** What worked at the end: review the code even if the PR conflicts, then one
  landing chain per ticket (merge main, quick re-check, merge) with no other merge in between.
- **Verdict format.** Reviewers copied the lead's bullet notes (`- round 2: approve`), so merge.sh missed the verdict;
  merge.sh now accepts that form (627294d). Lead notes in `## Review` should stay rare; a rework engineer once wrote a
  new `## Hand-off (round 3)` heading below `## Review`, which hid the verdict.
- **Two account session limits (15:40, 20:40) and one low-memory stop** killed runs mid-way; all resumed without loss.
  Keep to 2 Claude jobs at a time from the lead (engineer + reviewer/merge), not 2 engineers plus reviews.
- **Git Bash has no `pgrep`**, and `ls a b` fails if one path is missing: two lead wait loops never fired.
- **Lead must not edit a reviewer's verdict line**; the classifier refuses it ("Merge Without Review"). Re-run the review.
- T-076 review: popup Close left a shown device token; fixed in T-088.

## Next sprint

1. The user's browser check of the Vue client; the lead turns findings into tickets first.
2. T-045 when the user has run the device check.
3. Decision 0007 "Later": a designer brief for the PWA / phone app and voice control (needs the design session).
