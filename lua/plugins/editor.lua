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
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require("illuminate").configure()
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()

            local ft = require("Comment.ft")
            ft.set("hcl", ft.get("terraform"))
        end,
        keys = {
            {
                "<leader>/",
                "<Plug>(comment_toggle_linewise_visual)",
                mode = "v",
                { desc = "[/] Comment current selection", mode = "v" },
            },
            { "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "[/] Comment current line" } },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = { char = "│" },
            scope = { enabled = false },
        },
        exclude = {
            language = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
        },
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function(_, opts)
            require("mini.indentscope").setup({
                -- symbol = "▏",
                symbol = "│",
                options = { try_as_border = true },
                draw = {
                    animation = require("mini.indentscope").gen_animation.none(),
                },
            })
        end,
    },

    {
        "windwp/nvim-spectre",
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                end,
                desc = "Replace in files (Spectre)",
            },
        },
    },

    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
    },

    {
        "tpope/vim-abolish",
        lazy = false,
    },

    {
        "tpope/vim-sleuth",
        event = "VeryLazy",
    },

    {
        "mbbill/undotree",
        event = "VeryLazy",
        keys = {
            {
                "<leader>u",
                "<cmd>UndotreeToggle<cr>",
                desc = "Toggle undo tree",
            },
        },
    },
}
