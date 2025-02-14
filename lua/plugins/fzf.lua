return {
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        config = function()
            local actions = require("fzf-lua.actions")
            local path = require("fzf-lua.path")
            local fzf_lua = require("fzf-lua")

            require("fzf-lua").setup({
                "border-fused",
                fzf_opts = {
                    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
                },
                defaults = {
                    file_icons = "mini",
                    formatter = { "path.dirname_first", v = 2 },
                },
                keymap = {
                    fzf = {
                        true,
                        ["ctrl-q"] = "select-all+accept",
                    },
                },
                winopts = {
                    preview = {
                        default = "bat_native",
                        layout = "vertical",
                    },
                },

                files = {
                    fzf_opts = { ["--tiebreak"] = "end" },
                },
                git = {
                    bcommits = {
                        actions = {
                            ["ctrl-d"] = function(selected, opts)
                                local git_root = path.git_root(opts, true)
                                local file = path.relative_to(path.normalize(vim.fn.expand("%:p")), git_root)
                                actions.git_buf_edit(selected, opts)
                                vim.cmd("vertical diffsplit " .. file)
                            end,
                        },
                    },
                },
                lsp = {
                    finder = {
                        providers = {
                            { "definitions", prefix = fzf_lua.utils.ansi_codes.green("def ") },
                            { "declarations", prefix = fzf_lua.utils.ansi_codes.magenta("decl") },
                            { "implementations", prefix = fzf_lua.utils.ansi_codes.green("impl") },
                            { "typedefs", prefix = fzf_lua.utils.ansi_codes.red("tdef") },
                            { "references", prefix = fzf_lua.utils.ansi_codes.blue("ref ") },
                            { "incoming_calls", prefix = fzf_lua.utils.ansi_codes.cyan("in  ") },
                            { "outgoing_calls", prefix = fzf_lua.utils.ansi_codes.yellow("out ") },
                        },
                    },
                    symbols = {
                        path_shorten = 1,
                    },
                    code_actions = {
                        winopts = {
                            relative = "cursor",
                            row = 1,
                            col = 0,
                            height = 0.4,
                            preview = { vertical = "down:70%" },
                        },
                        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
                        preview_pager = "delta --width=$COLUMNS --hunk-header-style='omit' --file-style='omit'",
                    },
                },
                diagnostics = { file_icons = false, path_shorten = 1 },
            })

            require("fzf-lua").register_ui_select(function(o, items)
                local min_h, max_h = 0.15, 0.70
                local preview = o.kind == "codeaction" and 0.20 or 0
                local h = (#items + 4) / vim.o.lines + preview
                if h < min_h then
                    h = min_h
                elseif h > max_h then
                    h = max_h
                end
                return { winopts = { height = h, width = 0.60, row = 0.40 } }
            end)
        end,
        keys = {
            -- stylua: ignore start
            { "<leader>/", "<cmd>FzfLua live_grep<CR>", desc = "Grep" },
            { "<leader>:", "<cmd>FzfLua command_history<CR>", desc = "Command History" },
            { "<leader><space>", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
            { "<leader>qc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>f", "<cmd>FzfLua files<CR>", desc = "Find Files" },
            { "<C-e>", "<cmd>FzfLua oldfiles cwd_only=true include_current_session=true<CR>", desc = "Recent" },
            -- git
            { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Log" },
            -- Grep
            { "<leader>sg", "<cmd>FzfLua live_grep<CR>", desc = "Grep" },
            { "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { "<leader>sc", "<cmd>FzfLua command_history<CR>", desc = "Command History" },
            { "<leader>sC", "<cmd>FzfLua commands<CR>", desc = "Commands" },
            { "<leader>sd", "<cmd>FzfLua lsp_document_diagnostics<CR>", desc = "Diagnostics" },
            { "<leader>sh", "<cmd>FzfLua help<CR>", desc = "Help Pages" },
            { "<leader>sk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
            { "<leader>sl", "<cmd>FzfLua resume<CR>", desc = "Resume" },
            { "<leader>sm", "<cmd>FzfLua marks<CR>", desc = "Marks" },
            { "<leader>sR", "<cmd>FzfLua resume<CR>", desc = "Resume" },
            -- stylua: ignore end
            {
                "<leader>qp",
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
        },
    },
}
