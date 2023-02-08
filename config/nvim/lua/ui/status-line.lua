-- Feline
-- https://github.com/EdenEast/nightfox.nvim/blob/main/mics/feline.lua
--
-- This file is a complete example of creating the feline configuration shown in the readme of
-- nightfox. This configuration generates its own highlight groups from the currently applied
-- colorscheme. These highlight groups are regenreated on colorscheme changes.
--
-- Required plugins:
--    - `feline-nvim/feline.nvim`
--    - `kyazdani42/nvim-web-devicons`
--
-- This file is required to be in your `lua` folder of your config.  Your colorscheme should also
-- be applied before this file is sourced. This file cannot be located `lua/feline.lua` as this
-- would clash with the actual plugin require path.
--
-- # Example:
--
-- ```lua
-- vim.cmd("colorscheme nightfox")
-- require('user.ui.feline')
-- ```
local feline = require("feline")
local fmt = string.format

----------------------------------------------------------------------------------------------------
-- Colors

---Convert color number to hex string
---@param n number
---@return string
local hex = function(n)
    if n then
        return fmt("#%06x", n)
    end
end

---Parse `style` string into nvim_set_hl options
---@param style string
---@return table
local function parse_style(style)
    if not style or style == "NONE" then
        return {}
    end

    local result = {}
    for token in string.gmatch(style, "([^,]+)") do
        result[token] = true
    end

    return result
end

---Get highlight opts for a given highlight group name
---@param name string
---@return table
local function get_highlight(name)
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    if hl.link then
        return get_highlight(hl.link)
    end

    local result = parse_style(hl.style)
    result.fg = hl.foreground and hex(hl.foreground)
    result.bg = hl.background and hex(hl.background)
    result.sp = hl.special and hex(hl.special)

    return result
end

---Set highlight group from provided table
---@param groups table
local function set_highlights(groups)
    for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

---Generate a color palette from the current applied colorscheme
---@return table
local function generate_pallet_from_colorscheme()
    -- stylua: ignore
    local color_map = {
        black = {
            index = 0,
            default = "#393b44"
        },
        red = {
            index = 1,
            default = "#c94f6d"
        },
        green = {
            index = 2,
            default = "#81b29a"
        },
        yellow = {
            index = 3,
            default = "#dbc074"
        },
        blue = {
            index = 4,
            default = "#719cd6"
        },
        magenta = {
            index = 5,
            default = "#9d79d6"
        },
        cyan = {
            index = 6,
            default = "#63cdcf"
        },
        white = {
            index = 7,
            default = "#dfdfe0"
        }
    }

    local diagnostic_map = {
        hint = {
            hl = "DiagnosticHint",
            default = color_map.green.default,
        },
        info = {
            hl = "DiagnosticInfo",
            default = color_map.blue.default,
        },
        warn = {
            hl = "DiagnosticWarn",
            default = color_map.yellow.default,
        },
        error = {
            hl = "DiagnosticError",
            default = color_map.red.default,
        },
    }

    local pallet = {}
    for name, value in pairs(color_map) do
        local global_name = "terminal_color_" .. value.index
        pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
    end

    for name, value in pairs(diagnostic_map) do
        pallet[name] = get_highlight(value.hl).fg or value.default
    end

    pallet.sl = get_highlight("StatusLine")
    pallet.sel = get_highlight("TabLineSel")

    return pallet
end

---Generate user highlight groups based on the curent applied colorscheme
---
---NOTE: This is a global because I dont known where this file will be in your config
---and it is needed for the autocmd below
_G._generate_user_statusline_highlights = function()
    local pal = generate_pallet_from_colorscheme()

    -- stylua: ignore
    local sl_colors = {
        Black = {
            fg = pal.black,
            bg = pal.white
        },
        Red = {
            fg = pal.red,
            bg = pal.black
        },
        Green = {
            fg = pal.green,
            bg = pal.black
        },
        Yellow = {
            fg = pal.yellow,
            bg = pal.black
        },
        Blue = {
            fg = pal.blue,
            bg = pal.black
        },
        Magenta = {
            fg = pal.magenta,
            bg = pal.black
        },
        Cyan = {
            fg = pal.cyan,
            bg = pal.black
        },
        White = {
            fg = pal.white,
            bg = pal.black
        }
    }

    local colors = {}
    for name, value in pairs(sl_colors) do
        colors["User" .. name] = {
            fg = value.fg,
            bg = value.bg,
            bold = true,
        }
        colors["UserRv" .. name] = {
            fg = value.bg,
            bg = value.fg,
            bold = true,
        }
    end

    local status = vim.o.background == "dark" and {
        fg = pal.black,
        bg = pal.white,
    } or {
        fg = pal.white,
        bg = pal.black,
    }

    local groups = {
        -- statusline
        UserSLHint = {
            fg = pal.black,
            bg = pal.hint,
            bold = true,
        },
        UserSLInfo = {
            fg = pal.black,
            bg = pal.info,
            bold = true,
        },
        UserSLWarn = {
            fg = pal.black,
            bg = pal.warn,
            bold = true,
        },
        UserSLError = {
            fg = pal.black,
            bg = pal.error,
            bold = true,
        },
        UserSLStatus = {
            fg = status.fg,
            bg = status.bg,
            bold = true,
        },

        UserSLFtHint = {
            fg = pal.sel.bg,
            bg = pal.hint,
        },
        UserSLHintInfo = {
            fg = pal.hint,
            bg = pal.info,
        },
        UserSLInfoWarn = {
            fg = pal.info,
            bg = pal.warn,
        },
        UserSLWarnError = {
            fg = pal.warn,
            bg = pal.error,
        },
        UserSLErrorBg = {
            fg = pal.error,
            bg = pal.sl.bg,
        },

        UserSLAlt = pal.sel,
        UserSLAltBg = {
            fg = pal.sel.bg,
            bg = pal.sl.bg,
        },
        UserSLEncode = {
            fg = pal.sl.fg,
            bg = pal.black,
        },
        UserSLAltSep = {
            fg = pal.black,
            bg = pal.sel.bg,
        },
        UserSLGitBranch = {
            fg = pal.yellow,
            bg = pal.black,
        },
        UserSLGitAdd = {
            fg = pal.green,
            bg = pal.black,
        },
        UserSLGitChange = {
            fg = pal.yellow,
            bg = pal.black,
        },
        UserSLGitRemove = {
            fg = pal.red,
            bg = pal.black,
        },
    }

    set_highlights(vim.tbl_extend("force", colors, groups))
end

_generate_user_statusline_highlights()

vim.api.nvim_create_augroup("UserStatuslineHighlightGroups", {
    clear = true,
})
vim.api.nvim_create_autocmd({ "SessionLoadPost", "ColorScheme" }, {
    callback = function()
        _generate_user_statusline_highlights()
    end,
})

----------------------------------------------------------------------------------------------------
-- Feline

local vi = {
    -- Map vi mode to text name
    text = {
        n = "NORMAL",
        no = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        [""] = "V-BLOCK",
        c = "COMMAND",
        cv = "COMMAND",
        ce = "COMMAND",
        R = "REPLACE",
        Rv = "REPLACE",
        s = "SELECT",
        S = "SELECT",
        [""] = "SELECT",
        t = "TERMINAL",
    },

    -- Maps vi mode to highlight group color defined above
    colors = {
        n = "UserRvCyan",
        no = "UserRvCyan",
        i = "UserRvWhite",
        v = "UserRvMagenta",
        V = "UserRvMagenta",
        [""] = "UserRvMagenta",
        R = "UserRvRed",
        Rv = "UserRvRed",
        r = "UserRvBlue",
        rm = "UserRvBlue",
        s = "UserRvMagenta",
        S = "UserRvMagenta",
        [""] = "FelnMagenta",
        c = "UserRvYellow",
        ["!"] = "UserRvBlue",
        t = "UserRvBlue",
    },

    -- Maps vi mode to seperator highlight goup defined above
    sep = {
        n = "UserCyan",
        no = "UserCyan",
        i = "UserWhite",
        v = "UserMagenta",
        V = "UserMagenta",
        [""] = "UserMagenta",
        R = "UserRed",
        Rv = "UserRed",
        r = "UserBlue",
        rm = "UserBlue",
        s = "UserMagenta",
        S = "UserMagenta",
        [""] = "FelnMagenta",
        c = "UserYellow",
        ["!"] = "UserBlue",
        t = "UserBlue",
    },
}

local icons = {
    locker = "", -- #f023
    page = "☰", -- 2630
    line_number = "", -- e0a1
    connected = "", -- f817
    dos = "", -- e70f
    unix = "", -- f17c
    mac = "", -- f179
    mathematical_L = "𝑳",
    vertical_bar = "┃",
    vertical_bar_thin = "│",
    left = "",
    right = "",
    block = "█",
    left_filled = "",
    right_filled = "",
    slant_left = "",
    slant_left_thin = "",
    slant_right = "",
    slant_right_thin = "",
    slant_left_2 = "",
    slant_left_2_thin = "",
    slant_right_2 = "",
    slant_right_2_thin = "",
    left_rounded = "",
    left_rounded_thin = "",
    right_rounded = "",
    right_rounded_thin = "",
    circle = "●",
}

---Get the number of diagnostic messages for the provided severity
---@param str string [ERROR | WARN | INFO | HINT]
---@return string
local function get_diag(str)
    local diagnostics = vim.diagnostic.get(0, {
        severity = vim.diagnostic.severity[str],
    })
    local count = #diagnostics

    return (count > 0) and "" .. count or ""
end

---Get highlight group from vi mode
---@return string
local function vi_mode_hl()
    return vi.colors[vim.fn.mode()] or "UserSLViBlack"
end

---Get sep highlight group from vi mode
local function vi_sep_hl()
    return vi.sep[vim.fn.mode()] or "UserSLBlack"
end

---Get the path of the file relative to the cwd
---@return string
local function file_info()
    local list = {}
    if vim.bo.readonly then
        table.insert(list, "🔒")
    end

    if vim.bo.modified then
        table.insert(list, "●")
    end

    table.insert(list, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:."))

    return table.concat(list, " ")
end

-- Create a table that contians every status line commonent
local c = {
    vimode = {
        provider = function()
            return fmt(" %s ", vi.text[vim.fn.mode()])
        end,
        hl = vi_mode_hl,
        right_sep = {
            str = " ",
            hl = vi_sep_hl,
        },
    },
    git = {
        branch = {
            provider = "git_branch",
            icon = " ",
            hl = "UserSLGitBranch",
            right_sep = {
                str = " ",
                hl = "UserSLGitBranch",
            },
            enabled = function()
                return vim.b.gitsigns_status_dict ~= nil
            end,
        },
        add = {
            provider = "git_diff_added",
            icon = icons.circle,
            hl = "UserSLGitAdd",
            right_sep = {
                str = " ",
                hl = "UserSLGitAdd",
            },
        },
        change = {
            provider = "git_diff_changed",
            icon = icons.circle,
            hl = "UserSLGitChange",
            right_sep = {
                str = " ",
                hl = "UserSLGitBranch",
            },
        },
        remove = {
            provider = "git_diff_removed",
            icon = icons.circle,
            hl = "UserSLGitRemove",
            right_sep = {
                str = " ",
                hl = "UserSLGitBranch",
            },
        },
    },
    file = {
        type = {
            provider = function()
                return fmt(" %s ", vim.bo.filetype:upper())
            end,
            hl = "UserSLAlt",
        },
        info = {
            provider = {
                name = "file_info",
                opts = {
                    type = "relative",
                },
            },
            hl = "UserSLAlt",
            left_sep = {
                str = " ",
                hl = "UserSLAltSep",
            },
            right_sep = {
                str = "█",
                hl = "UserSLAltBg",
            },
        },
        encode = {
            provider = function()
                local os = icons[vim.bo.fileformat] or ""
                return fmt(" %s %s ", os, vim.bo.fileencoding)
            end,
            hl = "UserSLEncode",
            left_sep = {
                str = icons.left_filled,
                hl = "UserSLAltSep",
            },
        },
        winbar = {
            provider = file_info,
            hl = "Comment",
        },
    },
    cursor = {
        position = {
            provider = function()
                -- TODO: What about 4+ diget line numbers?
                return fmt(" %d:%d ", unpack(vim.api.nvim_win_get_cursor(0)))
                    .. require("feline.providers.cursor").line_percentage()
                    .. " "
            end,
            hl = vi_mode_hl,
            left_sep = {
                str = icons.left_filled,
                hl = vi_sep_hl,
            },
        },
    },
    default = { -- needed to pass the parent StatusLine hl group to right hand side
        provider = "",
        hl = "StatusLine",
    },
    lsp = {
        error = {
            provider = function()
                return get_diag("ERROR")
            end,
            hl = "UserSLError",
            left_sep = {
                str = "",
                hl = "UserSLErrorBg",
                always_visible = true,
            },
            right_sep = {
                str = "",
                hl = "UserSLWarnError",
                always_visible = true,
            },
        },
        warn = {
            provider = function()
                return get_diag("WARN")
            end,
            hl = "UserSLWarn",
            right_sep = {
                str = "",
                hl = "UserSLInfoWarn",
                always_visible = true,
            },
        },
        info = {
            provider = function()
                return get_diag("INFO")
            end,
            hl = "UserSLInfo",
            right_sep = {
                str = "",
                hl = "UserSLHintInfo",
                always_visible = true,
            },
        },
        hint = {
            provider = function()
                return get_diag("HINT")
            end,
            hl = "UserSLHint",
            right_sep = {
                str = "",
                hl = "UserSLFtHint",
                always_visible = true,
            },
        },
    },
    inactive = {
        fileinfo = {
            provider = "file_info",
            hl = "StatusLine",
        },
        position = {
            provider = "position",
            hl = "StatusLine",
        },
    },
}

local M = {}

M.active = {
    { -- left
        c.vimode,
        c.git.branch,
        c.git.add,
        c.git.change,
        c.git.remove,
        c.file.info,
        c.default, -- must be last
    },
    { -- right
        c.lsp.error,
        c.lsp.warn,
        c.lsp.info,
        c.lsp.hint,
        c.file.type,
        c.file.encode,
        c.cursor.position,
    },
}

M.inactive = {
    { c.inactive.fileinfo }, -- left
    { c.inactive.position }, -- right
}

return M
