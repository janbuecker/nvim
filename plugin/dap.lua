vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

local icons = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
}

for name, sign in pairs(icons) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    )
end

-- setup dap config by VsCode launch.json file
local vscode = require("dap.ext.vscode")
local json = require("plenary.json")
vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end

require("nvim-dap-virtual-text").setup()
require("dap-go").setup()

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end

-- stylua: ignore start
vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {desc = "Breakpoint Condition" } )
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, {desc = "Toggle Breakpoint" } )
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, {desc = "Run/Continue" } )
vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, {desc = "Run to Cursor" } )
vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, {desc = "Go to Line (No Execute)" } )
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, {desc = "Step Into" } )
vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, {desc = "Down" } )
vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, {desc = "Up" } )
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, {desc = "Run Last" } )
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, {desc = "Step Out" } )
vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end, {desc = "Step Over" } )
vim.keymap.set("n", "<leader>dP", function() require("dap").pause() end, {desc = "Pause" } )
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, {desc = "Toggle REPL" } )
vim.keymap.set("n", "<leader>ds", function() require("dap").session() end, {desc = "Session" } )
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, {desc = "Terminate" } )
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, {desc = "Widgets" } )

vim.keymap.set("n", "<leader>du", function() require("dapui").toggle({ }) end, {desc = "Dap UI" } )
vim.keymap.set({"n", "v"}, "<leader>de", function() require("dapui").eval() end, {desc = "Eval" } )
-- stylua: ignore end
