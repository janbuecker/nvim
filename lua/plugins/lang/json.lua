return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "json",
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "jsonlint",
                "json-lsp",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/schemastore.nvim",
        },
        opts = {
            servers = {
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                    setup = {
                        commands = {
                            Format = {
                                function()
                                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                                end,
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                json = { "jq" },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = function(_, opts)
            opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft, {
                json = { "jsonlint" },
            })
        end,
    },
}
