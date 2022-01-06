-- ------------------------------------------------------------------------------------------------------
-- Get nvim-lspconfig module (we not use it directly, but it needs to be accessible for server's setup)
--
-- Nvim-lspconfig:  Provide four primary functionalities:
--                      -   default launch commands, initialization options,
--                          and settings for each server.
--
--                      -   a root directory resolver which attempts to detect the root of your project.
--
--                      -   an autocommand mapping that either launches a new language server or
--                          attempts to attach a language server to each opened buffer
--                          if it falls under a tracked project.
--
--                      -   utility commands such as LspInfo, LspStart, LspStop, and LspRestart for
--                          managing language server instances.
-- ------------------------------------------------------------------------------------------------------
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("lspconfig can not be required", "error")
    return
end

-- 
require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
