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
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                end,
            },
        },
    },
}
