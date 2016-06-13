
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

