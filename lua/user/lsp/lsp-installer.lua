local title = "Nvim-lsp-installer"

-- ---------------------------------------------------------------
-- Get nvim-lsp-installer module
-- 
-- Nvim-lsp-installer:  Provide methods to automatically install
--                      update, uninstall and also setup servers.
-- ---------------------------------------------------------------
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    vim.notify("nvim-lsp-installer can not be required", "error", { title = title })
    return
end

-- ------------------------------------------------------
-- Install some servers if they're not already installed
-- ------------------------------------------------------
local servers = {
    "pyright",
    "ccls"
}

for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
        vim.notify("Installing `" .. name .. "` (lsp server)...", "info", { title = title })
        server:install()

        if name == "pyright" then
            vim.notify("Npm is required to install the server", "info", { title = "Pyright" })
        elseif name == "ccls" then
            vim.notify("The installation may take several minutes!", "warn", { title = "Ccls" })
        end
    end
end

-- --------------------
-- Set servers options
-- --------------------
-- Registers a callback to be executed each time a server is ready to be initiated.
lsp_installer.on_server_ready(function(server)
    local opts = {
        --on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities
    }

    if server.name == "ccls" then
        local ccls_opts = require("user.lsp.settings.ccls")
        opts = vim.tbl_deep_extend("force", ccls_opts, opts)
    elseif server.name == "pyright" then
        local pyright_opts = require("user.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    server:setup(opts) -- the same as lspconfig's setup function
end)
