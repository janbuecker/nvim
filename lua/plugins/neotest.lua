return {
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "fredrikaverpil/neotest-golang",
                version = "*",
                dependencies = {
                    "leoluz/nvim-dap-go",
                },
            },
        },
        config = function()
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

            local neotest_golang_opts = { -- Specify configuration
                dap_go_enabled = true,
                go_test_args = {
                    "-v",
                    "-count=1",
                    "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
                },
            }

            require("neotest").setup({
                status = { virtual_text = true },
                output = { open_on_run = true },
                quickfix = { enabled = true },
                adapters = {
                    require("neotest-golang")(neotest_golang_opts),
                },
            })
        end,
        keys = require("config.keymaps").neotest(),
    },
    {
        "andythigpen/nvim-coverage",
        cmd = {
            "Coverage",
            "CoverageClear",
            "CoverageToggle",
            "CoverageSummary",
        },
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
