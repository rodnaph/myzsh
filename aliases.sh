
# app shortcuts
alias t="trt "
alias mou="open /Applications/Mou.app"

# ios simulator
alias iossim="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
alias iphone="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator -SimulateDevice 'iPhone'"
alias ipad="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator -SimulateDevice 'iPad'"

# don't bug me
alias ack='nocorrect ack '
alias sshfs='nocorrect sshfs '
alias cd='nocorrect cd '
alias composer='nocorrect composer '

# git shortcuts
alias g="git"
alias gap="git add -p"
alias gd="git diff"
alias gp="git push"
alias gts="git for-each-ref --format='%(refname:short) <- %(upstream:short)' refs/heads"
alias gpf="git pull --ff-only"
alias gpt="git push && git push --tags"
alias gbc="gb --merged | grep -v master | xargs git branch -d"
alias gbd="gb --sort=-committerdate | head"

# git workflow
alias pause="git add --all; git commit -m 'WIP'"
alias resume="git reset HEAD~"

# github
alias pb='git push -fu origin head'
alias pr='pb && open "https://github.com/owsy/$(basename $PWD)/compare/$(/opt/local/bin/git branch | grep \* | awk '"'"'{print $2}'"'"')?expand=1"'

# misc
alias ip="curl http://wtfismyip.com/text"
