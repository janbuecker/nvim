M = {}

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- : to ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- QuickFix
vim.keymap.set("n", "<C-q>", function()
    require("quicker").toggle()
end)

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

M.blame = function()
    return {
        { "<leader>gb", "<cmd>BlameToggle<CR>", mode = { "n", "x" }, desc = "Git Blame" },
    }
end

M.ripsubstitue = function()
    return {
        { "<leader>sr", "<cmd>RipSubstitute<CR>", mode = { "n", "x" }, desc = " rip substitute" },
        { "<C-r>", "<cmd>RipSubstitute<CR>", mode = { "v" }, desc = " rip substitute" },
        { "<A-r>", "<cmd>RipSubstitute<CR>", mode = { "n", "x" }, desc = " rip substitute" },
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
        {
            "<C-e>",
            "<cmd>FzfLua oldfiles cwd_only=true include_current_session=true<CR>",
            desc = "[?] Find recently opened files",
        },
        { "<leader><space>", "<cmd>FzfLua buffers<CR>", desc = "[ ] Find existing buffers" },

        { "<leader>gf", "<cmd>FzfLua git_bcommits<cr>", desc = "[G]it [F]iles history" },
        { "<leader>hk", "<cmd>FzfLua keymaps<CR>", desc = "[S]earch [F]iles" },
        { "<leader>f", "<cmd>FzfLua files<CR>", desc = "[S]earch [F]iles" },
        { "<leader>sf", "<cmd>FzfLua files<CR>", desc = "[S]earch [F]iles" },
        { "<leader>sh", "<cmd>FzfLua help_tags<CR>", desc = "[S]earch [H]elp" },
        { "<leader>sg", "<cmd>FzfLua live_grep<CR>", desc = "[S]earch by [G]rep" },
        { "<leader>/", "<cmd>FzfLua live_grep<CR>", desc = "[S]earch by [G]rep (/)" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<CR>", desc = "[S]earch [D]iagnostics" },
        { "<leader>sl", "<cmd>FzfLua resume<CR>", desc = "[S]earch [L]ast (resume)" },
        {
            "<leader>P",
            function()
                local fzf_lua = require("fzf-lua")

                fzf_lua.fzf_exec(require("project_nvim").get_recent_projects(), {
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

    nmap("gd", "<cmd>FzfLua lsp_definitions jump1=true<CR>", "[G]oto [D]efinition")
    nmap("grr", "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<CR>", "[G]oto [R]eferences")
    nmap("gri", "<cmd>FzfLua lsp_implementations jump1=true<CR>", "[G]oto [I]mplementation")
    nmap("<leader>D", "<cmd>FzfLua lsp_type_definitions jump1=true<CR>", "Type [D]efinition")
    nmap("gO", "<cmd>FzfLua lsp_document_symbols<CR>", "[D]ocument [S]ymbols")
    nmap("<leader>sd", "<cmd>FzfLua lsp_document_diagnostics<CR>", "[D]ocument [D]iagnostics")
    nmap("<leader>ws", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", "[W]orkspace [S]ymbols")
    nmap("<leader>wd", "<cmd>FzfLua lsp_workspace_diagnostics<CR>", "[W]orkspace [D]iagnostics")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

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
    }
end

M.neotest = function()
    -- stylua: ignore
    return {
        { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
        { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
        { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
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

M.todo = function()
    return {
        { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "[S]earch [T]ODO" },
    }
end

return M
