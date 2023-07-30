#!/usr/bin/env bash

LANG=en_US.UTF-8

get_volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

get_mute() {
	pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

get_volume_icon() {
	volume=$(get_volume)
	mute=$(get_mute)
	if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ]; then
		echo audio-volume-muted-blocking-symbolic
	elif [ "$volume" -lt 34 ]; then
		echo audio-volume-low-symbolic
	elif [ "$volume" -lt 67 ]; then
		echo audio-volume-medium-symbolic
	else
		echo audio-volume-high-symbolic
	fi
}

volume_notify() {
	volume=$(get_volume)
	dunstify --icon="$(get_volume_icon)" \
		--timeout=1000 \
		--replace=2593 \
		--urgency=normal \
		--appname="Audio Volume" \
		"$volume%" \
		--hints int:value:"$volume"
}

volume_up() {
	volume=$(get_volume)
	step=${1//%/}
	if [ $((volume + step)) -gt 100 ]; then
		pactl set-sink-volume @DEFAULT_SINK@ 100%
	else
		pactl set-sink-volume @DEFAULT_SINK@ +"$1"
	fi
}

volume_down() {
	pactl set-sink-volume @DEFAULT_SINK@ -"$1"
}

toggle_mute() {
	pactl set-sink-mute @DEFAULT_SINK@ toggle
}

case $1 in
up)
	volume_up "$2"
	;;
down)
	volume_down "$2"
	;;
mute)
	toggle_mute
	;;
*)
	echo "Usage: $0 {up|down|mute} [amount]"
	exit 1
	;;
esac

volume_notify
