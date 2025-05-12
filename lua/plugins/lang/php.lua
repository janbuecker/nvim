return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "php",
                "phpdoc",
                "twig",
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                php = { "php_cs_fixer" },
                twig = { "twig-cs-fixer", "ludtwig" },
            })

            opts.formatters.ludtwig = {
                command = "ludtwig",
                args = { "-f", "$FILENAME" },
                stdin = false,
            }
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = function(_, opts)
            opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft, {
                php = { "php", "phpstan" },
                twig = { "twig-cs-fixer" },
            })
        end,
    },
}
