SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  export MOZ_ENABLE_WAYLAND=1
  exec sway
fi
