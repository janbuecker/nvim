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
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                yamlls = {
                    settings = {
                        yaml = {
                            hover = true,
                            completion = true,
                            validate = true,
                            schemaStore = {
                                enable = true,
                                url = "https://www.schemastore.org/api/json/catalog.json",
                            },
                            schemas = {
                                kubernetes = {
                                    "daemon.{yml,yaml}",
                                    "manager.{yml,yaml}",
                                    "restapi.{yml,yaml}",
                                    "role.{yml,yaml}",
                                    "role_binding.{yml,yaml}",
                                    "*onfigma*.{yml,yaml}",
                                    "*ngres*.{yml,yaml}",
                                    "*ecre*.{yml,yaml}",
                                    "*eployment*.{yml,yaml}",
                                    "*ervic*.{yml,yaml}",
                                    "kubectl-edit*.yaml",
                                },
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
            if type(opts.formatters_by_ft) == "table" then
                opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                    yaml = { "yamlfmt" },
                })
            end
        end,
    },
}
