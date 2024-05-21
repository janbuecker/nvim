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
        "tpope/vim-abolish",
        event = "BufReadPost",
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" },
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFileHistory" },
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
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {
            autotag = {
                filetypes = {
                    "html",
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                    "svelte",
                    "vue",
                    "tsx",
                    "jsx",
                    "rescript",
                    "xml",
                    "php",
                    "markdown",
                    "astro",
                    "glimmer",
                    "handlebars",
                    "hbs",
                    "templ",
                    "gotmpl",
                },
            },
        },
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<leader>g",  function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle harpoon menu" },
            { "<leader>gf", function() require("harpoon.mark").add_file() end, desc = "[Harpoon] Add file" },
            { "<leader>1",  function() require("harpoon.ui").nav_file(1) end, desc = "[Harpoon] Navigate to file 1" },
            { "<leader>2",  function() require("harpoon.ui").nav_file(2) end, desc = "[Harpoon] Navigate to file 2" },
            { "<leader>3",  function() require("harpoon.ui").nav_file(3) end, desc = "[Harpoon] Navigate to file 3" },
            { "<leader>4",  function() require("harpoon.ui").nav_file(4) end, desc = "[Harpoon] Navigate to file 4" },
            { "<leader>5",  function() require("harpoon.ui").nav_file(5) end, desc = "[Harpoon] Navigate to file 5" },
        },
    },
}
