
# term helpers
alias c="clear"

# app shortcuts
alias t="trt "
alias mou="open /Applications/Mou.app"

# don't bug me
alias ack='nocorrect ack '
alias sshfs='nocorrect sshfs '
alias composer='nocorrect composer '

# git shortcuts
alias g="git"
alias gap="git add -p"
alias gd="git diff"
alias gp="git push"
alias gts="git for-each-ref --format='%(refname:short) <- %(upstream:short)' refs/heads"
alias gpf="git pull --ff-only"

# git workflow
alias pause="git add --all; git commit -m 'WIP'"
alias resume="git reset HEAD~"

