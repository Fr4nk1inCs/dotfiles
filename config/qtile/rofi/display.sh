#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
display_dir="$script_dir/../displays"

# Display Types
laptop="single-laptop"
monitor="single-monitor"
dual="dual"
copy="copy"

# Options
option_1=""
option_2=""
option_3=""
option_4=""

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: 1; lines: 4;}" \
		-dmenu \
		-markup-rows \
		-theme display
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$option_1")
	echo "$laptop" >"$display_dir/saved"
	"$display_dir/refresh.sh"
	;;
"$option_2")
	echo "$monitor" >"$display_dir/saved"
	"$display_dir/refresh.sh"
	;;
"$option_3")
	echo "$dual" >"$display_dir/saved"
	"$display_dir/refresh.sh"
	;;
"$option_4")
	echo "$copy" >"$display_dir/saved"
	"$display_dir/refresh.sh"
	;;
esac
