vim.pack.add({
    "https://github.com/vim-test/vim-test",
    "https://github.com/tpope/vim-dispatch",
}, { load = true })

vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", { desc = "Run Nearest Test" })
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run Last Test" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run Test File" })
vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "Run All Tests" })
vim.keymap.set("n", "gt", ":TestVisit<CR>", { desc = "Go to Last Test" })

vim.g["test#strategy"] = "dispatch"
vim.g["test#go#gotest#options"] = "-v"
