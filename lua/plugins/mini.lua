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

    config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()

        local win_config = function()
            local row = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus >= 2 and 1 or 0)
            return { border = "solid", anchor = "SE", row = row }
        end
        require("mini.notify").setup({ window = { config = win_config } })
        vim.notify = require("mini.notify").make_notify()

        require("mini.move").setup()
        require("mini.bracketed").setup()
        require("mini.surround").setup()
        require("mini.trailspace").setup()
        require("mini.bufremove").setup()
        require("mini.cursorword").setup()
        require("mini.tabline").setup()
        require("mini.splitjoin").setup()
        require("mini.misc").setup({ make_global = { "setup_auto_root" } })
        require("mini.misc").setup_auto_root()
        require("mini.git").setup()
        require("mini.diff").setup({
            view = {
                style = "sign",
            },
        })

        require("mini.statusline").setup()

        require("mini.files").setup({
            mappings = {
                go_in_plus = "<Right>",
                go_out_plus = "<Left>",
            },
        })

        require("mini.indentscope").setup({
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
            draw = {
                animation = require("mini.indentscope").gen_animation.none(),
            },
        })

        require("mini.comment").setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        })

        local MiniFiles = require("mini.files")
        local map_split = function(buf_id, lhs, direction)
            local rhs = function()
                -- Make new window and set it as target
                local new_target_window
                vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
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
            end,
        })
    end,
    -- stylua: ignore
    keys = {
        { "<leader>gO", function() require("mini.diff").toggle_overlay() end,      desc = "Show git diff overlay", },
        { "<leader>X",  function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
        {
            "<leader>e",
            function()
                local MiniFiles = require("mini.files")
                if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
            end,
            desc = "Open file explorer"
        }
    },
}
