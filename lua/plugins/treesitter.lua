return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    build = ":TSUpdate",
    cmd = { "TSUpdateSync" },
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        { "folke/ts-comments.nvim", opts = {} },
    },
    opts = {
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
    },
    config = function(_, opts)
        vim.filetype.add({ extension = { templ = "templ" } })
        vim.filetype.add({ extension = { tf = "terraform" } })
        vim.filetype.add({ extension = { gotmpl = "gotmpl" } })

        require("nvim-treesitter.configs").setup(opts)
    end,
}
