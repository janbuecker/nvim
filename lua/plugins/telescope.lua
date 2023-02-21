local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { "<C-e>", "<cmd>Telescope oldfiles<CR>", { desc = "[?] Find recently opened files" } },
        { "<leader><space>", "<cmd>Telescope buffers<CR>", { desc = "[ ] Find existing buffers" } },

        { "<leader>f", "<cmd>Telescope find_files hidden=true<CR>", { desc = "[S]earch [F]iles" } },
        { "<leader>sf", "<cmd>Telescope find_files hidden=true<CR>", { desc = "[S]earch [F]iles" } },
        { "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" } },
        { "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" } },
        { "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" } },
        { "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" } },
    },
}

M.config = function()
    require("telescope").setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-u>"] = false,
                    ["<C-d>"] = false,
                },
            },
            winblend = 0,

            layout_strategy = "horizontal",
            layout_config = {
                width = 0.95,
                height = 0.85,
                -- preview_cutoff = 120,
                prompt_position = "bottom",

                horizontal = {
                    preview_width = function(_, cols, _)
                        if cols > 200 then
                            return math.floor(cols * 0.4)
                        else
                            return math.floor(cols * 0.6)
                        end
                    end,
                },

                vertical = {
                    width = 0.9,
                    height = 0.95,
                    preview_height = 0.5,
                },

                flex = {
                    horizontal = {
                        preview_width = 0.9,
                    },
                },
            },

            selection_strategy = "reset",
            sorting_strategy = "descending",
            scroll_strategy = "cycle",
        },

        pickers = {
            lsp_document_symbols = {
                layout_strategy = "cursor",
            },
        },

        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        },
    })

    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
end

return M
