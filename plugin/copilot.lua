vim.pack.add({
    { src = "https://github.com/zbirenbaum/copilot.lua" },
}, { load = true })

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
