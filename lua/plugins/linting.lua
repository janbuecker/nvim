MiniDeps.later(function()
    MiniDeps.add({ source = "mfussenegger/nvim-lint" })

    require("lint").linters_by_ft = {
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
        json = { "jsonlint" },
        php = { "php", "phpstan" },
        proto = { "buf_lint" },
        sh = { "shellcheck" },
        twig = { "twig-cs-fixer" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
            local timer = vim.uv.new_timer()
            timer:start(100, 0, function()
                timer:stop()
                vim.schedule_wrap(function()
                    require("lint").try_lint()
                end)
            end)
        end,
    })
end)
