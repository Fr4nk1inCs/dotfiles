#!/bin/sh

swayidle -w \
	timeout 600 "brightnessctl -s && brightnessctl set 0%" \
	resume "brightnessctl -r" \
	timeout 1800 'systemctl suspend' \
	resume "brightnessctl -r" &
