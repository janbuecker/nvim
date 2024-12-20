return {
    {
        "mfussenegger/nvim-lint",
        lazy = false,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {},
            linters = {},
        },
        config = function(_, opts)
            require("lint").linters_by_ft = opts.linters_by_ft

            vim.api.nvim_create_autocmd(opts.events, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
