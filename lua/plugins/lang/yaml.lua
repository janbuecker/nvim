local Util = require("util")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "yaml",
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "yaml-language-server",
                "yamllint",
                "yamlfix",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/schemastore.nvim",
        },
        opts = function(_, opts)
            opts.servers = vim.tbl_deep_extend("force", opts.servers, {
                yamlls = {
                    capabilities = {
                        server_compatibilities = {
                            documentFormattingProvider = true,
                        },
                        textDocument = {
                            foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            },
                        },
                    },
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = {
                                enable = true,
                            },
                            validate = true,
                            schemaStore = {
                                -- Must disable built-in schemaStore support to use
                                -- schemas from SchemaStore.nvim plugin
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },
            })

            opts.setup = vim.tbl_deep_extend("force", opts.setup, {
                yamlls = function()
                    Util.on_attach(function(client, _)
                        if client.name == "yamlls" then
                            client.server_capabilities.documentFormattingProvider = true
                        end
                    end)
                end,
            })
        end,
    },
}
