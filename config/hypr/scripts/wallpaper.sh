#!/usr/bin/env bash

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script is in bash (not posix shell), because the RANDOM variable
# we use is not defined in posix

dir="$HOME/.config/hypr/assets/"

# Edit bellow to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=10

# This controls (in seconds) when to switch to the next image
INTERVAL=300

sleep 1s

while true; do
    find "$dir" |
        while read -r img; do
            if [[ "$img" == "$dir" ]]; then
                continue
            fi
            echo "$((RANDOM % 1000)):$img"
        done |
        sort -n | cut -d':' -f2- |
        while read -r img; do
            swww img "$img"
            sleep $INTERVAL
        done
done
