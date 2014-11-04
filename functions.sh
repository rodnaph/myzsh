
function gfm { git merge $1 --ff-only && git branch -D $1; }

