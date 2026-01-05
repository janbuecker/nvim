vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    { src = "https://github.com/folke/ts-comments.nvim" },
}, { load = true })

vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "*",
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" and ev.data.spec.kind ~= "deleted" then
            vim.notify(ev.data.spec.name .. " has been updated. Running TSUpdate...")
            vim.cmd([[ TSUpdate ]])
        end
    end,
})

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { tf = "terraform" } })
vim.filetype.add({ extension = { gotmpl = "gotmpl" } })

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
