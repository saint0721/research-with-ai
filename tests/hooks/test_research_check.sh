#!/usr/bin/env bash
# Tests for plugins/*/hooks/research_check.sh: a document on either side of a code commit inside the window covers
# that commit, and a WIKI_DIR that is not a git repository is reported once per project instead of being skipped.
# Every scenario runs against both editions. Only temporary folders (mktemp -d) are used.
set -u
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
TMP=$(mktemp -d) || exit 1
trap 'rm -rf "$TMP"' EXIT
pass=0 fail=0
ok() { pass=$((pass+1)); echo "ok - $1"; }
no() { fail=$((fail+1)); echo "not ok - $1"; }
blank() { [ -z "$1" ] && ok "$2" || no "$2 (got: $1)"; }
has() { case "$1" in *"$2"*) ok "$3" ;; *) no "$3 (got: $1)" ;; esac; }
miss() { case "$1" in *"$2"*) no "$3 (got: $1)" ;; *) ok "$3" ;; esac; }
block() { has "$1" '"decision": "block"' "$2 reports a line"; }
run() { # <hook> <project> [conf file]
  if [ -n "${3:-}" ]; then
    ( cd "$2" && CLAUDE_PROJECT_DIR="$2" RESEARCH_WITH_AI_CONF="$3" bash "$1" <<<'{}' )
  else
    ( cd "$2" && env -u RESEARCH_WITH_AI_CONF CLAUDE_PROJECT_DIR="$2" bash "$1" <<<'{}' )
  fi
}
repo() { # <dir>: a project repository with its own identity
  git init -q "$1"; git -C "$1" symbolic-ref HEAD refs/heads/main
  git -C "$1" config user.email t@example.com; git -C "$1" config user.name t
  git -C "$1" config commit.gpgsign false; git -C "$1" config tag.gpgsign false
}
put() { # <dir> <file> <text>: append one line and commit that file only
  mkdir -p "$(dirname "$1/$2")"; echo "$3" >> "$1/$2"
  git -C "$1" add -- "$2"; git -C "$1" commit -q -m "$3"
}
conf() { # <dir> <wiki dir value or empty>: code and document paths, optional wiki repository
  mkdir -p "$1/.claude"
  {
    echo "CODE_PATHS='\\.py\$'"; echo "DOC_PATHS='^docs/'"; echo "WINDOW='1 day ago'"
    [ -n "$2" ] && { echo "WIKI_DIR='$2'"; echo "WIKI_LOG='WIKI.md'"; }
  } > "$1/.claude/research-with-ai.conf"
  echo "$1/.claude/research-with-ai.conf"
}

for hook in "$ROOT"/plugins/research-with-ai-ko/hooks/research_check.sh \
            "$ROOT"/plugins/research-with-ai/hooks/research_check.sh; do
  ed=$(basename "$(dirname "$(dirname "$hook")")")
  bash -n "$hook" 2>/dev/null && ok "$ed: bash -n" || no "$ed: bash -n"
  d="$TMP/$ed"; mkdir -p "$d"

  # (a) one code-only commit -> one line
  R="$d/a"; repo "$R"; c=$(conf "$R" .)
  put "$R" src/model.py a1
  sha=$(git -C "$R" rev-parse --short=7 HEAD)
  out=$(run "$hook" "$R" "$c"); block "$out" "$ed a"; has "$out" "$sha" "$ed a names the commit"

  # (b) document -> code -> document -> the middle code commit is covered by both neighbours
  R="$d/b"; repo "$R"; c=$(conf "$R" .)
  put "$R" docs/plan.md b-plan; put "$R" src/model.py b-code; put "$R" docs/result.md b-result
  blank "$(run "$hook" "$R" "$c")" "$ed b stays quiet"

  # (c) code -> code with no document on either side -> both commits reported
  R="$d/c"; repo "$R"; c=$(conf "$R" .)
  put "$R" src/one.py c1; sha1=$(git -C "$R" rev-parse --short=7 HEAD)
  put "$R" src/two.py c2; sha2=$(git -C "$R" rev-parse --short=7 HEAD)
  out=$(run "$hook" "$R" "$c"); block "$out" "$ed c"; has "$out" "$sha1" "$ed c names the first"; has "$out" "$sha2" "$ed c names the second"

  # (d) WIKI_DIR is not a git repository -> one line naming the value, then quiet for the same state
  R="$d/d"; repo "$R"; c=$(conf "$R" gone/wiki)
  put "$R" docs/log.md d1
  out=$(run "$hook" "$R" "$c"); block "$out" "$ed d"; has "$out" "gone/wiki" "$ed d names the config value"
  miss "$out" "$(sed -n 's/.*MSG_TAIL="\(.*\)"$/\1/p' "$hook")" "$ed d gives no gap advice"
  blank "$(run "$hook" "$R" "$c")" "$ed d reports the same value once"

  # (e) no config file -> quiet
  R="$d/e"; repo "$R"
  put "$R" src/model.py e1
  blank "$(run "$hook" "$R")" "$ed e stays quiet without a config"
done

echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
