vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("conform").setup({
    format = {
        timeout_ms = 5000,
        async = false,
        quiet = false,
    },
    formatters_by_ft = {
        ["terraform-vars"] = { "terraform_fmt" },
        go = { "golangci-lint" },
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
        templ = { "templ" },
    },
    formatters = {
        shfmt = {
            prepend_args = { "-i", "2" },
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
        -- go is handled by the *.go BufWritePre autocmd in lsp.lua, which runs
        -- organizeImports before invoking conform, so skip it here.
        if vim.bo[bufnr].filetype == "go" then
            return
        end
        return { timeout_ms = 3000, lsp_format = "fallback" }
    end,
})
