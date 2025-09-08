-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end

            vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
        end

        -- stylua: ignore start
        nmap("gd", function() Snacks.picker.lsp_definitions() end, "[G]oto [D]efinition")
        nmap("grr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
        nmap("gri", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")
        nmap("gO", function() Snacks.picker.lsp_symbols() end, "[D]ocument [S]ymbols")
        nmap("<leader>sd", function() Snacks.picker.diagnostics_buffer() end, "[D]ocument [D]iagnostics")
        nmap("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
        nmap("<leader>wd", function() Snacks.picker.diagnostics() end, "[W]orkspace [D]iagnostics")
        -- stylua: ignore end

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(args.buf, "Format", function(_)
            vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("user_lastloc", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Toggle func for quickfix
vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      horizontal copen
    else
      cclose
    endif
  endfunction
]])

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
        "NvimTree",
        "neotest-output",
        "neotest-summary",
        "neotest-output-panel",
        "quicktest-output",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Command to toggle format-on-save
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

-- go formatting
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params(0, "utf-8")
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({ async = false })
    end,
})

-- LSP index progress
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
