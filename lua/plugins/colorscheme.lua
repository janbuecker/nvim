return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        enabled = true,
        priority = 1000,
        opts = {
            transparent_background = true,
            integrations = {
                diffview = true,
                neotest = true,
                snacks = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin-macchiato")
        end,
    },
}
