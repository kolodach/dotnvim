local utils = require("utils")
local get_icon = utils.get_icon
local is_available = utils.is_available
local maps = utils.empty_map_table()

-- GENERAL MAPPINGS
-- maps.n[""] = { "" }
maps.n["j"] = { "gj" }
maps.n["k"] = { "gk" }
maps.n["L"] = { "$" }
maps.n["H"] = { "^" }
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" }

maps.i["jj"] = { "<esc>" }

maps.v["j"] = { "gj" }
maps.v["k"] = { "gk" }
maps.v["L"] = { "$" }
maps.v["H"] = { "^" }

-- Plugin Manager
maps.n["<leader>p"] = { desc = get_icon("Package", 1, true) .. "Packages" }
maps.n["<leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }

-- NeoTree
if is_available("neo-tree.nvim") then
  maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
end

-- Smart Splits
if is_available("smart-splits.nvim") then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
end

-- Telescope
if is_available("telescope.nvim") then
  maps.n["<leader>f"] = { desc = get_icon("Search", 1, true) .. "Find" }
  maps.n["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "Find Files" }
  maps.n["<leader>fw"] = { "<cmd>Telescope live_grep<cr>", desc = "Find Words" }
  maps.n["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Find Buffers" }
  maps.n["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", desc = "Find Help" }
end

utils.set_mappings(maps)
