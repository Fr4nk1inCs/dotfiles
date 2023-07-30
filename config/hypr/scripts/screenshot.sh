#!/bin/sh

pic_path="$HOME/Pictures/Screenshots/$(date +%F_%T).png"

full_screen() {
	grim "$pic_path" &&
		wl-copy -t image/png <"$pic_path" &&
		notify-send \
			--icon="$pic_path" \
			--urgency=low \
			--app-name="Screenshot" \
			"Screenshot taken, saved to $pic_path"
}

rec_or_win() {
	window_selection=$(
		hyprctl clients -j |
			jq -r ".[] | select(.workspace.id == "$(hyprctl activewindow -j | jq -r '.workspace.id')\)"" |
			jq -r ".at,.size" |
			jq -s "add" |
			jq '_nwise(4)' |
			jq -r '"\(.[0]),\(.[1]) \(.[2])x\(.[3])"' |
			slurp
	)
	grim -g "$window_selection" "$pic_path" &&
		wl-copy -t image/png <"$pic_path" &&
		notify-send \
			--icon="$pic_path" \
			--urgency=low \
			--app-name="Screenshot" \
			"Screenshot taken, saved to $pic_path"
}

case "$1" in
"full")
	full_screen
	;;
"select")
	rec_or_win
	;;
*)
	echo "Usage: $0 {full|select}"
	exit 1
	;;
esac
