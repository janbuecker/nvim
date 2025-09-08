vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = "https://github.com/folke/ts-comments.nvim" },
}, { load = true })

vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "*",
    callback = function(ev)
        vim.notify(ev.data.spec.name .. " has been updated.")
        if ev.data.spec.name == "nvim-treesitter" and ev.data.spec.kind ~= "deleted" then
            vim.cmd([[ TSUpdate ]])
        end
    end,
})

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { tf = "terraform" } })
vim.filetype.add({ extension = { gotmpl = "gotmpl" } })

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "hcl",
        "html",
        "json",
        "lua",
        "luadoc",
        "php",
        "phpdoc",
        "proto",
        "regex",
        "templ",
        "terraform",
        "twig",
        "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
})
