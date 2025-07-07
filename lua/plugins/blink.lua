MiniDeps.later(function()
    MiniDeps.add({ source = "saghen/blink.cmp", checkout = "v1.3.1" })

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
                menu = {
                    auto_show = function()
                        return vim.fn.getcmdtype() == ":"
                    end,
                },
            },
        },
    })
end)
