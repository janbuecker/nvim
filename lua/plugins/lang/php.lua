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
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            if type(opts.sources) == "table" then
                local nls = require("null-ls")
                vim.list_extend(opts.sources, {
                    nls.builtins.formatting.phpcsfixer,
                    nls.builtins.diagnostics.phpstan,
                })
            end
        end,
    },
    {
        "nelsyeung/twig.vim",
    },
}
