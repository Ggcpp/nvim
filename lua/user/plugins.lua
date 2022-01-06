local fn = vim.fn

-- --------------------------------------------------------------
-- Install packer.nvim (plugin manager) if not already installed
-- --------------------------------------------------------------
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    }

    vim.notify("Installing packer.nvim (plugin manager)...")
    vim.notify("Please restart Neovim")

    vim.cmd([[packadd packer.nvim]]) -- everything between [[...]] is converted to a literal string
end

-- ------------------------------------------------------------
-- Autocommand that reloads Neovim whenever this file is saved
-- ------------------------------------------------------------
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- -------------------------------------------------------------------------------------------------------
-- Declare a local packer variable but with a protected call (prevent from getting an error on first use)
-- Same as: `local packer = require("packer")` but with checking the return value
-- -------------------------------------------------------------------------------------------------------
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("packer.nvim can not be required", "error")
    return
end

-- --------------------------------------------
-- Configure packer.nvim to use a popup window
-- --------------------------------------------
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- ---------------------
-- Plugins installation
-- ---------------------
return packer.startup(function(use)
    -- Notify
    use "rcarriga/nvim-notify"

    -- Packer manager
    use "wbthomason/packer.nvim"

    -- Colorscheme
    use "NLKNguyen/papercolor-theme"

    -- Telescope
    use { 
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    -- Snippets
    use "L3MON4D3/LuaSnip"

    -- Cmp and Snippets
    use "hrsh7th/nvim-cmp"          -- completion plugin
    use "hrsh7th/cmp-buffer"        -- buffer completion
    use "hrsh7th/cmp-path"          -- path completion
    use "hrsh7th/cmp-cmdline"       -- command line completion
    use "hrsh7th/cmp-nvim-lsp"      -- language server completion
    use "hrsh7th/cmp-nvim-lua"      -- noevim lua api completion
    use "saadparwaiz1/cmp_luasnip"  -- luasnip completion

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer" -- provide an easy to use installer for a lot of servers

    -- ---------------------------------------------------------------
    -- Install and compile all plugins if packer.nvim has been cloned
    -- ---------------------------------------------------------------
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
