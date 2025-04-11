#!/bin/bash

function resume() {
    FORCE=$1;
    LAST_COMMIT_MESSAGE=$(git log -1 --pretty=%B);

    if [[ "WIP" == "$LAST_COMMIT_MESSAGE" ]] || [[ "-f" == "$FORCE" ]]; then
        git reset HEAD~
    else
        echo "ERROR: Last commit message does not look like a WIP."
    fi
}

function select_branch() {
  FZF_PROMPT="$1"
  FZF_FLAGS="$2"

  local target
  local current_branch

  current_branch=$(git rev-parse --abbrev-ref HEAD)

  target=$(
    git for-each-ref --sort=-committerdate --format="%(committerdate:iso8601)|%(refname:short)|%(committerdate:relative)|%(subject)" refs/heads/ \
    | while IFS="|" read -r date branch relative subject; do
        if [[ "$branch" == "$current_branch" ]]; then
          continue
        fi

        date_secs=$(date -j -f "%Y-%m-%d %H:%M:%S" "${date:0:19}" +%s 2>/dev/null)
        now_secs=$(date +%s)
        days_ago=$(( (now_secs - date_secs) / 86400 ))

        if [ "$days_ago" -le 1 ]; then
          color="\033[1;32m"  # green
        elif [ "$days_ago" -le 7 ]; then
          color="\033[1;33m"  # yellow
        else
          color="\033[1;31m"  # red
        fi

        reset="\033[0m"

        printf "%s|${color}%s${reset}|%s\n" "$branch" "$relative" "$subject"
      done \
    | column -t -s '|' \
    | fzf --no-hscroll $FZF_FLAGS --ansi --prompt="$FZF_PROMPT "
  ) || return

  echo $target | sed -E 's/\x1b\[[0-9;]*m//g' | awk '{print $1}'
}

function rb() {
  local branch

  branch=$(select_branch "Rebase on >") || return

  git rebase $branch
}

function rbi() {
  local branch

  branch=$(select_branch "Rebase interactive on >") || return

  git rebase -i $branch
}

function br() {
  local branch

  branch=$(select_branch "Checkout branch >") || return

  git checkout $branch
}

function gbd() {
  local branches

  branches=$(select_branch "Delete branches (shift+tab to select) >" "--multi") || return

  while IFS= read -r branch; do
    git branch -D $branch
  done <<< "$branches"
}
