-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true -- Set highlight on search
vim.opt.number = true -- Make line numbers default
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.undofile = true -- Save undo history
vim.opt.cursorline = true -- Show cursor line
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true -- Smart case
vim.opt.updatetime = 100 -- Decrease update time
vim.opt.signcolumn = 'yes' -- Always display signcolumn
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.colorcolumn = "120" -- Visually mark at 120 chars
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 8 -- minimal number of screen lines to keep left and right of the cursor.
vim.opt.swapfile = false -- disable swap files
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.laststatus = 3
vim.opt.wrap = false -- Disable line wrap

vim.opt.spelllang:append "cjk" -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.whichwrap:append "<,>,[,],h,l"

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.list = true

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.o.shortmess = "filnxtToOFWIcC"
end
