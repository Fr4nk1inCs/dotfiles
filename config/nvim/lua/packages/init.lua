local status, packer = pcall(require, "packer")
if not status then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Plenary
    use("nvim-lua/plenary.nvim")

    -- Web Devicons
    use("kyazdani42/nvim-web-devicons")

    -- Theme NightFox
    use({
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                },
                palettes = {
                    all = {
                        -- Make the background of statusline and bufferline transparent
                        bg0 = "NONE",
                    },
                },
            })
            -- setup must be called before loading
            vim.cmd("colorscheme nordfox")
        end,
    })

    -- Auto close brackets
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "tex" },
            })
        end,
    })

    -- use nvim-tree
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    mappings = {
                        list = {
                            {
                                key = "u",
                                action = "dir_up",
                            },
                        },
                    },
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                diagnostics = {
                    enable = true,
                },
            })

            local map = require("helper.mapping").map
            map("n", "<leader>nt", ":NvimTreeToggle<CR>", nil, "Toggle NvimTree")

            local function open_dir(data)
                -- buffer is a directory
                local directory = vim.fn.isdirectory(data.file) == 1
                if not directory then
                    return
                end
                -- create a new, empty buffer
                vim.cmd.enew()

                -- wipe the directory buffer
                vim.cmd.bw(data.buf)

                -- change to the directory
                vim.cmd.cd(data.file)

                -- open the tree
                require("nvim-tree.api").tree.open()
            end
            vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_dir })
        end,
    })

    -- Statusline
    use({
        "feline-nvim/feline.nvim",
        config = function()
            local components = require("ui.status-line")
            require("feline").setup({
                components = {
                    active = components.active,
                    inactive = components.inactive,
                },
                highlight_reset_triggers = {},
                force_inactive = {
                    filetypes = {
                        "NvimTree",
                        "packer",
                        "dap-repl",
                        "dapui_scopes",
                        "dapui_stacks",
                        "dapui_watches",
                        "dapui_repl",
                        "LspTrouble",
                        "qf",
                        "help",
                    },
                    buftypes = { "terminal" },
                    bufnames = {},
                },
                disable = {
                    filetypes = { "alpha", "dashboard", "startify" },
                },
            })
            vim.opt.laststatus = 3 -- use global statusline
        end,
    })

    -- Bufferline
    use({
        "romgrk/barbar.nvim",
        config = function()
            -- setup
            require("bufferline").setup({
                -- Enable/disable animations
                animation = true,
                -- Enable/disable auto-hiding the tab bar when there is a single buffer
                auto_hide = true,
                -- Enable/disable current/total tabpages indicator (top right corner)
                tabpages = true,
                -- Enable/disable close button
                closable = true,
                -- Enables/disable clickable tabs
                --  - left-click: go to buffer
                --  - middle-click: delete buffer
                clickable = true,
                icons = "both",
                -- Configure icons on the bufferline.
                icon_separator_active = "▎",
                icon_separator_inactive = "▎",
                icon_close_tab = "",
            })

            -- mapping
            local map = require("helper.mapping").map
            -- Move to previous/next
            map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", nil, "Go to previous buffer")
            map("n", "<A-.>", "<Cmd>BufferNext<CR>", nil, "Go to next buffer")
            -- Re-order to previous/next
            map("n", "<A-[>", "<Cmd>BufferMovePrevious<CR>", nil, "Move current buffer to previous position")
            map("n", "<A-]>", "<Cmd>BufferMoveNext<CR>", nil, "Move current buffer to next position")
            -- Goto buffer in position...
            map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", nil, "Go to buffer in position 1")
            map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", nil, "Go to buffer in position 2")
            map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", nil, "Go to buffer in position 3")
            map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", nil, "Go to buffer in position 4")
            map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", nil, "Go to buffer in position 5")
            map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", nil, "Go to buffer in position 6")
            map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", nil, "Go to buffer in position 7")
            map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", nil, "Go to buffer in position 8")
            map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", nil, "Go to buffer in position 9")
            map("n", "<A-0>", "<Cmd>BufferLast<CR>", nil, "Go to last buffer")
            -- Pin/unpin buffer
            map("n", "<A-p>", "<Cmd>BufferPin<CR>", nil, "Pin current buffer")
            -- Close buffer
            map("n", "<A-c>", "<Cmd>BufferClose<CR>", nil, "Close current buffer")
            -- Wipeout buffer
            --                 :BufferWipeout
            -- Close commands
            --                 :BufferCloseAllButCurrent
            --                 :BufferCloseAllButPinned
            --                 :BufferCloseAllButCurrentOrPinned
            --                 :BufferCloseBuffersLeft
            --                 :BufferCloseBuffersRight
            -- Magic buffer-picking mode
            map("n", "<C-p>", "<Cmd>BufferPick<CR>", nil, "Open buffer picker")
            -- Sort automatically by...
            map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", nil, "Sort buffers by buffer number")
            map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", nil, "Sort buffers by directory")
            map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", nil, "Sort buffers by language")
            map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", nil, "Sort buffers by window number")

            -- capatibility with nvim-tree
            -- local nvim_tree_events = require("nvim-tree.events")
            -- local bufferline_api = require("bufferline.api")
            --
            -- local function get_tree_size()
            --     return require("nvim-tree.view").View.width
            -- end
            --
            -- nvim_tree_events.subscribe("TreeOpen", function()
            --     bufferline_api.set_offset(get_tree_size())
            -- end)
            --
            -- nvim_tree_events.subscribe("Resize", function()
            --     bufferline_api.set_offset(get_tree_size())
            -- end)
            --
            -- nvim_tree_events.subscribe("TreeClose", function()
            --     bufferline_api.set_offset(0)
            -- end)
        end,
        -- requires = { "kyazdani42/nvim-tree.lua" },
    })

    -- LSP Config
    use({
        "williamboman/mason-lspconfig.nvim",
        requires = {
            {
                "neovim/nvim-lspconfig",
                config = function()
                    ---- Diagnostic hints
                    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
                    for type, icon in pairs(signs) do
                        local hl = "DiagnosticSign" .. type
                        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                    end
                end,
            },
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup({
                        ui = {
                            border = "rounded",
                            icons = {
                                package_installed = "✓",
                                package_pending = "➜",
                                package_uninstalled = "✗",
                            },
                        },
                    })
                end,
            },
            {
                "glepnir/lspsaga.nvim",
                branch = "main",
                config = function()
                    require("lspsaga").setup({
                        outline = {
                            keys = {
                                jump = "<CR>",
                            },
                        },
                        symbol_in_winbar = {
                            enable = true,
                            separator = "  ",
                        },
                        ui = {
                            border = "rounded",
                            colors = {
                                normal_bg = "NONE",
                                title_bg = "NONE",
                            },
                        },
                    })
                end,
            },
            {
                "ray-x/lsp_signature.nvim",
                config = function()
                    require("lsp_signature").setup({
                        bind = true,
                        handler_opts = {
                            border = "rounded",
                        },
                        hint_prefix = "> ",
                        toggle_key = "<C-s>",
                    })
                end,
            },
            {
                "simrat39/rust-tools.nvim",
            },
            {
                "hrsh7th/cmp-nvim-lsp",
            },
        },
        config = function()
            local on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Keymaps
                local bufopts = {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                }
                local map = require("helper.mapping").map
                -- LSP Built-in
                map("n", "gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, bufopts, "Go to definition")
                map("n", "gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
                map("n", "<space>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
                map("n", "gR", vim.lsp.buf.references, bufopts, "Find references")
                -- LSP Saga
                -- finder
                map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", bufopts, "Open lspsaga finder")
                -- code action
                map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts, "Show code actions")
                map(
                    "v",
                    "<leader>ca",
                    "<cmd><C-U>Lspsaga range_code_action<CR>",
                    bufopts,
                    "Show code actions for range"
                )
                -- hover doc
                map("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts, "Show hover doc")
                -- scroll down hover doc or scroll in definition preview
                map("n", "<C-f>", function()
                    require("lspsaga.action").smart_scroll_with_saga(1)
                end, bufopts, "Scroll down hover doc or scroll in definition preview")
                -- scroll up hover doc
                map("n", "<C-b>", function()
                    require("lspsaga.action").smart_scroll_with_saga(-1)
                end, bufopts, "Scroll up hover doc or scroll in definition preview")
                -- rename
                map("n", "gr", "<cmd>Lspsaga rename<CR>", bufopts, "Rename symbol")
                -- preview definition
                map("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", bufopts, "Preview definition")
                -- diagnostics
                map("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts, "Show line diagnostics")
                map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufopts, "Show cursor diagnostics")
                map("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts, "Goto previous diagnostic")
                map("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts, "Goto next diagnostic")
                map("n", "[E", function()
                    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
                end, bufopts, "Goto previous error")
                map("n", "]E", function()
                    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
                end, bufopts, "Goto next error")
                -- Outline
                map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", nil, "Toggle LSP Outline")
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local clangd_capabilities = capabilities
            clangd_capabilities.textDocument.semanticHighlighting = true
            clangd_capabilities.offsetEncoding = "utf-8"

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = {
                    "bashls",
                    "sumneko_lua",
                    "vimls",
                    "jsonls",
                    "pyright",
                    "clangd",
                    "texlab",
                },
                automatic_installation = true,
            })
            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        on_attach = on_attach,
                        capabilities = clangd_capabilities,
                    })
                end,
                ["sumneko_lua"] = function()
                    require("lspconfig").sumneko_lua.setup({
                        on_attach = on_attach,
                        capabilities = clangd_capabilities,
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace",
                                },
                            },
                        },
                    })
                end,
                ["texlab"] = function()
                    require("lspconfig").texlab.setup({
                        on_attach = on_attach,
                        capabilities = vim.lsp.protocol.make_client_capabilities(),
                        filetypes = { "tex", "plaintex", "bib" },
                        settings = {
                            texlab = {
                                build = {
                                    executable = "xelatex",
                                    args = {
                                        "-synctex=1",
                                        "-interaction=nonstopmode",
                                        "%f",
                                    },
                                    onSave = true,
                                    forwardSearchAfter = true,
                                },
                                forwardSearch = {
                                    executable = "zathura",
                                    args = {
                                        "--synctex-forward",
                                        "%l:1:%f",
                                        "%p",
                                    },
                                    onSave = true,
                                },
                                chktex = {
                                    onOpenAndSave = true,
                                    onEdit = true,
                                },
                            },
                        },
                    })
                end,
            })
            require("rust-tools").setup({
                server = {
                    on_attach = on_attach,
                },
            })
        end,
    })

    -- Show LSP status
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                text = {
                    spinner = "dots",
                },
                window = {
                    blend = 0,
                    border = "rounded",
                },
            })
        end,
    })

    -- Completion
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-omni",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    local types = require("luasnip.util.types")
                    require("luasnip").config.setup({
                        update_events = "TextChanged,TextChangedI",
                        enable_autosnippets = true,
                        ext_opts = {
                            [types.choiceNode] = {
                                active = {
                                    virt_text = { { "<- Choice Here (Prev: <C-,>, Next: <C-.>)", "SpecialComment" } },
                                },
                            },
                        },
                        store_selection_keys = "<Tab>",
                    })

                    require("luasnip.loaders.from_lua").lazy_load()

                    local map = require("helper.mapping").map
                    map("i", "<C-.>", "<Plug>luasnip-next-choice", {}, "Select next choiceNode.")
                    map("s", "<C-.>", "<Plug>luasnip-next-choice", {}, "Select next choiceNode.")
                    map("i", "<C-,>", "<Plug>luasnip-prev-choice", {}, "Select previous choiceNode.")
                    map("s", "<C-,>", "<Plug>luasnip-prev-choice", {}, "Select previous choiceNode.")
                end,
            },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            local select_next = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end
            local select_prev = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end

            cmp.setup({
                -- disable completion in comments
                enabled = function()
                    local context = require("cmp.config.context")
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_treesitter_capture("Comment")
                    end
                end,
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                -- use rounded borders
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<Tab>"] = cmp.mapping(select_next, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s" }),
                }),
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    }),
                },
            })
        end,
    })

    -- Debugger Adapter
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            -- set breakpoint styles
            require("ui.dap")

            local dap = require("dap")
            local dapui = require("dapui")

            -- Setup d
            dapui.setup({
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "<C-o>",
                    remove = "<C-d>",
                    edit = "<C-e>",
                    repl = "<C-r>",
                    toggle = "<C-t>",
                },
            })

            -- Keymaps
            local map = require("helper.mapping").map
            local opts = { silent = true }
            map({ "n", "i", "v" }, "<F10>", dap.step_over, opts, "Step over")
            map({ "n", "i", "v" }, "<F11>", dap.step_into, opts, "Step into")
            map({ "n", "i", "v" }, "<F12>", dap.step_out, opts, "Step out")
            map("n", "bp", dap.toggle_breakpoint, opts, "Toggle breakpoint")
            map("n", "bc", function()
                return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, opts, "Set condition breakpoint")
            map("n", "bl", function()
                return dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, opts, "Set log point")
            map("n", "<leader>ro", dap.repl.open, opts, "Open REPL")
            map("n", "<leader>rl", dap.run_last, opts, "Run last")
            map({ "n", "i", "v" }, "<F5>", function()
                dapui.open({})
                return dap.continue()
            end, opts, "Continue or start debugging")
            map({ "n", "i", "v" }, "<F6>", function()
                dapui.close({})
                dap.repl.close()
                return dap.terminate()
            end, opts, "Terminate debugging")

            -- set language specific debuggers
            require("languages.debuggers")
        end,
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({
                commented = true,
                all_references = true,
                highlight_new_as_changed = true,
            })
        end,
    })

    -- Neovim Lua Development
    use({
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    })

    -- Null-ls
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local formatting = null_ls.builtins.formatting

            null_ls.setup({
                sources = {
                    formatting.autopep8,
                    formatting.stylua,
                    formatting.shfmt,
                    formatting.clang_format.with({
                        extra_args = { "-style=file" },
                        prefer_local = "/usr/loacl/bin/clang-format",
                    }),
                    formatting.latexindent,
                    formatting.prettier,
                    formatting.rustfmt,
                    formatting.xmllint,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                                -- vim.lsp.buf.formatting_sync()
                            end,
                        })
                    end
                end,
                border = "rounded",
            })

            local map = require("helper.mapping").map
            map("n", "<A-f>", function()
                return vim.lsp.buf.format({ async = false })
            end, nil, "Format document")
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Code Runner
    use({
        "CRAG666/code_runner.nvim",
        config = function()
            require("code_runner").setup({
                -- put here the commands by filetype
                filetype = {
                    python = "python3 -u '$dir/$fileName'",
                    c = "cd '$dir' && clang -O2 -Wall -o '$fileNameWithoutExt' '$fileName' && '$dir/$fileNameWithoutExt'",
                    cpp = "cd '$dir' && clang++ -O2 -Wall -o '$fileNameWithoutExt' '$fileName' && '$dir/$fileNameWithoutExt'",
                    sh = "$dir/$fileName",
                    bash = "bash $dir/$fileName",
                    zsh = "zsh $dir/$fileName",
                },
                startinsert = true,
                mode = "float",
                float = {
                    border = "rounded",
                },
            })

            local map = require("helper.mapping").map

            map("n", "<leader>rc", ":RunCode<CR>", nil, "Run file or project")
            map("n", "<leader>rf", ":RunFile<CR>", nil, "Run file")
            map("n", "<leader>rt", ":RunFile tab<CR>", nil, "Run file in a new tab")
            map("n", "<leader>rp", ":RunProject<CR>", nil, "Run project")
            map("n", "<leader>rc", ":RunClose<CR>", nil, "Close runner")
            map("n", "<leader>crf", ":CRFiletype<CR>", nil, "Open json with supported files")
            map("n", "<leader>crp", ":CRProjects<CR>", nil, "Open json with list of projects")
        end,
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all"
                ensure_installed = { "c", "cpp", "lua", "rust", "jsonc", "python", "markdown", "latex", "vim" },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                auto_install = true,
                -- List of parsers to ignore installing (for "all")
                ignore_install = { "javascript" },
                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = {
                        "tex",
                        "latex",
                    },

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        -- Set to false if you have an `updatetime` of ~100.
                        clear_on_cursor_move = true,
                    },
                    highlight_current_scope = { enable = false },
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_next_usage = "<a-*>",
                            goto_previous_usage = "<a-#>",
                        },
                    },
                },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    disable = {},
                },
            })
        end,
        requires = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "p00f/nvim-ts-rainbow",
        },
    })

    -- Color Highlight
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "*",
                css = {
                    css = true,
                    css_fn = true,
                },
            }, {})
        end,
    })

    -- Jsonc Support
    use("kevinoid/vim-jsonc") -- json with comment support

    -- Markdown Support
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_browser = "/usr/bin/surf"
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_open_ip = "127.0.0.1"
            vim.g.mkdp_port = 8080
            vim.g.mkdp_echo_preview_url = 0
            vim.g.mkdp_theme = "light"
            -- g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/Typora/themes/vue.css"

            local map = require("helper.mapping").map
            map("n", "<leader>mdp", "<cmd>MarkdownPreview<CR>", nil, "Open markdown preview.")
            map("n", "<leader>mdt", "<cmd>MarkdownPreviewToggle<CR>", nil, "Toggle markdown preview.")
        end,
    })
    use("godlygeek/tabular")
    use({
        "preservim/vim-markdown",
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_folding_level = 2
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_follow_anchor = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
        end,
    })
    use({
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup({
                pager = true,
            })
        end,
    })

    -- Notify
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#000000",
                stages = "fade",
                on_open = function(win)
                    vim.api.nvim_win_set_option(win, "wrap", true)
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                end,
            })
            vim.notify = require("notify")
        end,
    })

    -- Startup
    use({
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("ui.startup"))
        end,
    })

    -- Github Copilot
    use({
        "github/copilot.vim",
        config = function()
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_filetypes = {
                ["dap-repl"] = false,
                ["dapui_watches"] = false,
                ["dapui_stacks"] = false,
                ["dapui_breakpoints"] = false,
                ["dapui_scopes"] = false,
            }
        end,
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        config = function()
            local telescope = require("telescope")
            local fb_actions = telescope.extensions.file_browser.actions
            -- setup telescope
            telescope.setup({
                extensions = {
                    file_browser = {
                        hidden = true,
                        mappings = {
                            ["i"] = {
                                -- Create using Ctrl-n
                                ["<C-n>"] = fb_actions.create,
                                -- Copy and move using Ctrl-c/v
                                ["<C-c>"] = fb_actions.copy,
                                ["<C-v>"] = fb_actions.move,
                                -- Rename using Ctrl-r/F2
                                ["<C-r>"] = fb_actions.rename,
                                ["<F2>"] = fb_actions.rename,
                                -- Delete using Ctrl-d
                                ["<C-d>"] = fb_actions.remove,
                                -- Ctrl-a to toggle all
                                ["<C-a>"] = fb_actions.toggle_all,
                            },
                        },
                    },
                },
            })
            -- setup extensions
            telescope.load_extension("lazygit")
            telescope.load_extension("notify")
            telescope.load_extension("file_browser")
            -- keymapping
            local map = require("helper.mapping").map
            map("n", "<leader>ft", ":Telescope<CR>", nil, "Open Telescope")
            map("n", "<leader>ff", ":Telescope find_files<CR>", nil, "Open Telescope find_files")
            map("n", "<leader>fb", ":Telescope file_browser<CR>", nil, "Open Telescope file_browser")
            map("n", "<leader>fg", ":Telescope live_grep<CR>", nil, "Open Telescope live_grep")
            map("n", "<leader>fh", ":Telescope help_tags<CR>", nil, "Open Telescope help_tags")
            map("n", "<leader>fm", ":Telescope keymaps<CR>", nil, "Open keymap help")
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "rcarriga/nvim-notify",
        },
    })

    -- Terminal
    use({
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.25
                    end
                end,
                open_mapping = [[<c-\>]],
                direction = "float",
                float_opts = {
                    border = "curved",
                    width = function(_)
                        return math.floor(vim.o.columns * 0.8)
                    end,
                    height = function(_)
                        return math.floor(vim.o.lines * 0.8)
                    end,
                },
                winbar = {
                    enabled = true,
                },
            })
        end,
    })

    -- Comment
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- Image Preview
    use({
        "edluffy/hologram.nvim",
        -- config = function()
        --     require("hologram").setup({
        --         auto_display = true,
        --     })
        -- end,
    })
    use({
        "samodostal/image.nvim",
        requires = { "m00qek/baleia.nvim", tag = "v1.2.0" },
        config = function()
            require("image").setup({
                render = {
                    min_padding = 5,
                    show_label = true,
                    use_dither = true,
                    foreground_color = true,
                    background_color = true,
                },
                events = {
                    update_on_nvim_resize = true,
                },
            })
        end,
    })

    -- Git
    use({
        "kdheepak/lazygit.nvim",
        config = function()
            local map = require("helper.mapping").map
            map("n", "<leader>gg", ":LazyGit<CR>", { silent = true }, "Open lazygit")
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                preview_config = {
                    border = "rounded",
                },
                on_attach = function(_)
                    local gs = package.loaded.gitsigns
                    local map = require("helper.mapping").map

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true }, "Next hunk")

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true }, "Previous hunk")

                    -- Actions
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", {}, "Stage hunk")
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", {}, "Reset hunk")
                    map("n", "<leader>hS", gs.stage_buffer, {}, "Stage buffer")
                    map("n", "<leader>hu", gs.undo_stage_hunk, {}, "Undo stage hunk")
                    map("n", "<leader>hR", gs.reset_buffer, {}, "Reset buffer")
                    map("n", "<leader>hp", gs.preview_hunk, {}, "Preview hunk")
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end, {}, "Blame line")
                    map("n", "<leader>tb", gs.toggle_current_line_blame, {}, "Toggle current line blame")
                    map("n", "<leader>hd", gs.diffthis, {}, "Diff this")
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end, {}, "Diff this (with ~)")
                    map("n", "<leader>td", gs.toggle_deleted, {}, "Toggle deleted")

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {}, "Select hunk")
                end,
            })
        end,
    })

    -- Indent Line
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                char = "▎",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    })

    -- Leap
    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    })

    -- Which Key
    use({
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                window = {
                    border = "rounded",
                },
            })
        end,
    })

    -- Wakatime
    use("wakatime/vim-wakatime")
end)
