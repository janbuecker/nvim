return {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
        { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
        { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
        { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
        "https://codeberg.org/FelipeLema/cmp-async-path",
    },
    config = function()
        -- nvim-cmp setup
        local cmp = require("cmp")
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local hasCopilot, copilot = pcall(require, "copilot.suggestion")

        cmp.setup({
            performance = {
                debounce = 0,
            },
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
                    if hasCopilot and copilot.is_visible() then
                        copilot.accept()
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

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end,
}
