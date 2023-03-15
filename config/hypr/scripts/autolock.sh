#!/bin/sh

lock="$HOME/.config/hypr/scripts/lock.sh"

swayidle -w \
	timeout 300 "$lock" \
	timeout 600 "brightnessctl -s && brightnessctl set 0%" \
	resume "brightnessctl -r" \
	timeout 1800 'systemctl suspend' \
	before-sleep "$lock"
