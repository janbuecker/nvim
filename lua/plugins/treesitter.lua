local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    build = ":TSUpdate",
    cmd = { "TSUpdateSync" },
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        {
            "folke/ts-comments.nvim",
            opts = {},
        },
    },
    opts = {
        ensure_installed = {},
        highlight = { enable = true },
        indent = { enable = true },
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
