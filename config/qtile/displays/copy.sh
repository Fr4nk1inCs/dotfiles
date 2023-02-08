#!/bin/sh
if xrandr --query | grep -q 'HDMI-1 connected'; then
	xrandr --output eDP-1 --primary --mode 1920x1080 --rotate normal --output HDMI-1 --auto --same-as eDP-1 --mode 1920x1080 --rotate normal --output DP-1 --off --output HDMI-2 --off
else
	xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off
fi
