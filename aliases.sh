
# don't bug me
alias ack='nocorrect ack '
alias cd='nocorrect cd '
alias composer='nocorrect composer '

# git shortcuts
alias g="git"
alias gap="git add -p"
alias gd="git diff"
alias gp="git push"
alias gpf="git pull --ff-only"
alias gpt="git push && git push --tags"
alias gbc="git branch --merged | grep -v master | xargs git branch -d"
alias gbd="git branch --sort=-committerdate | head"
alias gcn="git commit --no-verify"
alias am="git commit --amend"
alias gc="git commit"
alias gb="git branch"

# git workflow
alias pause="git add --all; git commit --no-verify -m 'WIP'"

# github
alias pb='git push -fu origin head'
alias pr='pb && open "https://github.com/owsy/$(basename `git rev-parse --show-toplevel`)/compare/$(/opt/local/bin/git branch | grep \* | awk '"'"'{print $2}'"'"')?expand=1"'

# misc
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias ip="curl http://wtfismyip.com/text"
alias ll='ls -l'

# bindhq
alias ddiff='php -d memory_limit=2G bin/console doctrine:migrations:diff | awk '"'"'{ print $6 }'"'"' | sed  '"'"'s/"//g'"'"' | tr -d '"'"'\n'"'"' | pbcopy '
