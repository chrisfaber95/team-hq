#!/usr/bin/env bash
# SessionStart hook: list briefs waiting on the designer, so every design session starts with them.
cd "$(dirname "$0")/../.." 2>/dev/null || exit 0
files=$(grep -l '^status: needs-design' ./*/briefs/*.md 2>/dev/null | sed 's|^\./||')
[ -z "$files" ] && exit 0
echo "Briefs with questions from the lead; handle these first:"
echo "$files"
