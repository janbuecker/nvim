vim.pack.add({
    { src = "https://github.com/gruntwork-io/terragrunt-ls" },
}, { load = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.hcl",
    callback = function()
        local terragrunt_ls = require("terragrunt-ls")
        terragrunt_ls.setup({})
        if terragrunt_ls.client then
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "hcl",
                callback = function()
                    vim.lsp.buf_attach_client(0, terragrunt_ls.client)
                end,
            })
        end
    end,
})
