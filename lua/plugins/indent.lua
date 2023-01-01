local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = {
        char = '┊',
        show_trailing_blankline_indent = false,
    },
}

return M
