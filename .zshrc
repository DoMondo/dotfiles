
#zmodload zsh/zprof

bindkey -v
zstyle :compinstall filename '/home/ogomez/.zshrc'

autoload -Uz compinit
#compinit
source ~/.zshrc.local
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

#zprof
