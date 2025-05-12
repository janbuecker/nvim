return {
    "saghen/blink.cmp",
    enabled = true,
    version = "1.*",
    opts = {
        keymap = { preset = "enter" },
        -- appearance = {
        --     nerd_font_variant = "mono",
        -- },
        -- fuzzy = { implementation = "prefer_rust_with_warning" },
        completion = {
            ghost_text = { enabled = false },
            --     documentation = {
            --         auto_show = true,
            --     },
        },
        -- signature = {
        --     enabled = true,
        -- },
        -- sources = {
        --     default = { "copilot", "lsp", "path", "buffer" },
        --     providers = {
        --         copilot = {
        --             name = "copilot",
        --             module = "blink-copilot",
        --             score_offset = 100,
        --             async = true,
        --         },
        --     },
        -- },
    },
    opts_extend = { "sources.default" },
}
