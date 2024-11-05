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
                -- "phpactor",
                "phpstan",
                "php-cs-fixer",
                "easy-coding-standard",
                "twiggy-language-server",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                intelephense = {
                    init_options = {
                        globalStoragePath = os.getenv("XDG_DATA_HOME") .. "/intelephense",
                        licenceKey = os.getenv("XDG_CONFIG_HOME") .. "/intelephense/licence.txt",
                    },
                },
                -- phpactor = {},
                twiggy_language_server = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                php = { "easy-coding-standard" },
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
}
