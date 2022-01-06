local title = "Colorscheme"
local colorscheme = "PaperColor"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme '" .. colorscheme .. "' not found!", "warn", { title = title })
    return
end

-- vim.cmd("highlight Normal guibg=none ctermbg=none")
