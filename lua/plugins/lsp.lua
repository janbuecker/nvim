local Util = require("util")

local icons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },

        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = function(diagnostic)
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end,
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.Error,
                        [vim.diagnostic.severity.WARN] = icons.Warn,
                        [vim.diagnostic.severity.HINT] = icons.Hint,
                        [vim.diagnostic.severity.INFO] = icons.Info,
                    },
                },
            },
            capabilities = {},
            servers = {},
            setup = {},
        },

        config = function(_, opts)
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            Util.on_attach(function(client, bufnr)
                require("config.keymaps").lsp_attach(client, bufnr)
            end)

            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local has_blink, blink = pcall(require, "blink.cmp")

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                has_blink and blink.get_lsp_capabilities() or {},
                opts.capabilities or {}
            )

            local servers = opts.servers
            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed, handlers = { setup } })
        end,
    },

    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = require("config.keymaps").mason(),
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {},
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            hint_enable = false,
        },
    },
}
