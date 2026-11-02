#!/usr/bin/env bash
# research-with-ai Stop hook: one line when the research record has a gap, nothing otherwise.
# Project values live only in <project>/.claude/research-with-ai.conf (or $RESEARCH_WITH_AI_CONF). No file -> no-op.
#   CODE_PATHS  regex of changes that need a document        DOC_PATHS   regex of document paths
#   WIKI_DIR    wiki git repo (relative to the project or absolute, "." = same repo)
#   SOURCE_PATHS regex of project documents the wiki must ingest   NOTE_PATHS regex of note files in WIKI_DIR (optional)
#   WIKI_LOG    wiki log file inside WIKI_DIR      SYNC_TAG  tag marking the last push to a note vault (optional)
#   WINDOW      how far back to look (git --since), default "12 hours ago"
# Each key is optional: a check runs only when its keys are set. A commit or state is reported once (.git/research_check_seen).
MSG_HEAD="연구 기록 누락:"; MSG_CODE="%s 가 코드만 바꾸고 문서 없음"; MSG_DOC="문서 %s 뒤 위키 일지 없음"; MSG_NOTE="노트 %s 뒤 위키 일지 없음"; MSG_SYNC="노트 저장소 미반영"; MSG_TAIL="반영하거나 이유를 한 줄 적기"
in=$(cat); [[ "$in" == *'"stop_hook_active":true'* ]] && exit 0
P="${CLAUDE_PROJECT_DIR:-$PWD}"; C="${RESEARCH_WITH_AI_CONF:-$P/.claude/research-with-ai.conf}"
[ -f "$C" ] || exit 0
CODE_PATHS=; DOC_PATHS=; WIKI_DIR=; SOURCE_PATHS=; NOTE_PATHS=; WIKI_LOG=; SYNC_TAG=; WINDOW='12 hours ago'
. "$C"
g() { git -c core.quotepath=false -C "$@"; }
g "$P" rev-parse --git-dir >/dev/null 2>&1 || exit 0
seen="$(g "$P" rev-parse --absolute-git-dir)/research_check_seen"; touch "$seen"
new() { grep -qxF "$1" "$seen" && return 1; echo "$1" >> "$seen"; }
m=()
if [ -n "$CODE_PATHS" ] && [ -n "$DOC_PATHS" ]; then
  while read -r s; do [ -z "$s" ] && continue
    f=$(g "$P" show --name-only --format= "$s")
    grep -qE "$CODE_PATHS" <<<"$f" && ! grep -qE "$DOC_PATHS" <<<"$f" && new "code:$s" && m+=("$(printf "$MSG_CODE" "${s:0:7}")")
  done < <(g "$P" log --since="$WINDOW" --format=%H)
fi
if [ -n "$WIKI_DIR" ] && [ -n "$WIKI_LOG" ]; then
  case "$WIKI_DIR" in /*) W="$WIKI_DIR" ;; *) W="$P/$WIKI_DIR" ;; esac
  if g "$W" rev-parse --git-dir >/dev/null 2>&1; then
    ll=$(g "$W" log -1 --format=%ct -- "$WIKI_LOG"); ll=${ll:-0}
    [ -n "$SOURCE_PATHS" ] && while read -r s t; do [ -n "$s" ] && [ "$t" -gt "$ll" ] && g "$P" show --name-only --format= "$s" | grep -qE "$SOURCE_PATHS" && new "doc:$s" && m+=("$(printf "$MSG_DOC" "${s:0:7}")"); done < <(g "$P" log --since="$WINDOW" --format='%H %ct')
    if [ -n "$NOTE_PATHS" ] && [ "$(g "$W" rev-parse --absolute-git-dir)" != "$(g "$P" rev-parse --absolute-git-dir)" ]; then
      while read -r s t; do [ -n "$s" ] && [ "$t" -gt "$ll" ] && g "$W" show --name-only --format= "$s" | grep -qE "$NOTE_PATHS" && new "note:$s" && m+=("$(printf "$MSG_NOTE" "${s:0:7}")"); done < <(g "$W" log --since="$WINDOW" --format='%H %ct')
    fi
    if [ -n "$SYNC_TAG" ]; then
      d=$(g "$W" status --porcelain); h=$(g "$W" rev-parse HEAD); t=$(g "$W" rev-parse -q --verify "$SYNC_TAG" || echo -)
      { [ -n "$d" ] || [ "$h" != "$t" ]; } && new "sync:$h:$(echo "$d" | sha1sum | cut -c1-8)" && m+=("$MSG_SYNC")
    fi
  fi
fi
[ ${#m[@]} -eq 0 ] && exit 0
python3 -c 'import json,sys;print(json.dumps({"decision":"block","reason":sys.argv[1]},ensure_ascii=False))' "$MSG_HEAD $(printf '%s, ' "${m[@]}" | sed 's/, $//') — $MSG_TAIL"
