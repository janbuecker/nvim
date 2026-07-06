require("lint").linters_by_ft = {
    dockerfile = { "hadolint" },
    go = { "golangcilint" },
    json = { "jsonlint" },
    php = { "php", "phpstan" },
    proto = { "buf_lint" },
    sh = { "shellcheck" },
    twig = { "twig-cs-fixer" },
}

local timer
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
    callback = function()
        if timer then
            timer:stop()
            timer:close()
        end
        timer = vim.uv.new_timer()
        timer:start(
            100,
            0,
            vim.schedule_wrap(function()
                if timer then
                    timer:close()
                    timer = nil
                end
                require("lint").try_lint()
            end)
        )
    end,
})
