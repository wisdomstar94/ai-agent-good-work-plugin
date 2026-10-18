#!/bin/sh
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-${PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}}"
RULE_FILE="$PLUGIN_ROOT/skills/korean-language-skill/SKILL.md"

[ -f "$RULE_FILE" ] || exit 0

# 스킬과 같은 파일을 정본으로 쓰기 위해 프론트매터를 떼고 본문만 주입한다.
CONTEXT=$(awk '
  NR == 1 && /^---$/ { in_front = 1; next }
  in_front && /^---$/ { in_front = 0; next }
  in_front { next }
  !started && /^$/ { next }
  {
    started = 1
    gsub(/\\/, "\\\\")
    gsub(/"/, "\\\"")
    gsub(/\t/, "\\t")
    gsub(/\r/, "")
    printf "%s\\n", $0
  }
' "$RULE_FILE")

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$CONTEXT"
