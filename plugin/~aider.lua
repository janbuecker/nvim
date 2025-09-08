vim.pack.add({
    { src = "https://github.com/GeorgesAlkhouri/nvim-aider" },
}, { load = true })

require("nvim_aider").setup()

vim.keymap.set("n", "<leader>aa", "<cmd>Aider toggle<cr>", { desc = "Toggle Aider" })
vim.keymap.set({ "n", "v" }, "<leader>as", "<cmd>Aider send<cr>", { desc = "Send to Aider" })
vim.keymap.set("n", "<leader>ac", "<cmd>Aider command<cr>", { desc = "Aider Commands" })
vim.keymap.set("n", "<leader>ab", "<cmd>Aider buffer<cr>", { desc = "Send Buffer" })
vim.keymap.set("n", "<leader>a+", "<cmd>Aider add<cr>", { desc = "Add File" })
vim.keymap.set("n", "<leader>a-", "<cmd>Aider drop<cr>", { desc = "Drop File" })
vim.keymap.set("n", "<leader>ar", "<cmd>Aider add readonly<cr>", { desc = "Add Read-Only" })
