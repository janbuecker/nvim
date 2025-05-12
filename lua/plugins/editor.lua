return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            panel = { enabled = false },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<C-y>",
                },
            },
            filetypes = {
                ["rip-substitude"] = false,
                ["yaml"] = true,
                ["terraform"] = true,
            },
        },
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
        "mcauley-penney/visual-whitespace.nvim",
        config = true,
        keys = { "v", "V", "<C-v>" },
    },
    {
        "chrisgrieser/nvim-rip-substitute",
        cmd = "RipSubstitute",
        opts = {
            prefill = {
                normal = false,
            },
        },
        keys = require("config.keymaps").ripsubstitue(),
    },
    {
        "FabijanZulj/blame.nvim",
        event = "VeryLazy",
        opts = {},
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
        enabled = false,
        event = { "InsertEnter", "CmdlineEnter" },
        branch = "v0.6",
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        },
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    },
}
