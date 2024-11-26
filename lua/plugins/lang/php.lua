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
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                intelephense = {
                    init_options = {
                        globalStoragePath = (os.getenv("XDG_DATA_HOME") or "") .. "/intelephense",
                        licenceKey = (os.getenv("XDG_CONFIG_HOME") or "") .. "/intelephense/licence.txt",
                    },
                },
                -- phpactor = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                php = { "php_cs_fixer" },
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
