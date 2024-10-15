return {
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        config = function()
            local actions = require("fzf-lua.actions")
            local path = require("fzf-lua.path")
            local utils = require("fzf-lua.utils")

            require("fzf-lua").setup({
                fzf_opts = {
                    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
                },
                keymap = {
                    fzf = {
                        true,
                        ["ctrl-q"] = "select-all+accept",
                    },
                },
                actions = {
                    files = {
                        true,
                        ["ctrl-d"] = function(selected, opts)
                            actions.vimcmd_entry("vertical diffsplit", selected, opts)
                        end,
                    },
                },
                winopts = {
                    preview = {
                        layout = "vertical",
                    },
                },
                defaults = { file_icons = "mini" },
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
            })
        end,
        keys = require("config.keymaps").fzf(),
    },
}
