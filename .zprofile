SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
emulate sh -c '. ~/.profile'

if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  #export MOZ_ENABLE_WAYLAND=1
  #exec sway --unsupported-gpu
 #exec dbus-run-session hyprland
  startx
fi
