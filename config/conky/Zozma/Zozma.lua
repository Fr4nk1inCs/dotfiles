conky.config = {
    --==============================================================================

    --  Created : 2021/Agt/05
    --  this theme is for conky version 1.10.8 or newer
    --
    --  ZOZMA
    --  ( A part of Leonis Conky themes pack )
    --
    --  author  : Closebox73
    --  license : Distributed under the terms of GPLv3
    --  notes   : Created on 1366x768 Monitor

    --==============================================================================

    -- Size and Position settings --
    alignment = "middle_left",
    gap_x = 20,
    gap_y = 0,
    maximum_width = 296,
    minimum_height = 630,
    minimum_width = 296,
    -- Text settings --
    use_xft = true,
    override_utf8_locale = true,
    font = "Roboto:light:size=10",
    -- Color Settings --
    default_color = "white",
    default_outline_color = "white",
    default_shade_color = "white",
    color1 = "81A1C1",
    -- Window Settings --
    background = false,
    border_width = 1,
    draw_borders = false,
    draw_graph_borders = false,
    draw_outline = false,
    draw_shades = false,
    own_window = true,
    own_window_colour = "000000",
    own_window_class = "Conky",
    own_window_argb_visual = false,
    own_window_type = "override",
    own_window_transparent = true,
    own_window_hints = "undecorated,below,sticky,skip_taskbar,skip_pager",
    stippled_borders = 0,
    -- Others --
    cpu_avg_samples = 2,
    net_avg_samples = 2,
    double_buffer = true,
    out_to_console = false,
    out_to_stderr = false,
    extra_newline = false,
    update_interval = 1,
    uppercase = false,
    use_spacer = "none",
    show_graph_scale = false,
    show_graph_range = false,
    lua_load = "~/.config/conky/Zozma/scripts/Lua/rings-v1.2.1.lua",
    lua_draw_hook_pre = "ring_stats",
}

conky.text = [[
${execi 120 ~/.config/conky/Zozma/scripts/weather.sh}\
${image ~/.config/conky/Zozma/res/bg.png -p 0,0 -s 300x120}\
${image ~/.config/conky/Zozma/res/bg1.png -p 0,135}\
${image ~/.config/conky/Zozma/res/face.png -p 20,153-s 65x65}\
${offset 27}${voffset 27}${font Feather:size=45}${execi 15 ~/.config/conky/Zozma/scripts/weather-text-icon}${font}
${offset 105}${voffset -72}${color}${font Finlandica:bold:size=16}${execi 100 ~/.config/conky/Zozma/scripts/Greeting.sh}!!${font}
${offset 105}${voffset 3}${color}${font Finlandica:size=10}Hello ${execi 600 whoami | sed "s|\<.|\U&|g"}
${offset 105}${voffset 3}${execi 100 cat ~/.cache/weather.json | jq -r '.weather[0].main' | sed "s|\<.|\U&|g"} in ${execi 600 cat ~/.cache/weather.json | jq -r '.name'}, ${execi 100 cat ~/.cache/weather.json | jq '.main.temp' | awk '{print int($1+0.5)}'}°C
${offset 105}${voffset 3}Humidity ${execi 100 cat ~/.cache/weather.json | jq '.main.humidity'}% & WS ${execi 100 cat ~/.cache/weather.json | jq '.wind.speed'}mps
${offset 105}${voffset 49}${color}${font Finlandica:bold:size=15}${distribution}${font}
${offset 105}${voffset 2}${color}${font Finlandica:size=10}-----------------------------------------
${offset 105}${voffset 2}${color}${font Finlandica:size=10}Uptime >> ${uptime}
${offset 105}${voffset 2}${color}${font Finlandica:size=10}Wi-Fi >> ${execi 3 ~/.config/conky/Zozma/scripts/ssid}
${offset 105}${voffset 2}${color}${font Finlandica:size=10}Up : ${upspeed wlp0s20f3}${goto 210}Down : ${downspeed wlp0s20f3}
${offset 105}${voffset 2}${color}${font Finlandica:size=10}Temperature : ${hwmon 5 temp 1}°C
${offset 27}${voffset 47}${color}${font Finlandica:bold:size=12}System info :
${offset 75}${voffset 47}${color}${font Finlandica:size=8}CPU${goto 222}RAM
${offset 75}${voffset -3}${color}${font Finlandica:bold:size=15}${cpu cpu0}%${goto 222}${memperc}%
${offset 75}${voffset 45}${color}${font Finlandica:size=8}SYSTEM${goto 222}HOME
${offset 75}${voffset -3}${color}${font Finlandica:bold:size=15}${fs_used_perc}%${goto 222}${fs_used_perc /home}%
${offset 105}${voffset 45}${color}${font Finlandica:size=11}${if_match "${exec playerctl status}" != ""}${exec playerctl status} :${else}No music played${endif}${font}
${offset 105}${voffset 5}${color1}${font Sarasa Mono SC:bold:size=15}${exec playerctl metadata xesam:artist}${font Comfortaa:bold:size=2}
${offset 105}${voffset 4}${color}${font Sarasa Mono SC:italic:size=10}${exec playerctl metadata xesam:title}
]]
