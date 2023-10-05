return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                efm = {
                    settings = {
                        rootMarkers = { ".git/" },
                        languages = {
                            lua = {
                                -- require("efmls-configs.formatters.stylua"),
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "efm",
            })
        end,
    },
    {
        "creativenull/efmls-configs-nvim",
    },
}
