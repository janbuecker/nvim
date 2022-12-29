local M = {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require('project_nvim').setup({
            -- lsp detection will get annoying with multiple langs in one project
            detection_methods = { "pattern" },
        })

        require('telescope').load_extension('projects')
    end,
    keys = {
        {"<leader>P", "<cmd>Telescope projects<CR>", { desc = "[P]rojects" }}
    }
}

return M
