
# oh-my-zsh location
ZSH=$HOME/.oh-my-zsh

# setup oh-my-zsh
if [ ! -e $ZSH ];
then
    echo "'OH MY ZUSH!' not found, installing..."
    git clone git://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

# oh-my-zsh theme
ZSH_THEME="robbyrussell"

# oh-my-zsh plugins
plugins=(git osx extract)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

