
# enable vim mode
set -o vi

# reduce <esc> timeout for normal mode
export KEYTIMEOUT=1

# allow reverse search
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# vim as default editor
export EDITOR=nvim
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$EDITOR

# allow hash as comment
setopt INTERACTIVE_COMMENTS

