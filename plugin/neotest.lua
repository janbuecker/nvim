vim.pack.add({
    { src = "https://github.com/nvim-neotest/neotest" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/leoluz/nvim-dap-go" },
    { src = "https://github.com/fredrikaverpil/neotest-golang" },
}, { load = true })

local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
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

vim.pack.add({
    { src = "https://github.com/andythigpen/nvim-coverage" },
}, { load = true })

require("coverage").setup({
    auto_reload = true,
    lang = {
        go = {
            coverage_file = vim.fn.getcwd() .. "/coverage.out",
        },
    },
})


-- stylua: ignore start
vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, {desc = "Run File" } )
vim.keymap.set("n", "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, {desc = "Run All Test Files" } )
vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, {desc = "Run Nearest" } )
vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end, {desc = "Run Last" } )
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, {desc = "Toggle Summary" } )
vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, {desc = "Show Output" } )
vim.keymap.set("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, {desc = "Toggle Output Panel" } )
vim.keymap.set("n", "<leader>tS", function() require("neotest").run.stop() end, {desc = "Stop" } )
vim.keymap.set("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, {desc = "Toggle Watch" } )
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, {desc = "Debug nearest test" } )
vim.keymap.set("n", "<leader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, {desc = "Debug current file" } )

vim.keymap.set("n", "<leader>tcl", ":Coverage<CR>", {desc = "[T]est [C]overage [L]oad" } )
vim.keymap.set("n", "<leader>tcc", ":CoverageClear<CR>", {desc = "[T]est [C]overage [C]lear" } )
vim.keymap.set("n", "<leader>tct", ":CoverageToggle<CR>", {desc = "[T]est [C]overage [T]oggle" } )
vim.keymap.set("n", "<leader>tcs", ":CoverageSummary<CR>", {desc = "[T]est [C]overage [S]ummary" } )
-- stylua: ignore end
