# Vision

<!-- You write this page; the designer reads it before every interview and never rewrites it.
     Drafted by the designer on 2026-10-24 from your answers in the first session: rewrite it in your own words. -->

**Product:** homelab: the old desktop (i7-4790K, 16 GB DDR3, GTX 1080 8 GB, 500 GB SSD) turned into an
always-on Ubuntu machine that runs a local LLM, my projects and Claude Code.

## Who it's for
Myself: my scripts and projects on any of my machines, and Claude Code sessions on the box itself.

## The problem it solves
Small LLM jobs in my scripts (summaries, classification, embeddings) cost API money, and my projects
only run on my main Windows PC.

## What it should become
A headless box I reach from anywhere over my private network, with a cheap local LLM helper that any
script can call, and my projects building and running on it.

## Principles
Headless and reached only over my own network (Tailscale); no agent gets a root shell (Claude may run a narrow allowlist of root actions, and anything else needs my approval, F-019); everything on the box
can be rebuilt from its repo; stay inside what the hardware can do (no RAM upgrade).

## Not the goal
Replacing Claude for coding with a local model; anything reachable from the internet.
