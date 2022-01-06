local options = {
    number          = true,
    relativenumber  = true,
    tabstop         = 4,
    shiftwidth      = 4,
    softtabstop     = 4,
    expandtab       = true,
    smartindent     = true,
    hidden          = true,
    swapfile	    = false,
    hlsearch        = false,
    scrolloff       = 10,
    signcolumn      = "yes:1",
    syntax          = "enable",
    termguicolors   = true,
    cursorline      = true,
    wrap            = false,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end
