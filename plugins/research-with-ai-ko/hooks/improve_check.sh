#!/usr/bin/env bash
# research-with-ai improvement hook (00 principle 18): silent unless a signal or a pending item exists.
#   UserPromptSubmit: if the researcher's message looks like a correction or a gap-revealing question, add one line of
#                     context reminding the agent to log a general lesson in the candidate note this turn.
#   Stop:             once per state, remind to ask about pending candidates at a work milestone, and to ask about
#                     publishing when accepted changes have piled up since the last public release.
# Values come from <session>/.claude/research-with-ai.conf, else ~/.claude/research-with-ai.conf. No values -> no-op.
#   IMPROVE_CANDIDATES  candidate note (lines marked PENDING_MARK are pending)
#   IMPROVE_LOG         improvement log (lines after the last line containing PUBLISH_MARK are unpublished)
#   SIGNAL_PATTERNS     extended regex for signal messages (default below)   PUBLISH_MIN  default 3
MSG_SIGNAL="개선 신호일 수 있음: 이 말이 방법의 빈틈을 드러내면 이번 턴에 개선 후보 한 줄을 남길 것(사례는 신호 칸에만, 교훈은 \"언제 → 무엇을 → 왜\"로 범용, 같은 교훈은 그 줄에 합침; 00 원칙 18)."
MSG_PENDING="개선 후보 %s개가 반영 여부 대기 — 일의 매듭이면 모아서 한 번에 물을 것"
MSG_PUBLISH="개선 일지에 공개판 미반영 %s줄 — 공개 저장소에 올릴지 한 번 물을 것"
DEFAULT_SIGNALS='(^|[[:space:]])아니[[:space:],.]|아니야[[:space:]]|아니잖|그게 아니|아니라고|왜 그렇게|왜 이렇게|왜 안|틀렸|틀린 거|잘못|다시 해|답답|말했잖|안 되잖|빠뜨|놓쳤|not what i|that.s wrong|why did you|i told you'
PENDING_MARK='반영 여부 대기'; PUBLISH_MARK='공개 저장소 반영'
in=$(cat)
S="${CLAUDE_PROJECT_DIR:-$PWD}"
IMPROVE_CANDIDATES=; IMPROVE_LOG=; SIGNAL_PATTERNS=; PUBLISH_MIN=3
if [ -f "$S/.claude/research-with-ai.conf" ]; then . "$S/.claude/research-with-ai.conf"; fi
if [ -z "$IMPROVE_CANDIDATES$IMPROVE_LOG" ] && [ -f "$HOME/.claude/research-with-ai.conf" ]; then . "$HOME/.claude/research-with-ai.conf"; fi
[ -z "$IMPROVE_CANDIDATES$IMPROVE_LOG" ] && exit 0
ev=$(python3 -c 'import json,sys;d=json.loads(sys.stdin.read() or "{}");print(d.get("hook_event_name",""))' <<<"$in" 2>/dev/null)
if [ "$ev" = "UserPromptSubmit" ]; then
  p=$(python3 -c 'import json,sys;print(json.loads(sys.stdin.read()).get("prompt",""))' <<<"$in" 2>/dev/null)
  if printf '%s' "$p" | tr '[:upper:]' '[:lower:]' | grep -qE "${SIGNAL_PATTERNS:-$DEFAULT_SIGNALS}"; then
    python3 -c 'import json,sys;print(json.dumps({"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":sys.argv[1]}},ensure_ascii=False))' "$MSG_SIGNAL"
  fi
  exit 0
fi
[[ "$in" == *'"stop_hook_active":true'* ]] && exit 0
seen="$HOME/.claude/research-with-ai.improve_seen"; touch "$seen"
m=()
if [ -f "$IMPROVE_CANDIDATES" ]; then
  n=$(grep -c "$PENDING_MARK" "$IMPROVE_CANDIDATES")
  if [ "$n" -gt 0 ] && ! grep -qxF "pending:$n:$(date +%F)" "$seen"; then echo "pending:$n:$(date +%F)" >> "$seen"; m+=("$(printf "$MSG_PENDING" "$n")"); fi
fi
if [ -f "$IMPROVE_LOG" ]; then
  last=$(grep -n "$PUBLISH_MARK" "$IMPROVE_LOG" | tail -1 | cut -d: -f1); last=${last:-0}
  u=$(tail -n +"$((last + 1))" "$IMPROVE_LOG" | grep -c '^- ')
  if [ "$u" -ge "$PUBLISH_MIN" ] && ! grep -qxF "publish:$u:$last" "$seen"; then echo "publish:$u:$last" >> "$seen"; m+=("$(printf "$MSG_PUBLISH" "$u")"); fi
fi
[ ${#m[@]} -eq 0 ] && exit 0
python3 -c 'import json,sys;print(json.dumps({"decision":"block","reason":sys.argv[1]},ensure_ascii=False))' "$(printf '%s; ' "${m[@]}" | sed 's/; $//')"
