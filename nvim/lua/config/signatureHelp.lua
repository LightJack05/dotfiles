vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("auto_signature_help", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local sig = client and client.server_capabilities.signatureHelpProvider
        if not sig then return end
        if vim.b[args.buf].auto_sighelp then return end -- don't stack across clients
        vim.b[args.buf].auto_sighelp = true

        local triggers = sig.triggerCharacters or { "(", "," }
        vim.api.nvim_create_autocmd("TextChangedI", {
            buffer = args.buf,
            callback = function()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local char = vim.api.nvim_get_current_line():sub(col, col)
                if vim.tbl_contains(triggers, char) then
                    vim.lsp.buf.signature_help({
                        focusable = false,
                        close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
                        border = "rounded",
                    })
                end
            end,
        })
    end,
})
