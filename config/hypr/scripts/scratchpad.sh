#!/bin/sh

workspaces=$(hyprctl workspaces -j)

exe=""

case "$1" in
"term")
	exe="kitty"
	;;
"file")
	exe="thunar"
	;;
*)
	echo "Usage: $0 {term|file}"
	exit 1
	;;
esac

# Check if there is a special workspace named "special:$1"
# If there is, then toggle special workspace. Otherwise, create a new instance
# in the workspace and then toggle special workspace.

if [[ -z $(echo "$workspaces" | jq -r ".[] | select(.name == \"special:$1\")") ]]; then
	hyprctl dispatch exec "[workspace special:$1] $exe" &&
		sleep 0.4s &&
		hyprctl dispatch togglespecialworkspace "$1"
else
	hyprctl dispatch togglespecialworkspace "$1"
fi
