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
    alignment = "middle_right",
    gap_x = 100,
    gap_y = 0,
    maximum_width = 300,
    minimum_height = 300,
    minimum_width = 300,
    -- Text settings --
    use_xft = true,
    override_utf8_locale = true,
    font = "FInlandica:size=9",
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
    own_window_colour = "#FFFFFF",
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
    lua_load = "~/.config/conky/Zozma/scripts/Lua/mini_clock.lua",
    lua_draw_hook_pre = "main",
}

conky.text = [[
${image ~/.config/conky/Zozma/res/ring.png -p 67,67 -s 166x166}\
${alignc}${voffset 110}${font Finlandica:bold:size=40}${time %H}${color C4C4C4}${time %M}${font}
${alignc}${voffset }${font Finlandica:size=16}${color1}${time %A}
]]
