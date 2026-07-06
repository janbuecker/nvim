return {
    cmd = { "shopware-lsp" },
    root_markers = { "composer.json", ".git" },
    filetypes = { "php", "xml", "twig", "yaml" },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = assert(vim.uv.cwd())
        local root = vim.fs.root(fname, { "composer.json", ".git" })

        -- prefer cwd if root is a descendant
        on_dir(root and vim.fs.relpath(cwd, root) and cwd or root)
    end,
}
