local M = {}

-- --------------------------
-- Setup errors and warnings
-- --------------------------
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" }
    }

    for _, sign in pairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = ""})
    end

    local config = {
        virtual_text = false,
        signs = {
            active = signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = ""
        }
    }

    -- configure how errors and warnings proceed (provide by nvim itself)
    vim.diagnostic.config(config)
end

--local function lsp_highlight_document(client)
--    -- Set autocommands conditional on server_capabilities
--  if client.resolved_capabilities.document_highlight then
--    vim.api.nvim_exec(
--      [[
--      augroup lsp_document_highlight
--        autocmd! * <buffer>
--        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--      augroup END
--    ]],
--      false
--    )
--  end
--end

--local function lsp_keymaps(bufnr)
--    local opts = { noremap = true, silent = true }
--end

-- -------------------
-- On_attach function
-- -------------------
M.on_attach = function(client, bufnr)
--    lsp_keymaps(bufnr)
--    lsp_highlight_document(client)
end

-- -------------------------------------------------------------------------------------------------------------
-- Set capabilities (nvim-cmp supports LSP capabilities): it will advertise capabilities to the LSP server
-- 
-- Capabilities:    They are flags which are exchanged between the client and the server during initialization,
--                  so the client (nvim-cmp`-lsp`) can signal to the server what he can handle.
-- -------------------------------------------------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    vim.notify("cmp_nvim_lsp can not be required", "error")
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

-- --------------
-- Return module
-- --------------
return M
