return {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
        require("mini.move").setup()
        require("mini.bracketed").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        require("mini.bufremove").setup()
        require("mini.misc").setup({ make_global = { "setup_auto_root" } })
        require("mini.misc").setup_auto_root()
    end,
    keys = {
        -- stylua: ignore start
        { "<leader>x", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
        { "<leader>X", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)", },
        -- stylua: ignore end
    },
}
