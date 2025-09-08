vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
}, { load = true })

require("catppuccin").setup({
    transparent_background = true,
    integrations = {
        diffview = true,
        neotest = true,
        snacks = true,
    },
})
vim.cmd.colorscheme("catppuccin-macchiato")
