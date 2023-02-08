local set = vim.opt
local api = vim.api

set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
set.wrap = true
set.scrolloff = 5
set.fileencoding = "utf-8"
set.termguicolors = true

set.number = true
set.relativenumber = true
-- set.cursorline = true
-- set.cursorcolumn = true
set.colorcolumn = { "80", "120" }

set.hidden = true

set.mouse = "a"

set.fileencodings = { "ucs-bom", "utf-8", "GB18030", "gbk" }

set.clipboard:append("unnamedplus")
set.clipboard:append("unnamed")
set.whichwrap = "<,>,h,l,[,]"

set.conceallevel = 0

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Set Persistent Undo
set.undofile = true
set.undodir = vim.fn.expand("$HOME/.config/nvim/undo")
