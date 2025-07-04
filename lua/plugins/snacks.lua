---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

MiniDeps.add({ source = "folke/snacks.nvim" })
MiniDeps.now(function()
    require("snacks").setup({
        notifier = { enabled = true },
        input = { enabled = true },
        rename = { enabled = true },
        lazygit = { enabled = true },
        picker = {
            enabled = true,
            layout = "vertical",
            formatters = {
                file = {
                    -- filename_first = true,
                    truncate = 80,
                },
            },
        },
    })
end)


-- stylua: ignore start
vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })

vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, {desc = "Grep" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, {desc = "Command History" })
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.buffers({ current = false }) end, {desc = "Buffers" })
vim.keymap.set("n", "<leader>qc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, {desc = "Find Config File" })
vim.keymap.set("n", "<leader>qp", function() Snacks.picker.projects({ confirm = { "tcd", "picker_files" } }) end, {desc = "Projects" })
vim.keymap.set("n", "<leader>f", function() Snacks.picker.files({ hidden = true }) end, {desc = "Find Files" })

-- git
vim.keymap.set("n", "<leader>gc", function() Snacks.picker.git_log() end, {desc = "Git Log" })

-- Grep
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, {desc = "Grep" })

-- search
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, {desc = "Command History" } )
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, {desc = "Commands" } )
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, {desc = "Diagnostics" } )
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, {desc = "Help Pages" } )
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, {desc = "Keymaps" } )
vim.keymap.set("n", "<leader>sl", function() Snacks.picker.resume() end, {desc = "Resume" } )
vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, {desc = "Resume" } )
-- stylua: ignore end
