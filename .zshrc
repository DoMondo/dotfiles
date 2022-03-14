bindkey -v
zstyle :compinstall filename '/home/ogomez/.zshrc'

autoload -Uz compinit
compinit
source ~/.zshrc.local
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ogomez/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ogomez/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ogomez/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ogomez/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
