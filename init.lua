-- Options ============================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.colorcolumn = "120" -- Visually mark at 120 chars
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort" -- Set completeopt to have a better completion experience
vim.opt.cursorline = true -- Show cursor line
vim.opt.diffopt = "internal,filler,closeoff,linematch:60"
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.hlsearch = true -- Set highlight on search
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.laststatus = 3 -- Global statusline
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Make line numbers default
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.sidescrolloff = 8 -- minimal number of screen lines to keep left and right of the cursor.
vim.opt.signcolumn = "yes" -- Always display signcolumn
vim.opt.smartcase = true -- Smart case
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- disable swap files
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300 -- Decrease update time
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 100 -- Decrease update time
vim.opt.wrap = false -- Disable line wrap

vim.opt.spelllang:append("cjk") -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.whichwrap:append("<,>,[,],h,l")

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.list = true

vim.opt.splitkeep = "cursor"
vim.o.shortmess = "filnxtToOFWIcC"

vim.o.winborder = "single"

-- Plugins ============================================================
vim.pack.add({
    -- Treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    { src = "https://github.com/folke/ts-comments.nvim" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/b0o/schemastore.nvim" },
    { src = "https://github.com/gruntwork-io/terragrunt-ls" },

    -- DAP
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/leoluz/nvim-dap-go" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },

    -- Completion
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-cmdline" },
    { src = "https://codeberg.org/FelipeLema/cmp-async-path" },

    -- Collections
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },

    -- Editor
    { src = "https://github.com/dstein64/vim-startuptime" },
    { src = "https://github.com/tpope/vim-abolish" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
    { src = "https://github.com/chrisgrieser/nvim-rip-substitute" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/zbirenbaum/copilot.lua" },

    -- Lint / Formatting
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/varnishcache-friends/vim-varnish" },
    { src = "https://github.com/stevearc/conform.nvim" },

    -- Colorscheme
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
}, { load = true })

-- Colorscheme =======================================================
require("catppuccin").setup({ integrations = { snacks = true } })
vim.cmd.colorscheme("catppuccin-mocha")

-- Copilot Setup =====================================================
require("copilot").setup({
    panel = { enabled = false },
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = "<C-y>",
        },
    },
    filetypes = {
        ["rip-substitute"] = false,
        ["yaml"] = true,
        ["terraform"] = true,
    },
})

-- Setup with defaults ===============================================
require("flash").setup()
require("visual-whitespace").setup()
require("quicker").setup()
require("rip-substitute").setup({
    prefill = {
        normal = false,
    },
})

-- Keymaps ===========================================================
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end)
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end)

-- search/replace
vim.keymap.set({ "n", "x" }, "<leader>sr", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })
vim.keymap.set({ "n", "x" }, "<A-r>", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })
vim.keymap.set("v", "<C-r>", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })

-- quickfix
vim.keymap.set("n", "<C-q>", function() require("quicker").toggle() end, { desc = "Toggle quickfix" })

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })
