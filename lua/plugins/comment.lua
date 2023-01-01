return {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
        { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", mode = "v", { desc = "[/] Comment current selection", mode = "v" } },
        { "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "[/] Comment current line" } },
    },
}
