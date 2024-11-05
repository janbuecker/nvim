return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
        init = function()
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_tab_fallback = ""
        end,
    },
    {
        "tpope/vim-abolish",
        event = "BufReadPost",
    },
    {
        "mbbill/undotree",
        cmd = {
            "UndotreeToggle",
        },
        keys = require("config.keymaps").undotree(),
    },
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggle",
            "DiffviewFileHistory",
        },
    },
    {
        "mcauley-penney/visual-whitespace.nvim",
        config = true,
        event = "BufReadPost",
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = true,
    },
    {
        "chrisgrieser/nvim-rip-substitute",
        cmd = "RipSubstitute",
        keys = require("config.keymaps").ripsubstitue(),
    },
    {
        "romgrk/barbar.nvim",
        enabled = false,
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            icons = {
                filetype = {
                    enabled = false,
                },
            },
        },
        version = "^1.0.0",
    },
}
