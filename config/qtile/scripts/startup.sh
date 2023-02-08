#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

blueberry-tray &
nm-applet &
mailspring --background &
cfw &
fcitx5 &
dunst &
prime-offload && optimus-manager-qt &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
"$HOME/.config/conky/conky.sh" &
"$script_dir/../lock/auto-lock" &
"$script_dir/reload-monitor.sh" &
