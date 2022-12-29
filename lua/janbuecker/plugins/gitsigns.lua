local M = {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
    },
    keys = {
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "[G]it [P]review hunk" } },
        { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "[G]it [R]eset hunk" } },
    },
}

return M
