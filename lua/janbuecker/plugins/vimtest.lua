local M = {
    "vim-test/vim-test",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "andythigpen/nvim-coverage",
    },
    keys = {
        -- Test mappings
        { "<leader>tt", ":TestNearest<CR>", { desc = "[T]est nearest" } },
        { "<leader>tl", ":TestLast<CR>", { desc = "[T]est [L]ast" } },
        { "<leader>tf", ":TestFile<CR>", { desc = "[T]est [F]ile" } },
        { "<leader>ta", ":TestSuite<CR>", { desc = "[T]est [A]ll" } },

        -- Test coverage mappings
        { "<leader>tcl", ":Coverage<CR>", { desc = "[T]est [C]overage [L]oad" } },
        { "<leader>tcc", ":CoverageClear<CR>", { desc = "[T]est [C]overage [C]lear" } },
        { "<leader>tct", ":CoverageToggle<CR>", { desc = "[T]est [C]overage [T]oggle" } },
        { "<leader>tcs", ":CoverageSummary<CR>", { desc = "[T]est [C]overage [S]ummary" } },
    },
}

M.init = function()
    vim.g["test#go#gotest#options"] = "-v -coverprofile coverage.out"
    vim.g["test#strategy"] = "neovim"
end

M.config = function()
    require('Coverage').setup()

end

return M
