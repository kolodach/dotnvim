return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = function()
    local utils = require "utils"
    local get_icon = utils.get_icon
    return {
      default_component_configs = {
        indent = { padding = 0 },
        icon = {
          folder_closed = get_icon "FolderClosed",
          folder_open = get_icon "FolderOpen",
          folder_empty = get_icon "FolderEmpty",
          folder_empty_open = get_icon "FolderEmpty",
          default = get_icon "DefaultFile",
        },
        modified = { symbol = get_icon "FileModified" },
        git_status = {
          symbols = {
            added = get_icon("GitAdd"),
            deleted = get_icon("GitDelete"),
            modified = get_icon("GitChange"),
            renamed = get_icon("GitRenamed"),
            untracked = get_icon("GitUntracked"),
            ignored = get_icon("GitIgnored"),
            unstaged = get_icon("GitUnstaged"),
            staged = get_icon("GitStaged"),
            conflict = get_icon("GitConflict"),
          },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
      }
    }
  end
}

