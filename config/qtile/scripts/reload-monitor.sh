#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$script_dir/../displays/refresh.sh"

picom --no-use-damage --experimental-backend &
