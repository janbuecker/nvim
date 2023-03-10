return {
    {
        "catppuccin/nvim",
        enabled = false,
        lazy = false,
        priority = 999,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    nvimtree = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false,
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                    },
                },
            })

            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        enabled = true,
        priority = 999,
        config = function()
            vim.cmd.colorscheme("kanagawa")
        end,
    },
    {
        "folke/tokyonight.nvim",
        enabled = false,
        lazy = false,
        priority = 999,
        config = function()
            local tokyonight = require("tokyonight")
            tokyonight.setup({
                style = "moon",
                sidebars = {
                    "qf",
                    "vista_kind",
                    "terminal",
                    "spectre_panel",
                    "NeogitStatus",
                    -- "help",
                    "startuptime",
                    "Outline",
                },
                transparent = false,
                styles = {},
                on_colors = function(c) end,
                on_highlights = function(hl, c)
                    -- make the current line cursor orange
                    hl.CursorLineNr = { fg = c.orange, bold = true }

                    if true then
                        -- borderless telescope
                        local prompt = "#2d3149"
                        hl.TelescopeNormal = {
                            bg = c.bg_dark,
                            fg = c.fg_dark,
                        }
                        hl.TelescopeBorder = {
                            bg = c.bg_dark,
                            fg = c.bg_dark,
                        }
                        hl.TelescopePromptNormal = {
                            bg = prompt,
                        }
                        hl.TelescopePromptBorder = {
                            bg = prompt,
                            fg = prompt,
                        }
                        hl.TelescopePromptTitle = {
                            bg = c.fg_gutter,
                            fg = c.orange,
                        }
                        hl.TelescopePreviewTitle = {
                            bg = c.bg_dark,
                            fg = c.bg_dark,
                        }
                        hl.TelescopeResultsTitle = {
                            bg = c.bg_dark,
                            fg = c.bg_dark,
                        }
                    end
                end,
            })

            tokyonight.load()
        end,
    },
}
