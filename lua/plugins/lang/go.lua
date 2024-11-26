return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.filetype.add({ extension = { templ = "templ" } })

            vim.list_extend(opts.ensure_installed, {
                "go",
                "gomod",
                "gowork",
                "gosum",
                "gotmpl",
                "templ",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                templ = {},
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                fieldalignment = false,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            usePlaceholders = false,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            semanticTokens = true,
                        },
                    },
                },
            },
            setup = {
                gopls = function(_, opts)
                    -- workaround for gopls not supporting semanticTokensProvider
                    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
                    require("util").on_attach(function(client, _)
                        if client.name == "gopls" then
                            if not client.server_capabilities.semanticTokensProvider then
                                local semantic = client.config.capabilities.textDocument.semanticTokens
                                client.server_capabilities.semanticTokensProvider = {
                                    full = true,
                                    legend = {
                                        tokenTypes = semantic.tokenTypes,
                                        tokenModifiers = semantic.tokenModifiers,
                                    },
                                    range = true,
                                }
                            end
                        end
                    end)
                    -- end workaround
                end,
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
                go = { "gofumpt", "goimports", "gci", "golines" },
            })

            opts.formatters = vim.tbl_deep_extend("force", opts.formatters, {
                gci = {
                    args = {
                        "write",
                        "--skip-generated",
                        "-s",
                        "Standard",
                        "-s",
                        "Default",
                        "-s",
                        "Prefix(gitlab.shopware.com)",
                        "--skip-vendor",
                        "$FILENAME",
                    },
                },
                goimports = {
                    args = { "-srcdir", "$FILENAME" },
                },
                golines = {
                    -- golines will use goimports as base formatter by default which is slow.
                    -- see https://github.com/segmentio/golines/issues/33
                    prepend_args = {
                        "--base-formatter=gofumpt",
                        "--ignore-generated",
                        -- "--tab-len=1",
                        -- "--max-len=120",
                    },
                },
            })

            -- let gopls run goimports
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    local params = vim.lsp.util.make_range_params()
                    params.context = { only = { "source.organizeImports" } }
                    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                    for cid, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                vim.lsp.util.apply_workspace_edit(r.edit, enc)
                            end
                        end
                    end
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = function(_, opts)
            opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft, {
                go = { "golangcilint" },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "gopls",
                "gci",
                "gofumpt",
                "golines",
                "goimports",
            })
        end,
    },
    -- Testing
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-go",
        },
        opts = function(_, opts)
            opts.adapters = vim.tbl_deep_extend("force", opts.adapters, {
                require("neotest-go")({
                    experimental = {
                        test_table = true,
                    },
                    args = {
                        "-count=1",
                        "-timeout=60s",
                        "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
                    },
                }),
            })
        end,
    },
}
