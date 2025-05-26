return {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    keys = {
        { "<leader>aa", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
        { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
        { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
        { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
        { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
        { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
        { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
    },
    dependencies = {
        "folke/snacks.nvim",
    },
    config = true,
}
