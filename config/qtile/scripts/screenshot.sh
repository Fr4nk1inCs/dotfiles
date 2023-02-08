#!/usr/bin/env bash

pic_path="$HOME/Pictures/Screenshots/$(date +%F_%T).png"

function full_screen() {
	maim --hidecursor --padding=0 "$pic_path"
	xclip -selection clipboard -t image/png -i "$pic_path"
	notify-send \
		--urgency=low \
		--app-name="Screenshot" \
		"Screenshot taken, saved to $pic_path"
}

function rec_or_win() {
	maim --hidecursor --select --padding=0 "$pic_path"
	xclip -selection clipboard -t image/png -i "$pic_path"
	notify-send \
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
