return {
    -- load luasnips + cmp related in insert mode only
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {{
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = {
          history = true,
          updateevents = "TextChanged,TextChangedI"
      },
      config = function(_, opts)
          require("luasnip").config.set_config(opts)

          -- vscode format
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load {
              paths = vim.g.vscode_snippets_path or ""
          }

          -- snipmate format
          require("luasnip.loaders.from_snipmate").load()
          require("luasnip.loaders.from_snipmate").lazy_load {
              paths = vim.g.snipmate_snippets_path or ""
          }

          -- lua format
          require("luasnip.loaders.from_lua").load()
          require("luasnip.loaders.from_lua").lazy_load {
              paths = vim.g.lua_snippets_path or ""
          }

          vim.api.nvim_create_autocmd("InsertLeave", {
              callback = function()
                  if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and
                      not require("luasnip").session.jump_active then
                      require("luasnip").unlink_current()
                  end
              end
          })
      end
  },
                  {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
                   "hrsh7th/cmp-path"}}, -- cmp sources plugins
  opts = function()
      local cmp = require "cmp"

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end


      local function border(hl_name)
          return {{"╭", hl_name}, {"─", hl_name}, {"╮", hl_name}, {"│", hl_name}, {"╯", hl_name},
                  {"─", hl_name}, {"╰", hl_name}, {"│", hl_name}}
      end

      local options = {
          completion = {
              completeopt = "menu,menuone"
          },

          window = {
              completion = {
                  winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
                  scrollbar = false
              },
              documentation = {
                  border = border "CmpDocBorder",
                  winhighlight = "Normal:CmpDoc"
              }
          },

          snippet = {
              expand = function(args)
                  require("luasnip").lsp_expand(args.body)
              end
          },

          mapping = {
            ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
            ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
            ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable,
            ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
            ["<CR>"] = cmp.mapping.confirm { select = false },
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { "i", "s" }),
          },
          sources = cmp.config.sources {
            { name = "nvim_lsp", priority = 1000 },
            { name = "luasnip", priority = 750 },
            { name = "buffer", priority = 500 },
            { name = "path", priority = 250 },
          },
        }
      return options
  end,
  config = function(_, opts)
      require("cmp").setup(opts)
  end
}
