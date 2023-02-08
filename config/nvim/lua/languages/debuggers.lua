-- DAP Configuration
local dap = require("dap")
-- Python
dap.adapters.python = {
    type = "executable",
    command = "/usr/bin/python",
    args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = "python",
        request = "launch",
        name = "Launch file",

        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
            else
                return "/usr/bin/python"
            end
        end,
        stopOnEntry = false,
        console = "integratedTerminal",
    },
}

-- C/C++/Rust
dap.adapters.cppdbg = function(cb, config)
    if config.preLaunchTask then
        vim.fn.system(config.preLaunchTask)
    end
    local adapter = {
        id = "cppdbg",
        type = "executable",
        command = "/home/fushen/.local/share/nvim/mason/bin/OpenDebugAD7",
    }
    cb(adapter)
end
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        preLaunchTask = "clang++ -O2 -fdiagnostics-color=always -g ${file} -o ${fileDirname}/${fileBasenameNoExtension}",
        program = "${fileDirname}/${fileBasenameNoExtension}",
        cwd = "${fileDirname}",
        stopOnEntry = false,
        console = "integratedTerminal",
        setupCommands = {
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
}
dap.configurations.c = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        preLaunchTask = "clang -O2 -fdiagnostics-color=always -g ${file} -o ${fileDirname}/${fileBasenameNoExtension}",
        program = "${fileDirname}/${fileBasenameNoExtension}",
        cwd = "${fileDirname}",
        stopOnEntry = false,
        console = "integratedTerminal",
        setupCommands = {
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
}
dap.configurations.rust = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = "${fileDirname}/${fileBasenameNoExtension}",
        cwd = "${fileDirname}",
        stopOnEntry = false,
        console = "integratedTerminal",
    },
    setupCommands = {
        {
            text = "-enable-pretty-printing",
            description = "enable pretty printing",
            ignoreFailures = false,
        },
    },
}
