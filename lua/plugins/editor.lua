MiniDeps.later(function()
    MiniDeps.add({ source = "zbirenbaum/copilot.lua" })
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
end)

MiniDeps.add({ source = "tpope/vim-abolish" })

MiniDeps.later(function()
    MiniDeps.add({ source = "mbbill/undotree" })
end)

MiniDeps.later(function()
    MiniDeps.add({ source = "mcauley-penney/visual-whitespace.nvim" })
    require("visual-whitespace").setup()
end)

MiniDeps.later(function()
    MiniDeps.add({ source = "chrisgrieser/nvim-rip-substitute" })

    require("rip-substitute").setup({
        prefill = {
            normal = false,
        },
    })
end)

MiniDeps.later(function()
    MiniDeps.add({ source = "FabijanZulj/blame.nvim" })

    require("blame").setup()
end)

MiniDeps.later(function()
    MiniDeps.add({ source = "stevearc/quicker.nvim" })

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
end)

-- quicker
vim.keymap.set("n", "<C-q>", function()
    require("quicker").toggle()
end, { desc = "Toggle quickfix" })

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })

-- rip substitute
vim.keymap.set({ "n", "x" }, "<leader>sr", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })
vim.keymap.set({ "n", "x" }, "<A-r>", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })
vim.keymap.set("v", "<C-r>", "<cmd>RipSubstitute<CR>", { desc = " rip substitute" })

-- git blame
vim.keymap.set({ "n", "x" }, "<leader>gb", "<cmd>BlameToggle<CR>", { desc = "Git Blame" })

-- keys = require("config.keymaps").blame(),
