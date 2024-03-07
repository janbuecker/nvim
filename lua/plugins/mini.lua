return {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
        require("mini.comment").setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
            mappings = {
                comment_line = "<leader>/",
                comment_visual = "<leader>/",
            },
        })
        require("mini.move").setup()
        require("mini.bracketed").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        require("mini.bufremove").setup()
        require("mini.misc").setup({ make_global = { "setup_auto_root" } })
        require("mini.misc").setup_auto_root()
    end,
    -- stylua: ignore
    keys = {
        { "<leader>X", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
    },
}
