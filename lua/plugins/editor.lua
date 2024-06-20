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
        event = { "BufReadPre", "BufNewFile" },
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
}
