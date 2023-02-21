return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
        require("mini.move").setup()
    end,
}
