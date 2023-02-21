local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
        char = "┊",
        show_trailing_blankline_indent = false,
    },
}

return M
