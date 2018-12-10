
function gfm { git merge $1 --ff-only && git branch -D $1; }

# copy the contents of a directory to another
# usage: cpd ~/source/folder ~/dest/folder
function cpd() {
    s=$1;
    d=$2;
    for f in $s/*; do
        cp $f $d;
    done
}

function resume() {
    LAST_COMMIT_MESSAGE=$(git log -1 --pretty=%B);

    if [[ "WIP" == "$LAST_COMMIT_MESSAGE" ]]; then
        git reset HEAD~
    else
        echo "ERROR: Last commit message does not look like a WIP."
    fi
}
