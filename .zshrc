
#zmodload zsh/zprof

bindkey -v
zstyle :compinstall filename '/home/ogomez/.zshrc'

autoload -Uz compinit
#compinit
source ~/.zshrc.local
#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

#zprof

#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
