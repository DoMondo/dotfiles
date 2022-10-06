SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
emulate sh -c '. ~/.profile'

if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
	exec startx
fi
