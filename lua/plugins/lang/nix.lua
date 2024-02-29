return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "nix",
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            if type(opts.formatters_by_ft) == "table" then
                opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                    nix = { "nixfmt" },
                })
            end
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = function(_, opts)
            opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft, {
                nix = { "nix" },
            })
        end,
    },
}
