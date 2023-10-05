return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        enabled = true,
        priority = 999,
        config = function()
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
