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
    {
        "FabijanZulj/blame.nvim",
        event = "VeryLazy",
        config = function()
            require("blame").setup({
                format_fn = require("blame.formats.default_formats").date_message,
            })
        end,
        keys = require("config.keymaps").blame(),
    },
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
        },
    },
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        branch = "v0.6",
        opts = {},
    },
}
