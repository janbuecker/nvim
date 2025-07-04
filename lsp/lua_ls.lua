return {
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { "vim", "Snacks", "MiniDeps" },
            },
        },
    },
}
