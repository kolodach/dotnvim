local M = {}

function M.reload_config()
    -- Save the current buffer and cursor position
    local current_buf = vim.api.nvim_get_current_buf()
    local cursor = vim.fn.getpos('.')

    -- Clear the package.loaded table for your configuration modules
    for key, _ in pairs(package.loaded) do
        if key:match("^" .. cfg) then
            package.loaded[key] = nil
        end
    end

    -- Source your main init.lua file
    dofile(vim.fn.stdpath("config") .. "/init.lua")

    -- Restore the original buffer and cursor position
    vim.api.nvim_set_current_buf(current_buf)
    vim.fn.setpos('.', cursor)

    -- Print notification
    vim.notify("Config reloaded!")
end
