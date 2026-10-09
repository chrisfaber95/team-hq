# 0004: Ask-the-dashboard chat runs in the browser, no model by default

Date: 2026-10-09. Decided by: the user (summary mode, who may send), the lead (structure), for brief F-003.

## Context

F-003 wants a chat that answers status questions from what the dashboard shows and does a few safe actions. The user
chose fixed question types without a model. The brief left open how to summarize a session and who may send messages.

## Decision

- **In the browser.** A pure module turns text into an intent (`status`, `attention`, `usage`, `message`, `ack`,
  `open`, `summary`, `help`) and answers from the current `DashboardState`, so answers always match the dashboard.
  Text in, intent out: a later voice front-end feeds the same module.
- **Actions use existing endpoints only:** `POST /api/sessions/:id/message` (after the user confirms the session and
  exact text), `POST /api/alerts/dismiss`, and the existing transcript drawer. The chat never calls start, stop or
  `/api/commands`, and has no shell access.
- **Who may send (user's choice):** every signed-in device, as in the rest of the dashboard since F-002.
- **Summaries (user's choice):** default is a no-model recap from the transcript (`GET /api/sessions/:id/summary`). A
  dashboard setting `summary: 'recap' | 'model'` switches to one cheap-model call (`haiku`) through `claude-cli.ts`,
  with **no tools**, a bounded transcript excerpt, the 4-process cap, an audit entry, and a fallback to the recap on
  failure. Tokens only, never cost.

## Consequences

- Tickets T-016 (intents), T-017 (panel), T-018 (recap), T-019 (model setting, `auth`, needs `user_ok`).
- Transcript text is untrusted: in model mode it is data in the prompt, and with no tools the worst case is a wrong
  summary. The model answer is rendered as text (`esc()`), never as HTML.
- The model summary may take longer than the brief's ~10 s; it is opt-in and shows a "summarizing..." state.
