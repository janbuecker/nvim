-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("user_lastloc", { clear = true }),
    callback = function()
        local exclude = { "gitcommit" }
        local buf = vim.api.nvim_get_current_buf()
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
        "NvimTree",
        "neotest-output",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- vim.api.nvim_create_autocmd("BufRead", {
--     callback = function(opts)
--         vim.api.nvim_create_autocmd("BufWinEnter", {
--             once = true,
--             buffer = opts.buf,
--             callback = function()
--                 local ft = vim.bo[opts.buf].filetype
--                 local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
--                 if
--                     not (ft:match("commit") and ft:match("rebase"))
--                     and last_known_line > 1
--                     and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
--                 then
--                     vim.api.nvim_feedkeys([[g`"]], "nx", false)
--                 end
--             end,
--         })
--     end,
-- })
