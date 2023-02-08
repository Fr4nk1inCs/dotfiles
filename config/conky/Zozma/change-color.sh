#!/usr/bin/env bash

# This script is linked to Zozma.conf and Zozma2.conf lines
# So don't  add or remove a line there unless you change here too
# Closebox73
# 05/Nov/2022

COLOR=${1}

echo "Processing....."
sleep 2s

echo "Stoping Zozma"
killall conky

sleep 0.7s
echo "Creating bg.png"
convert -size 300x120 xc:#$COLOR ~/.config/conky/Zozma/res/bg.png
convert -size 300x120 xc:none -draw "roundrectangle 0,0,300,120,8,8" png:- | convert ~/.config/conky/Zozma/res/bg.png -matte - -compose DstIn -composite ~/.config/conky/Zozma/res/bg.png

sleep 0.7s
echo "Set up Accent"
sed -i "33s|color1 = .*|color1 = '${COLOR}',|" ~/.config/conky/Zozma/Zozma.conf &
sleep 0.2s
sed -i "33s|color1 = .*|color1 = '${COLOR}',|" ~/.config/conky/Zozma/Zozma2.conf &
sleep 0.2s
sed -i "27s|fg_colour=0x.*|fg_colour=0x${COLOR},|" ~/.config/conky/Zozma/scripts/Lua/rings-v1.2.1.lua &
sleep 0.2s
sed -i "41s|fg_colour=0x.*|fg_colour=0x${COLOR},|" ~/.config/conky/Zozma/scripts/Lua/rings-v1.2.1.lua &
sleep 0.2s
sed -i "55s|fg_colour=0x.*|fg_colour=0x${COLOR},|" ~/.config/conky/Zozma/scripts/Lua/rings-v1.2.1.lua &
sleep 0.2s
sed -i "69s|fg_colour=0x.*|fg_colour=0x${COLOR},|" ~/.config/conky/Zozma/scripts/Lua/rings-v1.2.1.lua &
sleep 0.2s
sed -i "50s|fill_colorS      = {0x.*|fill_colorS      = {0x${COLOR}, 1},   -- fill color for seconds ring|" ~/.config/conky/Zozma/scripts/Lua/mini_clock.lua &

sleep 1s
echo "Success.."

sleep 1s
echo "Restarting Zozma..."
sleep 0.2s
conky -c $HOME/.config/conky/Zozma/Zozma.conf &> /dev/null &
conky -c $HOME/.config/conky/Zozma/Zozma2.conf &> /dev/null &

sleep 5s
echo "Done"

exit
