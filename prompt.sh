#!/bin/bash

precmd() {
    vcs_info
}

function get_cwd {
    basename "$PWD"
}

setopt prompt_subst

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "(%b)"

PROMPT=$'%{$fg[blue]%}$(get_cwd)%{$reset_color%}%{$fg[red]%}${vcs_info_msg_0_}%{$reset_color%} '

export PROMPT
