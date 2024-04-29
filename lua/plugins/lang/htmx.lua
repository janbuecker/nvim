return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "html",
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "htmx-lsp",
                "html-lsp",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                htmx = {
                    filetypes = { "html", "templ" },
                },
                html = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            -- opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {})
            opts.formatters_by_ft.templ = { "templ" }
        end,
    },
}
