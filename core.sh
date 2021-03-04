
# macports
PATH=/opt/local/bin:/opt/local/sbin:$PATH

# local bin folder
PATH=$HOME/bin:$PATH

# symfony vendors
PATH=vendor/bin:$PATH

# enable history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# don't store dups
HIST_IGNORE_DUPS=1
