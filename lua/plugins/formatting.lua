return {
    {
        "varnishcache-friends/vim-varnish",
        ft = "vcl",
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = require("config.keymaps").conform(),
        opts = {
            format = {
                timeout_ms = 5000,
                async = false,
                quiet = false,
            },
            formatters_by_ft = {},
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 3000, lsp_format = "fallback" }
            end,
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
