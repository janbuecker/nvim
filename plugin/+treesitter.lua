vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { tf = "terraform" } })
vim.filetype.add({ extension = { gotmpl = "gotmpl" } })
vim.filetype.add({ extension = { html = "html" } })

local parsers = {
    "bash",
    "dockerfile",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "hcl",
    "html",
    "http",
    "json",
    "lua",
    "luadoc",
    "php",
    "phpdoc",
    "proto",
    "regex",
    "templ",
    "terraform",
    "twig",
    "yaml",
}

require("nvim-treesitter").setup({})
require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not vim.tbl_contains(parsers, lang) then
            return
        end

        pcall(vim.treesitter.start, ev.buf)

        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
