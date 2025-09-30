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
  
  # Get all local branch names once and store in a temp file for fast lookup
  local local_branches_file=$(mktemp)
  git for-each-ref --format="%(refname:short)" refs/heads/ | sort > "$local_branches_file"
  
  # Get current time once
  local now_secs=$(date +%s)
  local cutoff_secs=$((now_secs - 86400))  # 24 hours ago
  
  # Collect local branches
  local_output=$(
    git for-each-ref --sort=-committerdate --format="%(committerdate:unix)|%(refname:short)|%(committerdate:relative)|%(subject)" refs/heads/ \
    | while IFS="|" read -r date_secs branch relative subject; do
        if [[ "$branch" == "$current_branch" ]]; then
          continue
        fi
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
      done
  )
  
  # Collect remote branches
  remote_output=$(
    git for-each-ref --sort=-committerdate --format="%(committerdate:unix)|%(refname:short)|%(committerdate:relative)|%(subject)|%(committername)" refs/remotes/ \
    | while IFS="|" read -r date_secs branch relative subject committer; do
        # Skip HEAD references
        if [[ "$branch" == *"/HEAD" ]]; then
          continue
        fi
        
        # Only process if within 24 hours (quick numeric comparison)
        if [ "$date_secs" -lt "$cutoff_secs" ]; then
          continue
        fi
        
        # Extract the branch name without remote prefix (e.g., origin/feature -> feature)
        local_branch_name="${branch#*/}"
        
        # Skip if we already have this branch locally (fast file lookup)
        if grep -q "^${local_branch_name}$" "$local_branches_file"; then
          continue
        fi
        
        hours_ago=$(( (now_secs - date_secs) / 3600 ))
        if [ "$hours_ago" -le 1 ]; then
          color="\033[1;36m"  # cyan
        elif [ "$hours_ago" -le 8 ]; then
          color="\033[1;35m"  # magenta
        else
          color="\033[1;34m"  # blue
        fi
        reset="\033[0m"
        printf "%s|${color}%s${reset}|%s|%s\n" "$branch" "$relative" "$subject" "$committer"
      done
  )
  
  target=$(
    {
      # Local branches section
      if [[ -n "$local_output" ]]; then
        echo "$local_output"
      fi
      
      # Remote branches section
      if [[ -n "$remote_output" ]]; then
        [[ -n "$local_output" ]] && echo ""  # Add blank line if we had local branches
        echo "$remote_output"
        echo ""  # Add blank line after remote branches
      fi
    } \
    | column -t -s '|' \
    | fzf --no-hscroll $FZF_FLAGS --ansi --prompt="$FZF_PROMPT " --header-lines=0
  ) || { rm -f "$local_branches_file"; return; }
  
  # Clean up temp file
  rm -f "$local_branches_file"
  
  # Filter out any empty lines and extract branch name
  branch_line=$(echo "$target" | grep -v "^$")
  echo "$branch_line" | sed -E 's/\x1b\[[0-9;]*m//g' | awk '{print $1}'
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
  
  # Check if it's a remote branch
  if git show-ref --verify --quiet "refs/remotes/$branch"; then
    # It's a remote branch, create and checkout local tracking branch
    local_branch_name="${branch#*/}"
    git checkout -b "$local_branch_name" "$branch"
  else
    # It's a local branch, checkout normally
    git checkout $branch
  fi
}

function gbd() {
  local branches

  branches=$(select_branch "Delete branches (shift+tab to select) >" "--multi") || return

  while IFS= read -r branch; do
    git branch -D $branch
  done <<< "$branches"
}
