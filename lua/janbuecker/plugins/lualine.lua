local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = {
        options = {
            icons_enabled = false,
            theme = 'auto',
            component_separators = '|',
            section_separators = '',
        },
    }

}

return M
