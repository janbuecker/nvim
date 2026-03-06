return {
    before_init = function(_, client_config)
        client_config.settings.json.schemas = require("schemastore").json.schemas()
    end,
    settings = {
        json = {
            validate = { enable = true },
        },
    },
    setup = {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.format({ async = false })
                end,
            },
        },
    },
}
