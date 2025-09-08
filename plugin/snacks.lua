vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
}, { load = true })

require("snacks").setup({
    notifier = { enabled = true },
    input = { enabled = true },
    rename = { enabled = true },
    lazygit = { enabled = true },
    picker = {
        enabled = true,
        layout = "vertical",
        formatters = {
            file = {
                -- filename_first = true,
                truncate = 80,
            },
        },
    },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })

vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, {desc = "Grep" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, {desc = "Command History" })
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.buffers({ current = false }) end, {desc = "Buffers" })
vim.keymap.set("n", "<leader>qc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, {desc = "Find Config File" })
vim.keymap.set("n", "<leader>qp", function() Snacks.picker.projects({ confirm = { "tcd", "picker_files" } }) end, {desc = "Projects" })
vim.keymap.set("n", "<leader>f", function() Snacks.picker.files({ hidden = true }) end, {desc = "Find Files" })

-- git
vim.keymap.set("n", "<leader>gc", function() Snacks.picker.git_log() end, {desc = "Git Log" })

-- Grep
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, {desc = "Grep" })

-- search
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, {desc = "Command History" } )
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, {desc = "Commands" } )
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, {desc = "Diagnostics" } )
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, {desc = "Help Pages" } )
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, {desc = "Keymaps" } )
vim.keymap.set("n", "<leader>sl", function() Snacks.picker.resume() end, {desc = "Resume" } )
vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, {desc = "Resume" } )
-- stylua: ignore end
