vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
}, { load = true })

require("blink.cmp").setup({
    keymap = { preset = "enter" },
    completion = {
        accept = {
            auto_brackets = { enabled = false },
        },
        ghost_text = { enabled = false },
        menu = {
            draw = {
                treesitter = { "lsp" },
            },
        },
    },
    cmdline = {
        keymap = {
            ["<Tab>"] = { "show_and_insert", "select_next" },
        },
        completion = {
            list = {
                selection = { preselect = false, auto_insert = true },
            },
            menu = {
                auto_show = function()
                    return vim.fn.getcmdtype() == ":"
                end,
            },
        },
    },
})
