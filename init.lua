require("config.options")

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require("mini.deps").setup({ path = { package = path_package } })

-- colorscheme
MiniDeps.add({ source = "catppuccin/nvim" })
MiniDeps.now(function()
    require("catppuccin").setup({
        transparent_background = true,
        integrations = {
            diffview = true,
            neotest = true,
            snacks = true,
        },
    })
    vim.cmd.colorscheme("catppuccin-macchiato")
end)

require("plugins.snacks")
require("plugins.blink")
require("plugins.mason")
require("plugins.mini")
require("plugins.treesitter")
require("plugins.formatting")
require("plugins.aider")
require("plugins.dap")
require("plugins.linting")
require("plugins.terragrunt")
require("plugins.neotest")
require("plugins.editor")

require("config.autocmds")
require("config.keymaps")
