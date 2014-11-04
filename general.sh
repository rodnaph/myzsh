
# enable vim mode
set -o vi

# allow reverse search
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# vim as default editor
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$EDITOR

# allow hash as comment
setopt INTERACTIVE_COMMENTS

