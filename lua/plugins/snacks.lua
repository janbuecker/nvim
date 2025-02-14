return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        notifier = { enabled = true },
        rename = { enabled = true },
        lazygit = { enabled = true },
    },
    keys = {
        -- stylua: ignore start
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History", },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)", },
        -- stylua: ignore end
    },
}
