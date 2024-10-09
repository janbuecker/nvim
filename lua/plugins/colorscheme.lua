return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        enabled = true,
        priority = 999,
        opts = {
            options = {
                transparent = true,
            },
        },
        config = function(_, opts)
            require("nightfox").setup(opts)
            vim.cmd("colorscheme nightfox")
        end,
    },
}
