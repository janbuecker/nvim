vim.pack.add({
    { src = "https://github.com/varnishcache-friends/vim-varnish" },
    { src = "https://github.com/stevearc/conform.nvim" },
}, { load = true })

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("conform").setup({
    format = {
        timeout_ms = 5000,
        async = false,
        quiet = false,
    },
    formatters_by_ft = {
        ["terraform-vars"] = { "terraform_fmt" },
        go = { "gci", "golines" },
        hcl = { "terragrunt_hclfmt" },
        json = { "jq" },
        lua = { "stylua" },
        php = { "php_cs_fixer" },
        proto = { "buf" },
        sh = { "shfmt" },
        sql = { "sqlfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        twig = { "ludtwig" },
    },
    formatters = {
        shfmt = {
            prepend_args = { "-i", "2" },
        },
        gci = {
            args = {
                "write",
                "--skip-generated",
                "-s",
                "Standard",
                "-s",
                "Default",
                "-s",
                "Prefix(github.com/shopware-saas)",
                "--skip-vendor",
                "$FILENAME",
            },
        },
        golines = {
            -- golines will use goimports as base formatter by default which is slow.
            -- see https://github.com/segmentio/golines/issues/33
            prepend_args = {
                "--base-formatter=gofumpt",
                "--ignore-generated",
                -- "--tab-len=1",
                -- "--max-len=120",
            },
        },
        ludtwig = {
            command = "ludtwig",
            args = { "-f", "$FILENAME" },
            stdin = false,
        },
        php_cs_fixer = {
            env = {
                PHP_CS_FIXER_IGNORE_ENV = "1",
            },
        },
    },
    format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 3000, lsp_format = "fallback" }
    end,
})
