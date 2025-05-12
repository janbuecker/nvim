vim.lsp.enable("shopware_lsp")

return {
    cmd = { "shopware-lsp" },
    root_markers = { "composer.json", ".git" },
    filetypes = { "php", "xml", "twig", "yaml" },
    root_dir = function(pattern)
        local util = require("lspconfig.util")
        local cwd = vim.uv.cwd()
        local root = util.root_pattern("composer.json", ".git")(pattern)

        -- prefer cwd if root is a descendant
        return util.path.is_descendant(cwd, root) and cwd or root
    end,
}
