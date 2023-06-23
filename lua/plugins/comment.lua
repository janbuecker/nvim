return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()

        local ft = require("Comment.ft")
        ft.set("hcl", ft.get("terraform"))
    end,
    keys = {
        {
            "<leader>/",
            "<Plug>(comment_toggle_linewise_visual)",
            mode = "v",
            { desc = "[/] Comment current selection", mode = "v" },
        },
        { "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "[/] Comment current line" } },
    },
}
