return {
    {
        "nvim-neotest/neotest",
        event = "LspAttach",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-neotest/nvim-nio" },
            { "antoinemadec/FixCursorHold.nvim" },
        },
        opts = {
            status = { virtual_text = true },
            output = { open_on_run = true },
            quickfix = { enabled = true },
            adapters = {},
            discovery = {
                -- Number of workers to parse files concurrently.
                -- A value of 0 automatically assigns number based on CPU.
                -- Set to 1 if experiencing lag.
                concurrent = 1,
            },
            running = {
                -- Run tests concurrently when an adapter provides multiple commands to run.
                concurrent = false,
            },
            summary = {
                -- Enable/disable animation of icons.
                animated = false,
            },
        },
        config = function(_, opts)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        -- Replace newline and tab characters with space for more compact diagnostics
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)

            if opts.adapters then
                local adapters = {}
                for name, config in pairs(opts.adapters or {}) do
                    if type(name) == "number" then
                        if type(config) == "string" then
                            config = require(config)
                        end
                        adapters[#adapters + 1] = config
                    elseif config ~= false then
                        local adapter = require(name)
                        if type(config) == "table" and not vim.tbl_isempty(config) then
                            local meta = getmetatable(adapter)
                            if adapter.setup then
                                adapter.setup(config)
                            elseif meta and meta.__call then
                                adapter(config)
                            else
                                error("Adapter " .. name .. " does not support setup")
                            end
                        end
                        adapters[#adapters + 1] = adapter
                    end
                end
                opts.adapters = adapters
            end

            require("neotest").setup(opts)
        end,
        keys = require("config.keymaps").neotest(),
    },
    {
        "andythigpen/nvim-coverage",
        cmd = { "Coverage", "CoverageClear", "CoverageToggle", "CoverageSummary" },
        keys = require("config.keymaps").coverage(),
        opts = {
            auto_reload = true,
            lang = {
                go = {
                    coverage_file = vim.fn.getcwd() .. "/coverage.out",
                },
            },
        },
    },
}
