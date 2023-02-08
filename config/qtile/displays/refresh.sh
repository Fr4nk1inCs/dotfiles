#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

saved=$(cat "$script_dir/saved")

"$script_dir/$saved.sh"
