return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "hcl",
                "terraform",
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "terraform-ls",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                terraformls = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                terraform = { "terraform_fmt" },
                hcl = { "terragrunt_hclfmt" },
            })
        end,
    },
}
