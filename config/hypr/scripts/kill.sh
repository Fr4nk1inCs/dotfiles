#!/bin/sh

active_window_class=$(hyprctl activewindow -j | jq -r ".class")

if [ $active_window_class = "Steam" ]; then
    xdotool windowunmap $(xdotool getactivewindow)
else
    hyprctl dispatch killactive ""
fi
