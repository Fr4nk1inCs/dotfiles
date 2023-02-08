#!/bin/bash

export LANG=en_US.UTF-8
killall conky
sleep 2s

conky -c "$HOME/.config/conky/Zozma/Zozma.lua" &>/dev/null &
conky -c "$HOME/.config/conky/Zozma/Zozma2.lua" &>/dev/null &

exit
