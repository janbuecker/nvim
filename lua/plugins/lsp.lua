local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
        "j-hui/fidget.nvim",
    },
}

M.config = function()
    -- Enable the following language servers
    -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
    local servers = {
        'gopls',
        'rust_analyzer',
        'terraformls',
        'tflint',
        'sumneko_lua',
        'yamlls',
        'jsonls',
        'bashls',
        'intelephense',
    }

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end

    -- Setup mason so it can manage external tooling
    require('mason').setup()

    -- Ensure the servers above are installed
    require('mason-lspconfig').setup {
        ensure_installed = servers,
    }

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Make runtime files discoverable to the server
    -- doc: https://github.com/glepnir/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    local lsp_settings = {
        -- lua
        sumneko_lua = {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            }
        },

        jsonls = {
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                },
            },
            setup = {
                commands = {
                    Format = {
                        function()
                            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
                        end,
                    },
                },
            },
        },

        yamlls = {
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    validate = true,
                    schemaStore = {
                        enable = true,
                        url = "https://www.schemastore.org/api/json/catalog.json",
                    },
                    schemas = {
                        kubernetes = {
                            "daemon.{yml,yaml}",
                            "manager.{yml,yaml}",
                            "restapi.{yml,yaml}",
                            "role.{yml,yaml}",
                            "role_binding.{yml,yaml}",
                            "*onfigma*.{yml,yaml}",
                            "*ngres*.{yml,yaml}",
                            "*ecre*.{yml,yaml}",
                            "*eployment*.{yml,yaml}",
                            "*ervic*.{yml,yaml}",
                            "kubectl-edit*.yaml",
                        },
                    },
                },
            },
        },

        gopls = {
            settings = {
                gopls = {
                    experimentalPostfixCompletions = true,
                    gofumpt = true,
                    analyses = {
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                        shadow = true,
                    },
                    semanticTokens = true,
                }
            },
        }
    }

    for _, lsp in ipairs(servers) do
        local options = {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        if lsp_settings[lsp] then
            options = vim.tbl_extend('force', options, lsp_settings[lsp])
        end
        require('lspconfig')[lsp].setup(options)
    end

    require('fidget').setup()
end


return M
