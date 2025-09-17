vim.pack.add({
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-cmdline" },
    { src = "https://codeberg.org/FelipeLema/cmp-async-path" },
}, { load = true })

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
    completion = {
        keyword_length = 1,
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
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.config.disable,
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
                fallback()
            end
        end, { "i", "s", "c" }),
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

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
    }),
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
