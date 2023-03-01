local M = {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("illuminate").configure()
    end,
}

return M
