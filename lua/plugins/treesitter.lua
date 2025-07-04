MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "master",
    monitor = "main",
    depends = {
        "folke/ts-comments.nvim",
    },
    hooks = {
        post_checkout = function()
            vim.cmd("TSUpdate")
        end,
    },
})

MiniDeps.later(function()
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
            "templ",
            "terraform",
            "twig",
            "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
    })
end)
