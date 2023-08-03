
# macports
PATH=/opt/local/bin:/opt/local/sbin:$PATH

# local bin folder
PATH=$HOME/bin:$PATH

# symfony vendors
PATH=vendor/bin:$PATH

# enable history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt appendhistory

# don't store dups
HIST_IGNORE_DUPS=1

# eager write to history
setopt inc_append_history

# share history between sessions
setopt share_history
