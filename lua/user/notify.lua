local title = "Notify"

local status_ok, notify = pcall(require, "notify")
if not status_ok then
    vim.notify("notify can not be required", "error", { title = title })
    return
end

notify.setup({ stages = "fade_in_slide_out", background_colour = "#000000" })

vim.notify = notify
