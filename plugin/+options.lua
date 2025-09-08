vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.colorcolumn = "120" -- Visually mark at 120 chars
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort" -- Set completeopt to have a better completion experience
vim.opt.cursorline = true -- Show cursor line
vim.opt.diffopt = "internal,filler,closeoff,linematch:60"
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.hlsearch = true -- Set highlight on search
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.laststatus = 3
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Make line numbers default
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.sidescrolloff = 8 -- minimal number of screen lines to keep left and right of the cursor.
vim.opt.signcolumn = "yes" -- Always display signcolumn
vim.opt.smartcase = true -- Smart case
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- disable swap files
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300 -- Decrease update time
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 100 -- Decrease update time
vim.opt.wrap = false -- Disable line wrap

vim.opt.spelllang:append("cjk") -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.whichwrap:append("<,>,[,],h,l")

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.list = true

vim.opt.splitkeep = "cursor"
vim.o.shortmess = "filnxtToOFWIcC"

vim.o.winborder = "single"

local icons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = function(diagnostic)
            for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                    return icon
                end
            end
        end,
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.HINT] = icons.Hint,
            [vim.diagnostic.severity.INFO] = icons.Info,
        },
    },
})
