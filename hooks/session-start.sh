#!/bin/sh
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-${PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}}"

CONTEXT=""
for SKILL in korean-language-skill work-skill; do
  RULE_FILE="$PLUGIN_ROOT/skills/$SKILL/SKILL.md"
  [ -f "$RULE_FILE" ] || continue

  # 스킬과 같은 파일을 정본으로 쓰기 위해 프론트매터를 떼고 본문만 주입한다.
  BODY=$(awk '
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

  [ -n "$CONTEXT" ] && CONTEXT="$CONTEXT\\n"
  CONTEXT="$CONTEXT$BODY"
done

[ -n "$CONTEXT" ] || exit 0

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$CONTEXT"
