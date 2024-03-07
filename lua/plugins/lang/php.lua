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
                "phpstan",
                "php-cs-fixer",
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
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                php = { "phpcsfixer" },
            })

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
