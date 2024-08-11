#!/usr/bin/env bash

# Example output of acpi -b:
# - Battery x: Discharging, 99%, 19:59:30 remaining
# - Battery x: Charging, 99%, 00:00:30 until charged
# - Battery x: Not charging, 99%
# - Battery x: Full, 100%
info=$(acpi -b | tail -1 | sed 's/.*: //')

status=$(echo $info | awk -F ', ' '{print $1}')
percentage=$(echo $info | awk -F ', ' '{print $2}' | tr -d '%')
time=$(echo $info | awk -F ', ' '{print $3}')

if [ "$time" = "" ]; then
    time="(full)"
else
    time="($time)"
fi

# fmt(icon, color?)
function fmt() {
    if [ $# -eq 2 ]; then
        echo "<span color='$2'>$1 $percentage%</span> $time"
    else
        echo "$1 $percentage% $time"
    fi
}

if [ "$status" = "Charging" ]; then
    fmt "󰂄" "#a3be8c"
elif [ "$status" = "Not charging" ]; then
    fmt "󰂄" "#a3be8c"
elif [ "$status" = "Full" ]; then
    fmt "󰂄" "#a3be8c"
elif [ $percentage -gt 90 ]; then
    fmt "󰁹"
elif [ $percentage -gt 80 ]; then
    fmt "󰂂"
elif [ $percentage -gt 70 ]; then
    fmt "󰂁"
elif [ $percentage -gt 60 ]; then
    fmt "󰂀"
elif [ $percentage -gt 50 ]; then
    fmt "󰁿"
elif [ $percentage -gt 40 ]; then
    fmt "󰁾"
elif [ $percentage -gt 30 ]; then
    fmt "󰁽" "#c9826b"
elif [ $percentage -gt 20 ]; then
    fmt "󰁼" "#c9826b"
elif [ $percentage -gt 10 ]; then
    fmt "󰁻" "#bf616a"
else
    fmt "󰁺" "#bf616a"
fi
