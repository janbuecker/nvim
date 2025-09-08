vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/b0o/schemastore.nvim" },
}, { load = true })

require("mason").setup()
require("mason-lspconfig").setup()

local packages = {
    -- dockerfile
    "hadolint",
    "dockerfile-language-server",

    -- go
    "gopls",
    "gci",
    "gofumpt",
    "golines",
    "goimports",
    "delve",

    -- htmx/html
    "htmx-lsp",
    "html-lsp",

    -- json
    "jsonlint",
    "json-lsp",

    -- lua
    "lua-language-server",
    "stylua",

    -- php
    "intelephense",

    -- proto/buf
    "buf",

    -- shell
    "shellcheck",
    "shfmt",

    -- terraform
    -- "terraform-ls",
    "hclfmt",
    -- "tflint",

    -- yaml
    "yaml-language-server",
    "yamllint",
    "yamlfix",
}

local registry = require("mason-registry")
registry.refresh(function()
    for _, pkg_name in ipairs(packages) do
        local pkg = registry.get_package(pkg_name)
        if not pkg:is_installed() then
            vim.notify("Installing: " .. pkg_name, vim.log.levels.INFO)
            pkg:install()
        end
    end
end)
