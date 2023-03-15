#!/bin/sh

count=$(dunstctl count waiting)
icon=""

if [ "$count" -gt 0 ]; then
	count="<sup>$count</sup>"
else
	count=""
fi

if dunstctl is-paused | grep -q "false"; then
	icon=""
else
	icon=""
fi

json="
{
    \"text\": \"<span font_family='feather'>$icon</span>$count\",
    \"tooltip\": \"Toggle Notifications\"
}
"

echo "$json" | jq --unbuffered --compact-output
