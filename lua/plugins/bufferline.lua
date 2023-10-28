return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = function()
    local buffelrline = require("bufferline")
    return {
      options = {
        offsets = {
          {
				    filetype = "neo-tree",
				    text = "File Explorer",
				    highlight = "Directory",
				    text_align = "left",
				  }
        },
        separator_style = {nil, nil},
        style_preset = {
          buffelrline.style_preset.no_italic,
        },
      }
    }
  end
}
