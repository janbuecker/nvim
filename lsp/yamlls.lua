-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/yamlls.lua
return {
    capabilities = {
        server_compatibilities = {
            documentFormattingProvider = true,
        },
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    },
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            keyOrdering = false,
            format = {
                enable = true,
            },
            validate = true,
            schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
}
