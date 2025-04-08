
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
alias gbc="git branch --merged | grep -v main | xargs git branch -d"
alias gbd="git branch --sort=-committerdate | head"
alias gcn="git commit --no-verify"
alias am="git commit --amend"
alias gc="git commit"
alias gb="git branch --sort=-committerdate"

# nvim
alias vi="nvim"

# git workflow
alias pause="git add --all; git commit --no-verify -m 'WIP'"
alias pu="docker compose exec bindhq-fpm rm -rf var/cache/test/twig; docker compose exec bindhq-fpm php -d memory_limit=2G vendor/bin/phpunit --order-by default"
alias puu="docker compose exec bindhq-fpm rm -rf var/cache/test/twig; docker compose exec bindhq-fpm php -d memory_limit=2G vendor/bin/phpunit --order-by default tests/unit"
alias mps="make phpstan"

# github
alias pb='git push -fu origin head'
alias pr='pb && open "https://github.com/owsy/$(basename `git rev-parse --show-toplevel`)/compare/$(git branch | grep \* | awk '"'"'{print $2}'"'"')?expand=1"'

# misc
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias ip="curl http://wtfismyip.com/text"
alias ll='ls -l'
alias cs="vendor/bin/php-cs-fixer fix"
alias m="make"

# bindhq
alias cc="rm -rf var/cache && docker compose exec bindhq-fpm rm -rf var/cache"
alias bc="docker compose exec bindhq-fpm bin/console"
