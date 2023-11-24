return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      timeout = 3000,
      background_colour = "#000000",
    })
  end
}
