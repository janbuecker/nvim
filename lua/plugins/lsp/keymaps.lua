local M = {}

M.on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>lr", vim.lsp.buf.rename, "[LSP] Rename")
    nmap("<leader>la", vim.lsp.buf.code_action, "[LSP] Code Action")

    nmap("gd", "<cmd>lua require('fzf-lua').lsp_definitions({jump_to_single_result = true})<CR>", "[G]oto [D]efinition")
    nmap(
        "gr",
        "<cmd>lua require('fzf-lua').lsp_references({jump_to_single_result = true, ignore_current_line = true})<CR>",
        "[G]oto [R]eferences"
    )
    nmap(
        "gI",
        "<cmd>lua require('fzf-lua').lsp_implementations({jump_to_single_result = true})<CR>",
        "[G]oto [I]mplementation"
    )
    nmap(
        "<leader>D",
        "<cmd>lua require('fzf-lua').lsp_type_definitions({jump_to_single_result = true})<CR>",
        "Type [D]efinition"
    )
    nmap("<leader>ds", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", "[D]ocument [S]ymbols")
    nmap("<leader>ws", "<cmd>lua require('fzf-lua').lsp_dynamic_workspace_symbols()<CR>", "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

return M
