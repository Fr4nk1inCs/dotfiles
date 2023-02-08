-- Breakpoint Icon Setting
vim.api.nvim_set_hl(0, "DapBreakpoint", {
    ctermbg = 0,
    fg = "#993939",
    bg = "#8a5151",
})
vim.api.nvim_set_hl(0, "DapLine", {
    ctermbg = 0,
    bg = "#8a5151",
})
vim.api.nvim_set_hl(0, "DapLogPoint", {
    ctermbg = 0,
    fg = "#61afef",
    bg = "#8a5151",
})
vim.api.nvim_set_hl(0, "DapStopped", {
    ctermbg = 0,
    fg = "#98c379",
    bg = "#515c8a",
})
vim.api.nvim_set_hl(0, "DapStoppedLine", {
    ctermbg = 0,
    bg = "#515c8a",
})

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DapBreakpoint",
    linehl = "DapLine",
    numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
    text = "ﳁ",
    texthl = "DapBreakpoint",
    linehl = "DapLine",
    numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "DapBreakpoint",
    linehl = "DapLine",
    numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapLogPoint", {
    text = "",
    texthl = "DapLogPoint",
    linehl = "DapLine",
    numhl = "DapLogPoint",
})
vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "DapStopped",
    linehl = "DapStoppedLine",
    numhl = "DapStopped",
})
