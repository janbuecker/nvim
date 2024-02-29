return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "php",
                "phpdoc",
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "intelephense",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                intelephense = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            if type(opts.formatters_by_ft) == "table" then
                opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                    php = { "phpcsfixer" },
                })
            end

            opts.formatters = vim.tbl_deep_extend("force", opts.formatters, {
                phpcsfixer = {
                    command = "php-cs-fixer",
                    args = { "fix", "$FILENAME" },
                    stdin = false,
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = function(_, opts)
            opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft, {
                php = { "php", "phpstan" },
            })
        end,
    },
    {
        "nelsyeung/twig.vim",
    },
}
