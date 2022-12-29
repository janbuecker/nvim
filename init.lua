vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('janbuecker.lazy')
require('janbuecker.options')

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require('janbuecker.commands')
        require('janbuecker.keymaps')
    end,
})
