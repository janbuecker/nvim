return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.filetype.add({ extension = { tf = "terraform" } })

            vim.list_extend(opts.ensure_installed, {
                "hcl",
                "terraform",
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                terraform = { "terraform_fmt" },
                tf = { "terraform_fmt" },
                ["terraform-vars"] = { "terraform_fmt" },
                hcl = { "hcl" },
            })
        end,
    },
}
