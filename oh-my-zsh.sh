
DISABLE_AUTO_UPDATE="true"

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
plugins=()

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

PROMPT='%{$fg_bold[white]%}$(date +"%H:%m") ${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
