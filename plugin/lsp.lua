vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/b0o/schemastore.nvim" },
}, { load = true })

vim.lsp.enable({
    "gopls",
    "dockerls",
    "buf_ls",
    "lua_ls",
    "yamlls",
    "jsonls",
    "html",
    "terraformls",
    -- "phptools",
    "intelephense",
})
