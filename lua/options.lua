local options = {
  opt = {
    breakindent = true,                                     -- wrap indent to match  line start
    clipboard = "unnamedplus",                              -- connection to the system clipboard
    -- cmdheight = 0, -- hide command line unless needed
    completeopt = { "menu", "menuone", "noselect" },        -- Options for insert mode completion
    copyindent = true,                                      -- copy the previous indentation on autoindenting
    cursorline = true,                                      -- highlight the text line of the cursor
    expandtab = true,                                       -- enable the use of space in tab
    fileencoding = "utf-8",                                 -- file content encoding for the buffer
    fillchars = { eob = " " },                              -- disable `~` on nonexistent lines
    foldenable = true,                                      -- enable fold for nvim-ufo
    foldlevel = 99,                                         -- set high foldlevel for nvim-ufo
    foldlevelstart = 99,                                    -- start with all code unfolded
    foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
    history = 100,                                          -- number of commands to remember in a history table
    ignorecase = true,                                      -- case insensitive searching
    infercase = true,                                       -- infer cases in keyword completion
    laststatus = 3,                                         -- global statusline
    linebreak = true,                                       -- wrap lines at 'breakat'
    mouse = "a",                                            -- enable mouse support
    number = true,                                          -- show numberline
    preserveindent = true,                                  -- preserve indent structure as much as possible
    pumheight = 10,                                         -- height of the pop up menu
    shiftwidth = 2,                                         -- number of space inserted for indentation
    showmode = false,                                       -- disable showing modes in command line
    showtabline = 2,                                        -- always display tabline
    signcolumn = "yes",                                     -- always show the sign column
    splitbelow = true,                                      -- splitting a new window below the current one
    splitright = true,                                      -- splitting a new window at the right of the current one
    tabstop = 2,                                            -- number of space in a tab
    termguicolors = true,                                   -- enable 24-bit RGB color in the TUI
    timeoutlen = 300,                                       -- shorten key timeout length a little bit for which-key
    undofile = true,                                        -- enable persistent undo
    updatetime = 300,                                       -- length of time to wait before triggering the plugin
    virtualedit = "block",                                  -- allow going past end of line in visual block mode
    wrap = true,                                            -- enable wrapping of lines longer than the width of window
    writebackup = false,                                    -- disable making a backup before overwriting a file  },
  },
  g = {
    mapleader = " ",      -- set leader key
    maplocalleader = ",", -- set default local leader key
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available)
    signcolumn = "yes",   -- always show the sign column
    showtabline = 2,      -- always display tabline
    shiftwidth = 2,       -- number of space inserted for indentation
    autoformat = true,    -- format on save
    log_levels = {        -- log level constants
      DEBUG = "DEBUG",
      ERROR = "ERROR",
      INFO = "INFO",
      TRACE = "TRACE",
      WARN = "WARN"
    }
  }
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
