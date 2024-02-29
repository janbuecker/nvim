vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Disable Recording & Ex Mode
vim.keymap.set("", "q", "<nop>")
vim.keymap.set("", "Q", "<nop>")

-- : to ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center page on find/scroll
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without copying the selected content
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without copying the selected content" })

-- Treat ctrl-c as ESC for visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Diagnostic keymaps
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })

-- toggle wrap
vim.keymap.set("n", "<leader>ww", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
