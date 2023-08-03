#!/bin/bash

function gfm { git merge "$1" --ff-only && git branch -D "$1"; }

# copy the contents of a directory to another
# usage: cpd ~/source/folder ~/dest/folder
function cpd() {
    s=$1;
    d=$2;
    for f in $s/*; do
        cp "$f" "$d";
    done
}

function resume() {
    FORCE=$1;
    LAST_COMMIT_MESSAGE=$(git log -1 --pretty=%B);

    if [[ "WIP" == "$LAST_COMMIT_MESSAGE" ]] || [[ "-f" == "$FORCE" ]]; then
        git reset HEAD~
    else
        echo "ERROR: Last commit message does not look like a WIP."
    fi
}

function br() {
    if [ "" != "$1" ]; then
        git checkout "$1"
    else
        local branches target

        #branches=$(git --no-pager branch --all --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" | sed '/^$/d') || return

        branches=$(git --no-pager branch -vv) || return
        target=$((echo "$branches") | fzf --no-hscroll --no-multi -n 2 --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return

        git checkout $(echo "$target" | awk '{print $1}' | sed "s/.* //")
    fi
}
