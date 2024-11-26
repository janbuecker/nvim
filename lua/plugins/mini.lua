return {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
    keys = require("config.keymaps").mini(),
    config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()

        require("mini.move").setup()
        require("mini.bracketed").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        require("mini.bufremove").setup()
        require("mini.cursorword").setup()
        require("mini.splitjoin").setup()
        require("mini.git").setup()
        require("mini.comment").setup()
        require("mini.statusline").setup()
        -- require("mini.pairs").setup()
        require("mini.extra").setup()
        require("mini.tabline").setup({
            show_icons = false,
        })

        require("mini.misc").setup({ make_global = { "setup_auto_root" } })
        require("mini.misc").setup_auto_root()

        require("mini.diff").setup({
            view = {
                style = "sign",
            },
        })

        require("mini.indentscope").setup({
            symbol = "│",
            options = { try_as_border = true },
            draw = {
                animation = require("mini.indentscope").gen_animation.none(),
            },
        })

        local spec_treesitter = require("mini.ai").gen_spec.treesitter
        require("mini.ai").setup({
            custom_textobjects = {
                F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                o = spec_treesitter({
                    a = { "@conditional.outer", "@loop.outer" },
                    i = { "@conditional.inner", "@loop.inner" },
                }),
            },
        })

        local MiniFiles = require("mini.files")
        MiniFiles.setup({
            mappings = {
                go_in_plus = "<Right>",
                go_out_plus = "<Left>",
            },
        })

        local map_split = function(buf_id, lhs, direction)
            local rhs = function()
                -- Make new window and set it as target
                local new_target_window
                vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
                    vim.cmd(direction .. " split")
                    new_target_window = vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target_window)
            end

            vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id

                -- Open in split
                map_split(buf_id, "gs", "belowright horizontal")
                map_split(buf_id, "gv", "belowright vertical")

                -- Grep in folder
                vim.keymap.set("n", "gg", function()
                    local cur_entry_path = MiniFiles.get_fs_entry().path
                    local basedir = vim.fs.dirname(cur_entry_path)
                    MiniFiles.close()
                    require("fzf-lua").live_grep({ cwd = basedir })
                end, { buffer = buf_id, desc = "Grep in directory" })

                -- Find in folder
                vim.keymap.set("n", "f", function()
                    local cur_entry_path = MiniFiles.get_fs_entry().path
                    local basedir = vim.fs.dirname(cur_entry_path)
                    MiniFiles.close()
                    require("fzf-lua").files({ cwd = basedir })
                end, { buffer = buf_id, desc = "Grep in directory" })

                -- Find in project
                vim.keymap.set("n", "gf", function()
                    MiniFiles.close()
                    require("fzf-lua").files()
                end, { buffer = buf_id, desc = "Grep in directory" })

                -- Diff with buffer
                vim.keymap.set("n", "dv", function()
                    local cur_entry_path = MiniFiles.get_fs_entry().path
                    vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
                        vim.cmd("vertical diffsplit " .. cur_entry_path)
                    end)
                    MiniFiles.close()
                end, { buffer = buf_id, desc = "Diff with buffer" })
            end,
        })

        -- local win_config = function()
        --     local row = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus >= 2 and 1 or 0)
        --     return { border = "solid", anchor = "SE", row = row }
        -- end
        -- require("mini.notify").setup({ window = { config = win_config } })
        -- vim.notify = require("mini.notify").make_notify()
    end,
}
