return {
    "echasnovski/mini.nvim",
    version = false,
    -- event = "VeryLazy",
    lazy = false,
    config = function()
        require("mini.move").setup()
        require("mini.bracketed").setup()
        require("mini.cursorword").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        require("mini.misc").setup({
            make_global = { "setup_auto_root", "setup_restore_cursor" },
        })
        require("mini.indentscope").setup({
            draw = {
                animation = require("mini.indentscope").gen_animation.none(),
            },
        })

        require("mini.misc").setup_restore_cursor()
        require("mini.misc").setup_auto_root()
    end,
}
