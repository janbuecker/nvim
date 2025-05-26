return {
    "saghen/blink.cmp",
    enabled = true,
    version = "1.*",
    -- event = "VeryLazy",
    event = { "InsertEnter" },
    opts = {
        keymap = { preset = "enter" },
        completion = {
            ghost_text = { enabled = false },
            -- menu = {
            --     draw = {
            --         columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            --     },
            -- },
        },
        cmdline = {
            keymap = {
                ["<Tab>"] = { "show", "accept" },
            },
            completion = {
                menu = {
                    auto_show = function()
                        return vim.fn.getcmdtype() == ":"
                    end,
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
