return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>F",
                function()
                    require("conform").format()
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
            {
                -- Customize or remove this keymap to your liking
                "<leader>lF",
                function()
                    require("conform").format()
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        opts = {
            format = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
            },
            formatters_by_ft = {},
            format_on_save = { timeout_ms = 3000, lsp_fallback = true },
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
