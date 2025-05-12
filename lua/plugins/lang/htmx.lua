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
        "stevearc/conform.nvim",
        opts = function(_, opts)
            -- opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {})
            opts.formatters_by_ft.templ = { "templ" }
        end,
    },
}
