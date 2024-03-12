return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({
                fzf_opts = {
                    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
                },
                defaults = {
                    copen = function()
                        require("trouble").open("quickfix")
                    end,
                },
                keymap = {
                    fzf = {
                        ["ctrl-q"] = "select-all+accept",
                    },
                },
            })
        end,
        keys = {
            { "<C-e>", "<cmd>FzfLua oldfiles<CR>", { desc = "[?] Find recently opened files" } },
            { "<leader><space>", "<cmd>FzfLua buffers<CR>", { desc = "[ ] Find existing buffers" } },

            { "<leader>hk", "<cmd>FzfLua keymaps<CR>", { desc = "[S]earch [F]iles" } },
            { "<leader>f", "<cmd>FzfLua files<CR>", { desc = "[S]earch [F]iles" } },
            { "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "[S]earch [F]iles" } },
            { "<leader>sh", "<cmd>FzfLua help_tags<CR>", { desc = "[S]earch [H]elp" } },
            { "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "[S]earch by [G]rep" } },
            { "<leader>sd", "<cmd>FzfLua diagnostics_document<CR>", { desc = "[S]earch [D]iagnostics" } },
            { "<leader>sl", "<cmd>FzfLua resume<CR>", { desc = "[S]earch [L]ast (resume)" } },
            { "<leader>sr", "<cmd>FzfLua resume<CR>", { desc = "[S]earch [R]esume" } },
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
                { desc = "[S]earch [P]rojects" },
            },
        },
    },
}
