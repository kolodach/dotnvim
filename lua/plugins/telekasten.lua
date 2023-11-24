return {
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local notes_dir = os.getenv('NOTES_DIR')
      require('telekasten').setup({
        home = notes_dir,
        -- markdown file extension
        extension = '.md',
        image_link_style = 'markdown',
        rename_update_links = true,
      })
    end
  },
}
