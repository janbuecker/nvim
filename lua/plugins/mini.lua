return {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,

    config = function()
        require("mini.move").setup()
        require("mini.bracketed").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        require("mini.bufremove").setup()
        require("mini.cursorword").setup()
        require("mini.misc").setup({ make_global = { "setup_auto_root" } })
        require("mini.misc").setup_auto_root()

        require("mini.indentscope").setup({
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
            draw = {
                animation = require("mini.indentscope").gen_animation.none(),
            },
        })

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
    end,
    -- stylua: ignore
    keys = {
        { "<leader>X", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
    },
}
