local mappings = {}
-- Options
mappings.default_opts = {
    noremap = true,
    silent = true,
}
mappings.noremap_only_opts = {
    noremap = true,
}
mappings.silent_only_opts = {
    silent = true,
}

-- @brief Keymap Function
-- @note  For more information on keymaps, see:
--        [`vim.keymap.set()`](https://neovim.io/doc/user/lua.html#vim.keymap.set())
--        or `:help vim.keymap.set()`
-- @param `mode` {string|table} Mode short-name or `"!"` for `:map!`,
--               or empty string for `:map`. Table for list of
--               modes to create keymap for. Default is `"n"`.
-- @param `lhs`  {string} LHS of the mapping (the key).
-- @param `rhs`  {string|function} RHS of the mapping (the command).
--               Can also be a lua function to execute.
-- @param `opts` {table} A table of options to pass to `vim.keymap.set()`.
--               See [`opts`](https://neovim.io/doc/user/map.html#:map-arguments)
--               and [`additional`](https://neovim.io/doc/user/lua.html#vim.keymap.set()).
--               Note that `desc` can be passesd as the next parameter.
--               Default is `{noremap = true, silent = true}`.
-- @param `desc` {string} Description of the mapping. Defaults is `""`.
-- @return {nil}
-- Example:
-- ```lua
-- mappings.map("n", "key", "command", nil, nil)
-- mappings.map({"n", "v"}, "key", require("my_command").func, { silent = true }, "description")
-- ```
mappings.map = function(mode, lhs, rhs, opts, desc)
    mode = mode or "n"
    opts = opts or mappings.default_opts
    desc = desc or ""

    opts.desc = desc

    vim.keymap.set(mode, lhs, rhs, opts)
end

return mappings
