# Hermes Agent (Nous Research): what it is and how it fits the homelab

Two web searches on 2026-10-24. Sources were secondary (DataCamp, blogs, a docs mirror) plus the official
cron docs page, so **check the official repo (github.com/NousResearch/hermes-agent) before building on it.**

## What it is

- An open-source (MIT) agent harness from Nous Research. It is not the Hermes model line, despite the shared name.
- Model-agnostic: it runs on API models or on local models through Ollama.
- It is built as an always-on personal assistant. You talk to it through a gateway on chat platforms (Telegram and
  others). It keeps memory about the user across sessions, stores every session in SQLite and can search them,
  and it writes and refines its own "skills" from tasks that went well.
- Cron: one-shot or recurring jobs, created from chat (`/cron`) or the CLI (`hermes cron create`), with results
  delivered to a chat, a file or a platform. The jobs run only while the gateway runs. A job gets no chat context,
  so its prompt has to carry everything it needs. A cron run can't create more cron jobs.
- Runs on Linux, macOS and WSL2. It is popular: over 30k GitHub stars by one count.

## Fit with this box (designer's view, not a technical decision)

- **Local model as its brain is weak here.** An agent loop sends a long prompt every turn (system prompt, tools,
  memory) and needs 16k–32k of context. On the GTX 1080 an 8B Q4 model fits with about 8k of context, Pascal is slow
  at prompt processing, and tool calling at 8B is unreliable. The Ollama context default is small and silently
  truncates prompts, which breaks tool calls.
- **With an API model as its brain** it works, but that costs money, and Claude Code on the box already does that job.
- **Overlaps:** a chat gateway plus an agent on the box covers much of F-021 (task inbox from the phone). Cron covers
  "recurring tasks", which F-021 lists as out of scope. Scheduled reports overlap F-020.
- **Conflicts with the briefs as written:** F-021 rules out chat apps as a way to send tasks, and VISION rules out
  any agent with a root shell. Any shell tool Hermes has would need the same limits as F-019.

Sources: dsebastien.net/hermes-agent, datacamp.com/tutorial/hermes-agent, innfactory.ai/en/ai-harness/hermes-agent,
hermes-agent.nousresearch.com/docs/user-guide/features/cron, plus Ollama context articles (ssdnodes.com, docs.openwebui.com).
