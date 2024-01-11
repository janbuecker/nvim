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
            local ft = require("Comment.ft")
            ft.setup({
                pre_hook = function()
                    return vim.bo.commentstring
                end,
            })
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
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        opts = {},
        keys = {
            -- stylua: ignore start
            { "<leader>x", function() require("trouble").toggle(); end, desc = "Toggle trouble", },
            { "<C-x>", function() require("trouble").toggle(); end, desc = "Toggle trouble", },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics"); end, desc = "Toggle trouble with workspace diagnostics", },
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics"); end, desc = "Toggle trouble with document diagnostics", },
            { "<leader>xq", function() require("trouble").toggle("quickfix"); end, desc = "Toggle trouble with quickfix list", },
            { "<leader>xl", function() require("trouble").toggle("loclist"); end, desc = "Toggle trouble with LSP references", },
            { "gR", function() require("trouble").toggle("lsp_references"); end, desc = "Toggle trouble with loclist", },
            { "]x", function() require("trouble").next({skip_groups = true, jump = true}); end, desc = "Jump to next trouble item", },
            { "[x", function() require("trouble").previous({skip_groups = true, jump = true}); end, desc = "Jump to previous trouble item", },
            { "<C-q>", function() require("trouble").toggle("quickfix"); end, desc = "Jump to previous trouble item", },
            -- stylua: ignore end
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

    -- {
    --     "tpope/vim-sleuth",
    --     event = "VeryLazy",
    -- },
    --
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
