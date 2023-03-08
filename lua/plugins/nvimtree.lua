local M = {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>e", ":NvimTreeToggle<CR>", { desc = "[E]xplorer" } },
    },
}

M.config = function()
    require("nvim-web-devicons").setup()

    function start_telescope(node, telescope_mode)
        local abspath = node.link_to or node.absolute_path
        local is_folder = node.open ~= nil
        local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
        require("telescope.builtin")[telescope_mode]({
            cwd = basedir,
            hidden = true,
        })
    end

    local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "gtf", function()
            local node = api.tree.get_node_under_cursor()
            start_telescope(node, "find_files")
        end, opts("telescope_find_files"))

        vim.keymap.set("n", "gtg", function()
            local node = api.tree.get_node_under_cursor()
            start_telescope(node, "live_grep")
        end, opts("telescope_live_grep"))
    end

    require("nvim-tree").setup({
        hijack_cursor = true,
        prefer_startup_root = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true,
        },
        modified = {
            enable = true,
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        select_prompts = true,
        on_attach = on_attach,
        view = {
            width = 40,
        },
        renderer = {
            highlight_git = true,
            highlight_modified = "name",
            icons = {
                git_placement = "after",
            },
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                restrict_above_cwd = true,
            },
            open_file = {
                window_picker = {
                    enable = false,
                },
            },
        },
    })
end

return M
