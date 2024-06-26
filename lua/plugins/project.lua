local M = {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "pattern" },
            show_hidden = true,
        })
    end,
}

return M
