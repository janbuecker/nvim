M = {}

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- : to ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- QuickFix
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center page on find/scroll
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without copying the selected content
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without copying the selected content" })

-- Treat ctrl-c as ESC for visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Diagnostic keymaps
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })

-- toggle wrap
vim.keymap.set("n", "<leader>ww", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })

M.undotree = function()
    return {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" },
    }
end

M.ripsubstitue = function()
    return {
        { "<leader>sr", "<cmd>RipSubstitute<CR>", mode = { "n", "x" }, desc = " rip substitute" },
    }
end

M.conform = function()
    return {
        {
            "<leader>F",
            function()
                require("conform").format()
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        },
    }
end

M.fzf = function()
    return {
        -- {
        --     "<C-e>",
        --     "<cmd>FzfLua oldfiles cwd_only=true include_current_session=true<CR>",
        --     desc = "[?] Find recently opened files",
        -- },
        -- { "<leader><space>", "<cmd>FzfLua buffers<CR>", desc = "[ ] Find existing buffers" },

        {
            "<C-e>",
            "<cmd>Pick oldfiles current_dir=true<CR>",
            desc = "[?] Find recently opened files",
        },
        { "<leader><space>", "<cmd>Pick buffers<CR>", desc = "[ ] Find existing buffers" },
        { "<leader>gf", "<cmd>Pick git_commits path='%'<cr>", desc = "[G]it [F]iles history" },
        { "<leader>hk", "<cmd>Pick keymaps<CR>", desc = "[S]earch [F]iles" },
        { "<leader>f", "<cmd>Pick files<CR>", desc = "[S]earch [F]iles" },
        { "<leader>sf", "<cmd>Pick files<CR>", desc = "[S]earch [F]iles" },
        { "<leader>sh", "<cmd>Pick help<CR>", desc = "[S]earch [H]elp" },
        { "<leader>sg", "<cmd>Pick grep_live<CR>", desc = "[S]earch by [G]rep" },
        { "<leader>/", "<cmd>Pick grep_live<CR>", desc = "[S]earch by [G]rep (/)" },
        { "<leader>sd", "<cmd>Pick scope='document_symbol'<CR>", desc = "[S]earch [D]iagnostics" },
        { "<leader>sl", "<cmd>Pick resume<CR>", desc = "[S]earch [L]ast (resume)" },

        -- { "<leader>gf", "<cmd>FzfLua git_bcommits<cr>", desc = "[G]it [F]iles history" },
        -- { "<leader>hk", "<cmd>FzfLua keymaps<CR>", desc = "[S]earch [F]iles" },
        -- { "<leader>f", "<cmd>FzfLua files<CR>", desc = "[S]earch [F]iles" },
        -- { "<leader>sf", "<cmd>FzfLua files<CR>", desc = "[S]earch [F]iles" },
        -- { "<leader>sh", "<cmd>FzfLua help_tags<CR>", desc = "[S]earch [H]elp" },
        -- { "<leader>sg", "<cmd>FzfLua live_grep<CR>", desc = "[S]earch by [G]rep" },
        -- { "<leader>/", "<cmd>FzfLua live_grep<CR>", desc = "[S]earch by [G]rep (/)" },
        -- { "<leader>sd", "<cmd>FzfLua diagnostics_document<CR>", desc = "[S]earch [D]iagnostics" },
        -- { "<leader>sl", "<cmd>FzfLua resume<CR>", desc = "[S]earch [L]ast (resume)" },
        {
            "<leader>P",
            function()
                require("fzf-lua").live({
                    prompt = "Projects> ",
                    exec_empty_query = true,
                    fn_transform = function(x)
                        return fzf_lua.utils.ansi_codes.magenta(x)
                    end,
                    actions = {
                        ["default"] = function(selected)
                            fzf_lua.files({ cwd = selected[1] })
                        end,
                    },
                })
            end,
            desc = "[S]earch [P]rojects",
        },
    }
end

M.lazygit = function()
    return {
        { "<leader>gg", ":LazyGit<CR>", desc = "Lazygit" },
    }
end

M.lsp_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>lr", vim.lsp.buf.rename, "[LSP] Rename")
    nmap("<leader>la", vim.lsp.buf.code_action, "[LSP] Code Action")

    nmap("gd", "<cmd>Pick lsp scope='definition'<CR>", "[G]oto [D]efinition")
    nmap("gr", "<cmd>Pick lsp scope='references'<CR>", "[G]oto [R]eferences")
    nmap("gI", "<cmd>Pick lsp scope='implementation'<CR>", "[G]oto [I]mplementation")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>D", "<cmd>Pick lsp scope='type_definition'<CR>", "Type [D]efinition")
    nmap("<leader>ds", "<cmd>Pick lsp scope='document_symbol'<CR>", "[D]ocument [S]ymbols")
    nmap("<leader>dd", "<cmd>Pick diagnostic scope='current'<CR>", "[D]ocument [D]iagnostics")
    nmap("<leader>ws", "<cmd>Pick lsp scope='workspace_symbol'<CR>", "[W]orkspace [S]ymbols")
    nmap("<leader>wd", "<cmd>Pick diagnostic scope='all'<CR>", "[W]orkspace [D]iagnostics")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

M.mini = function()
    return {
        {
            "<leader>gO",
            function()
                require("mini.diff").toggle_overlay()
            end,
            desc = "Show git diff overlay",
        },
        {
            "<leader>bd",
            function()
                require("mini.bufremove").delete(0, false)
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>e",
            function()
                local MiniFiles = require("mini.files")
                if not MiniFiles.close() then
                    MiniFiles.open(vim.api.nvim_buf_get_name(0))
                end
            end,
            desc = "Open file explorer",
        },
        {
            "<C-e>",
            "<cmd>Pick oldfiles current_dir=true<CR>",
            desc = "[?] Find recently opened files",
        },
        { "<leader>gf", "<cmd>Pick git_commits path='%'<cr>", desc = "[G]it [F]iles history" },
        { "<leader>hk", "<cmd>Pick keymaps<CR>", desc = "[S]earch [F]iles" },
        { "<leader>f", "<cmd>Pick files<CR>", desc = "[S]earch [F]iles" },
        { "<leader>sf", "<cmd>Pick files<CR>", desc = "[S]earch [F]iles" },
        { "<leader>sh", "<cmd>Pick help<CR>", desc = "[S]earch [H]elp" },
        { "<leader>sg", "<cmd>Pick grep_live<CR>", desc = "[S]earch by [G]rep" },
        { "<leader>/", "<cmd>Pick grep_live<CR>", desc = "[S]earch by [G]rep (/)" },
        { "<leader>sd", "<cmd>Pick scope='document_symbol'<CR>", desc = "[S]earch [D]iagnostics" },
        { "<leader>sl", "<cmd>Pick resume<CR>", desc = "[S]earch [L]ast (resume)" },
        {
            "<leader><space>",
            function()
                local MiniPick = require("mini.pick")
                local buffers_output = vim.api.nvim_exec("buffers", true)
                local cur_buf_id = vim.api.nvim_get_current_buf()
                local items = {}
                for _, l in ipairs(vim.split(buffers_output, "\n")) do
                    local buf_str, name = l:match("^%s*%d+"), l:match('"(.*)"')
                    local buf_id = tonumber(buf_str)
                    local flag = (buf_id == cur_buf_id and "%") or (buf_id == vim.fn.bufnr("#") and "#") or " "
                    local info = vim.fn.getbufinfo(buf_id)
                    local item = {
                        text = name,
                        bufnr = buf_id,
                        flag = flag,
                        info = info[1] or info,
                    }
                    if buf_id ~= cur_buf_id then
                        table.insert(items, item)
                    end
                end

                -- sort by last used (from fzf-lua)
                local future = os.time({ year = 2100, month = 1, day = 1, hour = 0, minute = 00 })
                local get_unixtime = function(buf)
                    if buf.flag == "%" then
                        return future
                    elseif buf.flag == "#" then
                        return future - 1
                    else
                        return buf.info.lastused
                    end
                end
                table.sort(items, function(a, b)
                    return get_unixtime(a) > get_unixtime(b)
                end)

                MiniPick.start({
                    source = {
                        name = "Buffers",
                        items = items,
                    },
                })
            end,
            desc = "[ ] Find existing buffers",
        },
        {
            "<leader>P",
            function()
                local MiniPick = require("mini.pick")

                MiniPick.start({
                    source = {
                        items = require("project_nvim").get_recent_projects(),
                        name = "Projects",
                        choose = function(selected)
                            MiniPick.builtin.files({}, { source = { cwd = selected } })
                        end,
                    },
                })
            end,
            desc = "[S]earch [P]rojects",
        },
    }
end

M.neotest = function()
    return {
        { "<leader>ta", "<cmd>lua require('neotest').run.attach()<CR>", desc = "[t]est [a]ttach" },
        { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "[t]est run [f]ile" },
        { "<leader>tA", "<cmd>lua require('neotest').run.run(vim.uv.cwd())<CR>", desc = "[t]est [A]ll files" },
        { "<leader>tS", "<cmd>lua require('neotest').run.run({ suite = true })<CR>", desc = "[t]est [S]uite" },
        { "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", desc = "[t]est [n]earest" },
        { "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "[t]est [l]ast" },
        { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "[t]est [s]ummary" },
        {
            "<leader>to",
            "<cmd>lua require('neotest').output.open({ enter = true, auto_close = true })<CR>",
            desc = "[t]est [o]utput",
        },
        { "<leader>tO", "<cmd>lua require('neotest').output_panel.toggle()<CR>", desc = "[t]est [O]utput panel" },
        { "<leader>tt", "<cmd>lua require('neotest').run.stop()<CR>", desc = "[t]est [t]erminate" },
        {
            "<leader>td",
            "<cmd>lua require('neotest').run.run({ suite = false, strategy = 'dap' })<CR>",
            desc = "Debug nearest test",
        },
    }
end

M.coverage = function()
    return {
        { "<leader>tcl", ":Coverage<CR>", desc = "[T]est [C]overage [L]oad" },
        { "<leader>tcc", ":CoverageClear<CR>", desc = "[T]est [C]overage [C]lear" },
        { "<leader>tct", ":CoverageToggle<CR>", desc = "[T]est [C]overage [T]oggle" },
        { "<leader>tcs", ":CoverageSummary<CR>", desc = "[T]est [C]overage [S]ummary" },
    }
end

M.mason = function()
    return {
        { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    }
end

return M
