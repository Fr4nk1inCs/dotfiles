#!/bin/sh
if xrandr --query | grep -q 'HDMI-1 connected'; then
	xrandr --output eDP-1 --off --output HDMI-1 --mode 2560x1440 --pos 0x0 --rate 75 --rotate normal --output DP-1 --off --output HDMI-2 --off
else
	xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off
fi
