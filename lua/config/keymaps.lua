vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable Recording & Ex Mode
vim.keymap.set('', 'q', '<nop>')
vim.keymap.set('', 'Q', '<nop>')

-- : to ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Format
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { desc = '[F]ormat file' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = '[LSP] Format file' })

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

-- Buffer
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bprev<CR>", { desc = "Prev buffer" })

-- QuickFix
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Prev quickfix" })
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without copying the selected content
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without copying the selected content" })

-- Treat ctrl-c as ESC for visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Force close
vim.keymap.set("n", "<leader>x", "<cmd>bd!<CR>", { desc = "Close Buffer" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Next diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Prev diagnostic" })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Open diagnostic in float" })

vim.keymap.set('n', '<leader>hk', "<cmd>Telescope keymaps<CR>", { desc = '[Help] Keymaps' })
