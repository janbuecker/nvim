local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    build = ":TSUpdate",
    cmd = { "TSUpdateSync" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "folke/ts-comments.nvim",
            opts = {},
            event = "InsertEnter",
        },
    },
    opts = {
        ensure_installed = {},
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = "<c-s>",
                node_decremental = "<c-backspace>",
            },
        },
    },
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end

        require("nvim-treesitter.configs").setup(opts)
    end,
}

return M
