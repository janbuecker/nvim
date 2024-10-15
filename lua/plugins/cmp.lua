return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "https://codeberg.org/FelipeLema/cmp-async-path",
        {
            "hrsh7th/cmp-cmdline",
            keys = { ":" },
            config = function()
                local cmp = require("cmp")

                -- `:` cmdline setup.
                cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "async_path" },
                    }, {
                        {
                            name = "cmdline",
                            option = {
                                ignore_cmds = { "Man", "!" },
                            },
                        },
                    }),
                })
            end,
        },
    },
    config = function()
        -- nvim-cmp setup
        local cmp = require("cmp")
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            completion = {
                keyword_length = 1,
            },
            experimental = {
                ghost_text = false,
                native_menu = false,
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(_, item)
                    local icon, hl = require("mini.icons").get("lsp", item.kind)
                    item.kind = icon .. " " .. item.kind
                    item.kind_hl_group = hl
                    return item
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local confirm_opts = {
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = false,
                        }
                        local is_insert_mode = function()
                            return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
                        end
                        if is_insert_mode() then -- prevent overwriting brackets
                            confirm_opts.behavior = cmp.ConfirmBehavior.Insert
                        end
                        if cmp.confirm(confirm_opts) then
                            return -- success, exit early
                        end
                    end
                    fallback() -- if not exited early, always fallback
                end),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    local copilot_keys = vim.fn["copilot#Accept"]()

                    if copilot_keys ~= "" and type(copilot_keys) == "string" then
                        vim.api.nvim_feedkeys(copilot_keys, "i", true)
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = {
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, _)
                        return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
                    end,
                },
                { name = "async_path" },
            },
        })
    end,
}
