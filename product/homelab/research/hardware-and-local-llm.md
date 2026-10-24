# homelab: hardware limits and setup recommendations

From the design debate with the user on 2026-10-24, without web searches, so **check versions at build time**.
This is input for the lead and architect, not a decision: the technical choices are theirs.

Sources to check: NVIDIA CUDA 13.0 release notes (Pascal support dropped), the driver 580 release notes
(last branch for Pascal), Ollama GPU docs (docs.ollama.com/gpu), Ubuntu Server NVIDIA driver docs
(ubuntu.com/server/docs, "NVIDIA drivers installation").

## Hardware limits

- **GTX 1080, 8 GB, Pascal (compute 6.1):** CUDA 13 dropped Pascal, and driver branch 580 is the last one
  that supports it, so the box stays on 580 for good. Ollama still runs Pascal through its CUDA 12 backend;
  that backend is the thing most likely to go away first. Pascal has no tensor cores and slow FP16:
  text generation is fine, but prompt processing is slow.
- **16 GB DDR3, no upgrade (the user's choice):** model layers that spill out of VRAM run slowly and take
  RAM from the projects. So: models that fit fully in 8 GB.
- **i7-4790K:** AVX2, 4 cores and 8 threads; fine for dev work and builds.
- **What fits:** 7–8B models at Q4_K_M (~5 GB) plus an 8k context and a small embedding model; roughly
  40–50 tok/s for an 8B model. 12–14B only just fits, with a short context. Bigger models are out of reach.

## Recommendations from the debate

| Topic | Recommendation | Against it |
| --- | --- | --- |
| OS | Ubuntu Server 24.04 LTS, headless (the user chose headless), GA kernel | 26.04 is newer but less proven with the 580 driver |
| Driver | NVIDIA 580 (the `-server` variant via `ubuntu-drivers --gpgpu`); Secure Boot off | Kernel updates can break the DKMS build, so health-check after each one |
| LLM runtime | Ollama, native systemd service, version pinned; fallback: build llama.cpp with CUDA 12.x | Docker gives easier rollback but adds GPU plumbing |
| Network | Tailscale on all machines; ufw: SSH from the LAN and Tailscale, Ollama only on `tailscale0`; key-only SSH | Ollama's API has no auth, so never expose it on the LAN |
| Projects | Docker Engine (ShopApp has a docker-compose); Node 24 LTS via nvm (claude-dashboard uses Vite 8) | Docker-published ports bypass ufw: bind them to 127.0.0.1 or the Tailscale IP |
| Agent safety | Claude Code on the box never gets sudo; root steps are scripts the user runs | One extra hop per root step |
| Memory | 8 GB swapfile, `vm.swappiness=10` | — |

## Gotchas worth a checklist line

- The Ubuntu Server installer gives the root LVM volume only ~100 GB by default; extend it to the full disk.
- In the BIOS, set "restore on AC power loss" so the box comes back after an outage.
- Check under load that `ollama ps` shows the model at **100% GPU**; any CPU share means it doesn't fit.
- `OLLAMA_FLASH_ATTENTION` and `OLLAMA_KV_CACHE_TYPE=q8_0` save VRAM but need testing on Pascal.
- Claude Code login on a headless box: `/login` prints a URL to open on another machine.

## Who can do what

The OS install, BIOS, network and driver steps happen before Claude can run on the box: the user does
those, from a checklist. From the dev tooling onward, Claude on the box can work through the plan,
writing root steps as scripts for the user to run.
