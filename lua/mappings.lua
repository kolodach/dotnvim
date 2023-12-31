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
maps.n["<Esc>"] = { "<cmd>noh<cr>" }

maps.i["jj"] = { "<esc>" }

maps.v["j"] = { "gj" }
maps.v["k"] = { "gk" }
maps.v["L"] = { "$" }
maps.v["H"] = { "^" }
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
  maps.n["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  maps.n["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
  maps.n["<leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
end

-- Bufferline
if is_available("bufferline.nvim") then
  maps.n["<leader>h"] = { "<cmd>BufferLineCyclePrev<cr>" }
  maps.n["<leader>l"] = { "<cmd>BufferLineCycleNext<cr>" }
  maps.n["<C-x>"] = { "<cmd>bd<cr>", desc = "Kill buffer" }
end

-- Mason
if is_available "mason.nvim" then
  maps.n["<leader>pm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
end

-- Gitsigns
if is_available "gitsigns.nvim" then
  maps.n["<leader>g"] = { desc = get_icon("Git", 1, true) .. "Git" }
  maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
  maps.n["<leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
  maps.n["<leader>gL"] = { function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
  maps.n["<leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
  maps.n["<leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
  maps.n["<leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
  maps.n["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
  maps.n["<leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
  maps.n["<leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
  maps.n["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }
end

-- Comment
if is_available "Comment.nvim" then
  maps.n["<leader>/"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Toggle comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment for selection",
  }
end

-- UI/UX
maps.n["<leader>u"] = { desc = get_icon("Window", 1, true) .. "UI/UX" }
maps.n["<leader>uw"] = {
  function()
    -- vim.cmd("set wrap!")
    vim.o.wrap = not vim.o.wrap
    require("notify")("Line wrap " .. (vim.o.wrap and "enabled" or "disabled"),
      vim.log.levels.INFO, {
        title = "Settings"
      })
  end,
  desc = "Toggle wrap"
}

utils.set_mappings(maps)
