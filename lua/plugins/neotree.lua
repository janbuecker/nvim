return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        window = {
            mappings = {
                ["m"] = { "move", config = { show_path = "relative" } },
            },
        },
        filesystem = {
            follow_current_file = true,
            use_libuv_file_watcher = true,
            filtered_items = {
                hide_gitignored = false,
                group_empty_dirs = true,
            },
        },
    },
    keys = {
        { "<leader>e", ":Neotree toggle<CR>", { desc = "[E]xplorer" } },
        { "<leader>\\", ":Neotree toggle<CR>", { desc = "[E]xplorer" } },
    },
}
