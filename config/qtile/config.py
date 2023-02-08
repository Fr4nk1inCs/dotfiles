# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import asyncio
from libqtile import qtile, bar, layout, hook
from libqtile.config import Click, Drag, Group, Key, Match, ScratchPad, DropDown, Screen
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

# Scripts & Commands
home = os.path.expanduser('~')
config_dir = os.path.realpath(__file__).rsplit('/', 1)[0]

rofi = {
    "app":      "rofi -show drun -theme launchpad",
    "window":   "rofi -show window -theme window",
    "power":   f"{config_dir}/rofi/powermenu.sh",
    "display": f"{config_dir}/rofi/display.sh",
}

scripts = {
    "battery":    f"{config_dir}/scripts/battery-info.sh",
    "reload":     f"{config_dir}/scripts/reload-monitor.sh",
    "screenshot": f"{config_dir}/scripts/screenshot.sh",
    "lock":       f"{config_dir}/lock/locker lock",
    "startup":    f"{config_dir}/scripts/startup.sh",
}

volume = {
    "up":     "amixer -D pulse sset Master 5%+",
    "down":   "amixer -D pulse sset Master 5%-",
    "mute":   "amixer -D pulse sset Master toggle",
    "s_up":   "amixer -D pulse sset Master 1%+",
    "s_down": "amixer -D pulse sset Master 1%-",
}

brightness = {
    "up":     "brightnessctl set +10%",
    "down":   "brightnessctl set 10%-",
    "s_up":   "brightnessctl set +5%",
    "s_down": "brightnessctl set 5%-",
}

music = {
    "next": "playerctl next",
    "prev": "playerctl previous",
    "play": "playerctl play-pause",
}


# Helper Functions
@lazy.window.function
def resize_floating_window(window, width: int = 0, height: int = 0):
    window.cmd_set_size_floating(window.width + width, window.height + height)


@lazy.window.function
def move_floating_window(window, x: int = 0, y: int = 0):
    window.cmd_set_position_floating(window.float_x + x, window.float_y + y)

# Hooks


@hook.subscribe.startup_once
def startup():
    subprocess.Popen(scripts["startup"])


@hook.subscribe.screen_change
def restart_on_randr(qtile, _):
    lazy.reload_config()


@hook.subscribe.client_new
async def move_spotify(client):
    await asyncio.sleep(0.01)
    if client.name == 'Spotify':
        client.togroup("6")
# Colors & Themes


class ColorScheme:
    class Nord:
        black = "#2E3440"
        gray = "#4C566A"
        white = "E5E9F0"
        red = "#BF616A"
        orange = "#D08770"
        yellow = "#EBCB8B"
        green = "#A3BE8C"
        purple = "#B48EAD"
        cyan = "#8FBCBB"
        aqua = "#88C0D0"
        blue = "#81A1C1"
        navy = "#5E81AC"


color = ColorScheme.Nord
background = f"{config_dir}/assets/background.jpg"

# Terminal
# from libqtile.utils import guess_terminal
# terminal = guess_terminal()
terminal = "kitty"

# Keybindings & Mouses
alt = "mod1"
mod = "mod4"
shift = "shift"
ctrl = "control"

keys = [
    # Terminal
    Key([mod], "Return",    lazy.spawn(terminal), desc="Launch terminal"),

    # Qtile Relative
    Key([mod, ctrl], "r",       lazy.reload_config(), desc="Reload the config"),
    Key([mod, ctrl], "q",       lazy.shutdown(),      desc="Shutdown Qtile"),
    Key([mod, shift], "Return", lazy.spawncmd(),      desc="Spawn prompt"),
    Key([mod], "q",             lazy.window.kill(),   desc="Kill window"),

    # Layouts
    Key([mod, shift], "Tab", lazy.next_layout(),   desc="Toggle next layout"),
    Key([mod, shift], "Space",
        lazy.window.toggle_floating(),
        desc="Toggle floating"),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen"),
    Key([mod], "m",
        lazy.window.toggle_maximize(),
        desc="Toggle maximize"),
    Key([mod], "x",
        lazy.group.setlayout("monadtall"),
        desc="Set layout to monadtall"),
    Key([mod], "z",
        lazy.group.setlayout("zoomy"),
        desc="Set layout to zoomy"),
    Key([mod], "Escape",
        lazy.group.setlayout("ratiotile"),
        desc="Set layout to ratiotile"),

    # Window Navigation
    Key([mod], "Left",   lazy.layout.left(),  desc="Move focus to left"),
    Key([mod], "Right",  lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Up",     lazy.layout.up(),    desc="Move focus up"),
    Key([mod], "Down",   lazy.layout.down(),  desc="Move focus down"),
    Key([alt], "Tab",    lazy.layout.next(),  desc="Move focus next"),
    Key([alt], "Return", lazy.next_screen(),  desc="Move to next screen"),

    # Window Swapping/Moving
    Key([mod, shift], "Left",
        lazy.layout.shuffle_left(),
        lazy.layout.move_left(),
        # move_floating_window(x=-10),
        desc="Move window left"),
    Key([mod, shift], "Right",
        lazy.layout.shuffle_right(),
        lazy.layout.move_right(),
        # move_floating_window(x=10),
        desc="Move window right"),
    Key([mod, shift], "Up",
        lazy.layout.shuffle_up(),
        lazy.layout.move_up(),
        # move_floating_window(y=-10),
        desc="Move window up"),
    Key([mod, shift], "Down",
        lazy.layout.shuffle_down(),
        lazy.layout.move_down(),
        # move_floating_window(y=10),
        desc="Move window down"),

    # Window Resizing
    Key([mod, ctrl], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.increase_ratio(),
        # resize_floating_window(width=-30),
        desc="Grow window left"),
    Key([mod, ctrl], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.decrease_ratio(),
        # resize_floating_window(width=30),
        desc="Grow window right"),
    Key([mod, ctrl], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        # resize_floating_window(height=-30),
        desc="Grow window up"),
    Key([mod, ctrl], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        # resize_floating_window(height=30),
        desc="Grow window down"),
    Key([mod, ctrl], "n",
        lazy.layout.normalize(),
        desc="Normalize window"),

    # Rofi Scripts
    Key([mod], "Space",    lazy.spawn(rofi["app"]),     desc="Applications"),
    Key([mod], "Tab",      lazy.spawn(rofi["window"]),  desc="Opened windows"),
    Key([mod, shift], "e", lazy.spawn(rofi["power"]),   desc="Power menu"),
    Key([mod], "p",        lazy.spawn(rofi["display"]), desc="Display menu"),

    # Scripts: Lock & Reload display
    Key([mod], "l", lazy.spawn(scripts["lock"]),   desc="Lock Screen"),
    Key([mod], "r", lazy.spawn(scripts["reload"]), desc="Reload Display"),

    # Media Keys: Volume, Brightness, Music player, Screenshot
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn(volume["up"]),
        desc="Volume up"),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn(volume["down"]),
        desc="Volume down"),
    Key([], "XF86AudioMute",
        lazy.spawn(volume["mute"]),
        desc="Mute volume"),
    Key([shift], "XF86AudioRaiseVolume",
        lazy.spawn(volume["s_up"]),
        desc="Volume up"),
    Key([shift], "XF86AudioLowerVolume",
        lazy.spawn(volume["s_down"]),
        desc="Volume down"),

    Key([], "XF86MonBrightnessUp",
        lazy.spawn(brightness["up"]),
        desc="Brightness up"),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn(brightness["down"]),
        desc="Brightness down"),
    Key([shift], "XF86MonBrightnessUp",
        lazy.spawn(brightness["s_up"]),
        desc="Brightness up"),
    Key([shift], "XF86MonBrightnessDown",
        lazy.spawn(brightness["s_down"]),
        desc="Brightness down"),

    Key([], "XF86AudioNext", lazy.spawn(music["next"]), desc="Next song"),
    Key([], "XF86AudioPrev", lazy.spawn(music["prev"]), desc="Previous song"),
    Key([], "XF86AudioPlay", lazy.spawn(music["play"]), desc="Play/Pause song"),

    Key([], "Print",
        lazy.spawn(f"{scripts['screenshot']} full"),
        desc="Screenshot"),
    Key([shift], "Print",
        lazy.spawn(f"{scripts['screenshot']} select"),
        desc="Screenshot"),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.toggle_floating()),
]


# Groups
groups = [
    Group(name="1", label="", layout="monadtall"),
    Group(name="2", label="", layout="monadtall"),
    Group(name="3", label="", layout="max"),
    Group(name="4", label="", layout="zoomy"),
    Group(name="5", label="", layout="ratiotile"),
    Group(name="6", label="", layout="max", screen_affinity=1,
          matches=[Match(wm_class="^Spotify")]),
    Group(name="7", label="", layout="ratiotile", screen_affinity=1,
          matches=[Match(wm_class="icalingua"),
                   Match(wm_class="QQ"),
                   Match(wm_class="telegram-desktop")]),
    Group(name="8", label="", layout="max", screen_affinity=1,
          matches=[Match(wm_class="Clash for Windows")]),
    Group(name="9", label="", layout="monadtall",
          matches=[Match(wm_class="Obs Studio")]),
    Group(name="0", label="", layout="monadtall"),
]

for i in groups:
    keys.extend([
        Key([mod], i.name,
            lazy.group[i.name].toscreen(),
            desc=f"Switch to group {i.name}",
            ),
        Key([mod, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc=f"Switch to & move focused window to group {i.name}",
            ),
    ])

groups.append(ScratchPad("scratchpad", [
    DropDown("term", terminal, width=0.7,
             height=0.7, x=0.15, y=0.15, opacity=0.8),
    DropDown("file", "thunar", width=0.7,
             height=0.7, x=0.15, y=0.15, opacity=0.8),
    DropDown("browser", "google-chrome-stable", width=0.8, height=0.8, x=0.1,
             y=0.1, opacity=0.8, wrap_pointer=True, on_focus_lost_hide=False),
]))

keys.extend([
    Key([mod], "backslash",
        lazy.group["scratchpad"].dropdown_toggle("term"),
        desc="Open dropdown terminal"),
    Key([mod], "n",
        lazy.group["scratchpad"].dropdown_toggle("file"),
        desc="Open dropdown file manager"),
    Key([mod], "c",
        lazy.group["scratchpad"].dropdown_toggle("browser"),
        desc="Open dropdown browser"),
])

# Layouts
layout_theme = {
    "border_width": 3,
    "margin": 10,
    "border_focus": color.blue,
    "border_normal": color.gray,
    "grow_amount": 5,
}

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="Conky"),
        Match(wm_class="Pavucontrol"),
        Match(wm_class="Blueberry.py"),
        Match(wm_class="Arandr"),
        Match(wm_class="matplotlib"),
        Match(wm_class="Nm-connection-editor"),
        Match(wm_class="minecraft-launcher"),
        Match(wm_class="wemeetapp"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    **layout_theme
)

layouts = [
    layout.MonadTall(**layout_theme, ratio=0.6),
    layout.Max(**layout_theme),
    layout.Zoomy(**layout_theme),
    layout.RatioTile(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
]

# Bar & Window
widget_defaults = dict(
    font="Liga SFMono Nerd Font",
    fontsize=16,
    padding=3,
    background=color.black,
    foreground=color.white,
)
extension_defaults = widget_defaults.copy()


def gen_bar(secondary=False):
    def gen_decor(color=color.gray, left=False, right=False):
        l_radius = 7 if left else 0
        r_radius = 7 if right else 0
        return [
            RectDecoration(
                colour=color,
                radius=[l_radius, r_radius, r_radius, l_radius],
                padding_y=4,
                filled=True,
            )
        ]
    sep = widget.Sep(
        foreground=color.black,
        padding=1,
        linewidth=3,
        size_percent=55,
    )
    return bar.Bar(
        [
            sep,
            widget.LaunchBar(
                font="Feather",
                foreground=color.black,
                text_only=True,
                progs=[
                    ["", rofi["power"], "Power menu"],
                    ["", "google-chrome-stable", "Chrome"],
                    ["", "thunar", "File Explorer"],
                    ["", "gnome-control-center", "Settings"],
                ],
                decorations=gen_decor(color.navy, left=True, right=True)
            ),
            sep,
            widget.TextBox(
                text="",
                font="Feather",
                foreground=color.black,
                decorations=gen_decor(color.red, left=True),
                mouse_callbacks={
                    "Button1": lazy.spawn("kitty -e yay -Syu")
                }
            ),
            widget.CheckUpdates(
                distro="Arch_yay",
                display_format="{updates}",
                colour_have_updates=color.black,
                colour_no_updates=color.black,
                no_update_string="0",
                execute="kitty -e yay -Syu",
                update_interval=1800,
                decorations=gen_decor(color.red, right=True),
            ),
            sep,
            widget.TextBox(
                text="",
                font="Feather",
                foreground=color.black,
                decorations=gen_decor(color.orange, left=True),
            ),
            widget.Wlan(
                foreground=color.black,
                format="{essid}",
                interface="wlp0s20f3",
                decorations=gen_decor(color.orange, right=True),
                mouse_callbacks={
                    "Button1": lazy.spawn("gnome-control-center wifi"),
                }
            ),
            sep,
            # widget.TextBox(
            #     text="",
            #     font="Feather",
            #     foreground=color.black,
            #     decorations=gen_decor(color.yellow, left=True),
            #     mouse_callbacks={
            #         "Button1": lazy.spawn("kitty -e btop"),
            #     }
            # ),
            # widget.CPU(
            #     foreground=color.black,
            #     format="{load_percent:2.0f}%",
            #     decorations=gen_decor(color.yellow, right=True),
            #     mouse_callbacks={
            #         "Button1": lazy.spawn("kitty -e btop"),
            #     }
            # ),
            # sep,
            # widget.TextBox(
            #     text="",
            #     font="Feather",
            #     foreground=color.black,
            #     decorations=gen_decor(color.purple, left=True),
            # ),
            # widget.Memory(
            #     foreground=color.black,
            #     format="{MemUsed:.1f}{mm}B",
            #     decorations=gen_decor(color.purple, right=True),
            #     measure_mem="G",
            # ),
            # sep,
            # widget.TextBox(
            #     text="",
            #     font="Feather",
            #     foreground=color.black,
            #     decorations=gen_decor(color.green, left=True),
            # ),
            # widget.ThermalSensor(
            #     foreground=color.black,
            #     foreground_alert=color.red,
            #     tag_sensor="Package id 0",
            #     format="{temp:.0f}{unit}",
            #     threshold=70,
            #     decorations=gen_decor(color.green, right=True),
            # ),
            # sep,
            # widget.TextBox(
            #     text="",
            #     font="Feather",
            #     foreground=color.black,
            #     decorations=gen_decor(color.orange, left=True),
            #     mouse_callbacks={
            #         "Button1": lazy.spawn("thunar"),
            #     }
            # ),
            # widget.DF(
            #     foreground=color.black,
            #     format="{uf:.0f}{m}B",
            #     visible_on_warn=False,
            #     warn_space=20,
            #     warn_color=color.red,
            #     decorations=gen_decor(color.orange, right=True),
            #     mouse_callbacks={
            #         "Button1": lazy.spawn("thunar"),
            #     }
            # ),
            widget.CurrentLayoutIcon(
                scale=0.50,
                foreground=color.black,
                decorations=gen_decor(color.blue, left=True),
                padding=0,
            ),
            widget.WindowName(
                width=bar.CALCULATED,
                empty_group_string="Desktop",
                max_chars=20,
                foreground=color.black,
                decorations=gen_decor(color.blue, right=True),
            ),
            sep,
            widget.Prompt(
                prompt=" ",
            ),
            widget.Spacer(),
            widget.GroupBox(
                font="Feather",
                highlight_method="line",
                padding=4,
                block_highlight_text_color=color.blue,
                highlight_color=color.gray,
                inactive=color.gray,
                this_current_screen_border=color.navy,
                this_screen_border=color.navy,
                other_current_screen_border=color.cyan,
                other_screen_border=color.cyan,
                urgent_alert_method="text",
                urgent_text=color.red,
                background=color.black,
                foreground=color.white,
                disable_drag=True,
                borderwidth=2,
            ),
            widget.Spacer(),
            *(
                (
                    widget.Systray(
                        decorations=gen_decor(left=True, right=True)
                    ),
                )
                if not secondary else ()
            ),
            # widget.OpenWeather(
            #     appkey="a0d415b0c3c3cb678cb790922499cc71",
            #     cityid="1808722",
            #     format="{icon}{main_temp: .0f}°{units_temperature}",
            #     decorations=gen_decor(left=secondary, right=True),
            # ),
            sep,
            widget.TextBox(
                text="",
                font="Feather",
                foreground=color.black,
                decorations=gen_decor(color.purple, left=True),
            ),
            widget.Volume(
                foreground=color.black,
                decorations=gen_decor(color.purple, right=True),
                mouse_callbacks={"Button3": lazy.spawn("pavucontrol --tab=3")},
            ),
            sep,
            widget.TextBox(
                text="",
                font="Feather",
                foreground=color.black,
                decorations=gen_decor(color.yellow, left=True),
            ),
            widget.Backlight(
                foreground=color.black,
                backlight_name="intel_backlight",
                change_command='brightnessctl set {}%',
                step=5,
                decorations=gen_decor(color.yellow, right=True),
            ),
            sep,
            widget.Battery(
                format="{char}",
                charge_char="",
                discharge_char="",
                full_char="",
                unknown_char="",
                empty_char="",
                font="Feather",
                show_short_text=False,
                foreground=color.black,
                low_percentage=0.3,
                low_foreground=color.red,
                decorations=gen_decor(color.green, left=True),
                mouse_callbacks={"Button1": lazy.spawn(scripts["battery"])}
            ),
            widget.Battery(
                format="{percent:2.0%} {hour:d}:{min:02d}",
                show_short_text=False,
                foreground=color.black,
                low_percentage=0.3,
                low_foreground=color.red,
                decorations=gen_decor(color.green, right=True),
                mouse_callbacks={"Button1": lazy.spawn(scripts["battery"])}
            ),
            sep,
            widget.TextBox(
                text="",
                font="Feather",
                foreground=color.black,
                decorations=gen_decor(color.blue, left=True),
            ),
            widget.Clock(
                format="%m-%d %H:%M",
                foreground=color.black,
                decorations=gen_decor(color.blue, right=True),
            ),
            sep
        ],
        35,
        margin=[0, 0, 0, 0])


screens = [
    Screen(
        top=gen_bar(),
        wallpaper=background,
        wallpaper_mode="stretch",
    ),
    Screen(
        top=gen_bar(True),
        wallpaper=background,
        wallpaper_mode="stretch",
    ),
]

# Others
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "never"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"

if qtile.core.name == "x11":
    term = "urxvt"
elif qtile.core.name == "wayland":
    term = "foot"
