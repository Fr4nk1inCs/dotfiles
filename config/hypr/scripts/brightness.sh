#!/usr/bin/env bash

get_brightness() {
	brightnessctl | grep -Po '[0-9]{1,3}%' | sed 's/%//'
}

get_brightness_icon() {
	brightness=$(get_brightness)
	if [ "$brightness" -eq 0 ]; then
		echo display-brightness-off-symbolic
	elif [ "$brightness" -lt 33 ]; then
		echo display-brightness-low-symbolic
	elif [ "$brightness" -lt 67 ]; then
		echo display-brightness-medium-symbolic
	else
		echo display-brightness-high-symbolic
	fi
}

brightness_notify() {
	brightness=$(get_brightness)
	dunstify --icon="$(get_brightness_icon)" \
		--timeout=1000 \
		--replace=2593 \
		--urgency=normal \
		--appname="Brightness" \
		"$brightness%" \
		--hints int:value:"$brightness"
}

case $1 in
up)
	brightnessctl -q set +"$2"
	;;
down)
	brightnessctl -q set "$2"-
	;;
*)
	echo "Usage: $0 {up|down} <amount>"
	exit 1
	;;
esac

brightness_notify
