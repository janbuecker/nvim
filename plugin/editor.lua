vim.pack.add({
    { src = "https://github.com/dstein64/vim-startuptime" },
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    { src = "https://github.com/tpope/vim-abolish" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
    { src = "https://github.com/chrisgrieser/nvim-rip-substitute" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/folke/flash.nvim" },
}, { load = true })

require("flash").setup()

vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end)
vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end)

require("visual-whitespace").setup()

-- copilot

require("copilot").setup({
    panel = { enabled = false },
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = "<C-y>",
        },
    },
    filetypes = {
        ["rip-substitude"] = false,
        ["yaml"] = true,
        ["terraform"] = true,
    },
})

-- rip substitute

require("rip-substitute").setup({
    prefill = {
        normal = false,
    },
})

vim.keymap.set({ "n", "x" }, "<leader>sr", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })
vim.keymap.set({ "n", "x" }, "<A-r>", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })
vim.keymap.set("v", "<C-r>", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })

-- quickfix

require("quicker").setup({
    keys = {
        {
            ">",
            function()
                require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
        },
        {
            "<",
            function()
                require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
        },
    },
})

vim.keymap.set("n", "<C-q>", function()
    require("quicker").toggle()
end, { desc = "Toggle quickfix" })

-- undotree

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })
