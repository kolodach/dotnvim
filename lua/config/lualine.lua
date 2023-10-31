return function(_, _)
  local get_icon = require("utils").get_icon

  local function copilot_status()
    local c = require("copilot.client")

    if c.is_disabled() then
      return get_icon("CopilotErr")
    end
    local client = c.get()
    if not client then
      return get_icon("CopilotErr")
    end
    return get_icon("Copilot")
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "catppuccin",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        "filename",
        "searchcount",
      },
      lualine_x = {
        {
          "copilot",
          fmt = copilot_status,
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = {
        "location",
      },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
      "neo-tree",
    },
  })
end
