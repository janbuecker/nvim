local M = {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                -- null_ls.builtins.completion.spell,

                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.phpcsfixer,
                null_ls.builtins.formatting.buf,
                null_ls.builtins.formatting.sqlfluff,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.terraform_fmt,
                null_ls.builtins.formatting.nixfmt,
                null_ls.builtins.formatting.stylua,

                null_ls.builtins.code_actions.gomodifytags,
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.code_actions.gitrebase,
                null_ls.builtins.code_actions.gitsigns,

                null_ls.builtins.diagnostics.shellcheck,
                null_ls.builtins.diagnostics.buf,
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.diagnostics.terraform_validate,
                null_ls.builtins.diagnostics.phpstan,
                null_ls.builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "postgres", "--exclude-rules", "L016" },
                }),
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                filter = function(client)
                                    return client.name == "null-ls"
                                end,
                            })
                        end,
                    })
                end
            end,
        })
    end,
}

return M
