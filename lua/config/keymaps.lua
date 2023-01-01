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

-- Center page on find/scroll
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move current line / block with Alt-j/k a la vscode.
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")

-- QuickFix
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cprev<CR>")
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without copying the selected content
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Treat ctrl-c as ESC for visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Force close
vim.keymap.set("n", "<leader>x", "<cmd>bd!<CR>", { desc = "Close Buffer" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
