#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
icon_path="$script_dir/../assets/battery-icon.png"

notify-send \
	--urgency=low \
	--app-name="Battery Info" \
	--icon="$icon_path" \
	"$(acpi -b | tail -1 | sed 's/Battery 1: //')"
