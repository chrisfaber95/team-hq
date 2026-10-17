#!/usr/bin/env bash
# The engineer's own Unreal Editor for a repo with an `editor` entry in budgets.json repoSettings
# (decision 0010). It runs on the current worktree, not on the user's checkout, and serves the
# Unreal MCP on its own port so Blueprint changes land on the ticket branch.
# usage (in the worktree): bash N:/team-hq/scripts/unreal-editor.sh start|stop|build|check [repo]
#   start  start the editor with no window and wait until /mcp answers
#   stop   kill the editor started by `start`
#   build  compile the C++ editor target
#   check  the repo's check (Stop hook, test-runner): build, compile all Blueprints, restart the
#          editor if it was running
# repo defaults to $TEAM_REPO, which dispatch.sh exports for the engineer run.
set -euo pipefail

cmd=${1:?usage: unreal-editor.sh start|stop|build|check [repo]}
repo=${2:-${TEAM_REPO:?no repo: pass it or set TEAM_REPO}}
hq=$(cd "$(dirname "$0")/.." && pwd)
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }
setting() { cfg "repoSettings?.['$repo']?.editor?.$1"; }

exe=$(setting exe)
[ -n "$exe" ] || { echo "no editor for '$repo' (budgets.json repoSettings.$repo.editor)" >&2; exit 64; }
project=$(setting project)
port=$(setting port)
extra_args=$(setting args)
engine=${exe%/Binaries/*}
project_win=$(cygpath -w "$PWD/$project")
target="$(basename "$project" .uproject)Editor"
# One engineer per repo (repoSettings maxParallel 1), so one pid file per repo.
pid_file=$hq/logs/editor-$repo.pid
log=$hq/logs/editor-$repo.log
mkdir -p "$hq/logs"

mcp_ready() {
  curl -s -m 5 -o /dev/null -w '%{http_code}' -X POST "http://127.0.0.1:$port/mcp" \
    -H 'Content-Type: application/json' -H 'Accept: application/json, text/event-stream' \
    -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"team-hq","version":"1"}}}' \
    | grep -q '^2'
}
running() { [ -f "$pid_file" ] && tasklist //FI "PID eq $(cat "$pid_file")" //NH 2>/dev/null | grep -qi unrealeditor; }

start() {
  running && { echo "editor already running (pid $(cat "$pid_file"))"; return 0; }
  mcp_ready && { echo "port $port is already serving MCP: another editor holds it" >&2; return 1; }
  # Detached from this shell's stdio, so a Bash tool call that runs `check` doesn't wait on the editor.
  # shellcheck disable=SC2086  # extra_args is a list of flags
  "$exe" "$project_win" -ModelContextProtocolPort="$port" -ExecCmds="ModelContextProtocol.StartServer $port" \
    $extra_args </dev/null >>"$log" 2>&1 &
  cat "/proc/$!/winpid" > "$pid_file"
  echo "== $(date -Is) editor pid $(cat "$pid_file") on port $port for $PWD" >> "$log"
  for _ in $(seq 60); do
    mcp_ready && { echo "editor ready on port $port"; return 0; }
    running || { echo "editor exited during startup; see logs/editor-$repo.log" >&2; rm -f "$pid_file"; return 1; }
    sleep 5
  done
  echo "editor did not serve MCP within 5 minutes" >&2; stop; return 1
}

stop() {
  if running; then taskkill //PID "$(cat "$pid_file")" //T //F >/dev/null 2>&1 || true; fi
  rm -f "$pid_file"
}

build() {
  local out
  out=$("$engine/Build/BatchFiles/Build.bat" "$target" Win64 Development -Project="$project_win" -WaitMutex 2>&1) \
    || { printf '%s\n' "$out" | grep -E 'error|Error' | tail -30 >&2; echo "build of $target failed" >&2; return 1; }
}

check() {
  local was_running=0 rc=0
  if running; then was_running=1; fi
  # A running editor holds the module DLLs; stopForBuild: false keeps it up (decision 0010).
  if [ "$(setting stopForBuild)" != false ]; then stop; fi
  build || rc=1
  if [ $rc -eq 0 ] && [ "$(setting compileBlueprints)" = true ]; then
    "$engine/Binaries/Win64/UnrealEditor-Cmd.exe" "$project_win" -run=CompileAllBlueprints -unattended -nosplash -nullrhi \
      >"$hq/logs/blueprints-$repo.log" 2>&1 \
      || { grep -E 'Error|error' "$hq/logs/blueprints-$repo.log" | tail -30 >&2; echo "Blueprint compile failed" >&2; rc=1; }
  fi
  if [ $was_running -eq 1 ] && ! running; then start || rc=1; fi
  return $rc
}

case $cmd in
  start|stop|build|check) "$cmd" ;;
  *) echo "unknown command $cmd" >&2; exit 64 ;;
esac
