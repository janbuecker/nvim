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
            quickfix = { enabled = false },
            adapters = {},
            icons = {
                expanded = "",
                child_prefix = "",
                child_indent = "",
                final_child_prefix = "",
                non_collapsible = "",
                collapsed = "",

                passed = "",
                running = "",
                failed = "",
                unknown = "",
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
        -- stylua: ignore
        keys = {
          { "<leader>ta", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
          { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
          { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
          { "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
          { "<leader>tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
          { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
          { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
          { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
          { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
          { "<leader>tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
          { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
        },
    },
    {
        "andythigpen/nvim-coverage",
        cmd = { "Coverage", "CoverageClear", "CoverageToggle", "CoverageSummary" },
        keys = {
            -- stylua: ignore
            { "<leader>tcl", ":Coverage<CR>", desc = "[T]est [C]overage [L]oad" },
            { "<leader>tcc", ":CoverageClear<CR>", desc = "[T]est [C]overage [C]lear" },
            { "<leader>tct", ":CoverageToggle<CR>", desc = "[T]est [C]overage [T]oggle" },
            { "<leader>tcs", ":CoverageSummary<CR>", desc = "[T]est [C]overage [S]ummary" },
        },
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
