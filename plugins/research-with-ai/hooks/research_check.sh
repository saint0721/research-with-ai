#!/usr/bin/env bash
# research-with-ai Stop hook: one line when the research record has a gap, nothing otherwise.
# Project values live only in <project>/.claude/research-with-ai.conf. The hook reads the session folder's own
# file and every such file in project folders up to three levels below it, and checks each project separately
# ($RESEARCH_WITH_AI_CONF = one file only). No file -> no-op. Paths in a file are relative to its project folder.
#   CODE_PATHS  regex of changes that need a document        DOC_PATHS   regex of document paths
#   WIKI_DIR    wiki git repo (relative to the project or absolute, "." = same repo)
#   SOURCE_PATHS regex of project documents the wiki must ingest   NOTE_PATHS regex of note files in WIKI_DIR (optional)
#   WIKI_LOG    wiki log file inside WIKI_DIR      SYNC_TAG  tag marking the last push to a note vault (optional)
#   WINDOW      how far back to look (git --since), default "12 hours ago"
# Each key is optional: a check runs only when its keys are set. A commit or state is reported once (.git/research_check_seen).
MSG_HEAD="Research record gap:"; MSG_CODE="%s changed code without a document"; MSG_DOC="document %s has no wiki log entry after it"; MSG_NOTE="note %s has no wiki log entry after it"; MSG_SYNC="note vault not synced"; MSG_TAIL="update it or state why in one line"
in=$(cat); [[ "$in" == *'"stop_hook_active":true'* ]] && exit 0
S="${CLAUDE_PROJECT_DIR:-$PWD}"
g() { git -c core.quotepath=false -C "$@"; }
m=()
# check <project dir> <conf file> <label>: adds messages for one project to m
check() {
  local P="$1" C="$2" tag="$3" seen W ll s t f d h
  CODE_PATHS=; DOC_PATHS=; WIKI_DIR=; SOURCE_PATHS=; NOTE_PATHS=; WIKI_LOG=; SYNC_TAG=; WINDOW='12 hours ago'
  . "$C"
  g "$P" rev-parse --git-dir >/dev/null 2>&1 || return 0
  seen="$(g "$P" rev-parse --absolute-git-dir)/research_check_seen"; touch "$seen"
  local key="${tag:+$tag:}" pre="${tag:+[$tag] }"
  new() { grep -qxF "$1" "$seen" && return 1; echo "$1" >> "$seen"; }
  # --relative: file names relative to the project folder, and only files inside it
  if [ -n "$CODE_PATHS" ] && [ -n "$DOC_PATHS" ]; then
    while read -r s; do [ -z "$s" ] && continue
      f=$(g "$P" show --relative --name-only --format= "$s")
      grep -qE "$CODE_PATHS" <<<"$f" && ! grep -qE "$DOC_PATHS" <<<"$f" && new "${key}code:$s" && m+=("$pre$(printf "$MSG_CODE" "${s:0:7}")")
    done < <(g "$P" log --since="$WINDOW" --format=%H -- .)
  fi
  if [ -n "$WIKI_DIR" ] && [ -n "$WIKI_LOG" ]; then
    case "$WIKI_DIR" in /*) W="$WIKI_DIR" ;; *) W="$P/$WIKI_DIR" ;; esac
    if g "$W" rev-parse --git-dir >/dev/null 2>&1; then
      ll=$(g "$W" log -1 --format=%ct -- "$WIKI_LOG"); ll=${ll:-0}
      [ -n "$SOURCE_PATHS" ] && while read -r s t; do [ -n "$s" ] && [ "$t" -gt "$ll" ] && g "$P" show --relative --name-only --format= "$s" | grep -qE "$SOURCE_PATHS" && new "${key}doc:$s" && m+=("$pre$(printf "$MSG_DOC" "${s:0:7}")"); done < <(g "$P" log --since="$WINDOW" --format='%H %ct' -- .)
      if [ -n "$NOTE_PATHS" ] && [ "$(g "$W" rev-parse --absolute-git-dir)" != "$(g "$P" rev-parse --absolute-git-dir)" ]; then
        while read -r s t; do [ -n "$s" ] && [ "$t" -gt "$ll" ] && g "$W" show --relative --name-only --format= "$s" | grep -qE "$NOTE_PATHS" && new "${key}note:$s" && m+=("$pre$(printf "$MSG_NOTE" "${s:0:7}")"); done < <(g "$W" log --since="$WINDOW" --format='%H %ct' -- .)
      fi
      if [ -n "$SYNC_TAG" ]; then
        d=$(g "$W" status --porcelain -- .); h=$(g "$W" rev-parse HEAD); t=$(g "$W" rev-parse -q --verify "$SYNC_TAG" || echo -)
        { [ -n "$d" ] || [ "$h" != "$t" ]; } && new "${key}sync:$h:$(echo "$d" | sha1sum | cut -c1-8)" && m+=("$pre$MSG_SYNC")
      fi
    fi
  fi
}
if [ -n "$RESEARCH_WITH_AI_CONF" ]; then
  [ -f "$RESEARCH_WITH_AI_CONF" ] && check "$S" "$RESEARCH_WITH_AI_CONF" ""
else
  # session folder first (no label), then project folders below it (label = path from the session folder)
  [ -f "$S/.claude/research-with-ai.conf" ] && check "$S" "$S/.claude/research-with-ai.conf" ""
  while IFS= read -r -d '' C; do
    D="${C%/.claude/research-with-ai.conf}"; check "$D" "$C" "${D#"$S"/}"
  done < <(find "$S" -mindepth 3 -maxdepth 5 -path '*/.git' -prune -o -path '*/node_modules' -prune -o \
             -path '*/.claude/research-with-ai.conf' -type f -print0 2>/dev/null | sort -z)
fi
[ ${#m[@]} -eq 0 ] && exit 0
python3 -c 'import json,sys;print(json.dumps({"decision":"block","reason":sys.argv[1]},ensure_ascii=False))' "$MSG_HEAD $(printf '%s, ' "${m[@]}" | sed 's/, $//') — $MSG_TAIL"
