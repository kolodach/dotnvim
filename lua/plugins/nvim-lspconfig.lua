return {
  -- LSP - Quickstart configs for Nvim LSP
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function() return { on_attach = require("lsp").on_attach } end,
    },
    "jay-babu/mason-null-ls.nvim",
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path" }, { "onsails/lspkind.nvim" } }
    } -- cmp sources plugins
  },
  config = function(_, opts)
    local utils = require "utils"
    local get_icon = utils.get_icon
    local signs = {
      { name = "DiagnosticSignError",    text = get_icon "DiagnosticError",        texthl = "DiagnosticSignError" },
      { name = "DiagnosticSignWarn",     text = get_icon "DiagnosticWarn",         texthl = "DiagnosticSignWarn" },
      { name = "DiagnosticSignHint",     text = get_icon "DiagnosticHint",         texthl = "DiagnosticSignHint" },
      { name = "DiagnosticSignInfo",     text = get_icon "DiagnosticInfo",         texthl = "DiagnosticSignInfo" },
      { name = "DapStopped",             text = get_icon "DapStopped",             texthl = "DiagnosticWarn" },
      { name = "DapBreakpoint",          text = get_icon "DapBreakpoint",          texthl = "DiagnosticInfo" },
      { name = "DapBreakpointRejected",  text = get_icon "DapBreakpointRejected",  texthl = "DiagnosticError" },
      { name = "DapBreakpointCondition", text = get_icon "DapBreakpointCondition", texthl = "DiagnosticInfo" },
      { name = "DapLogPoint",            text = get_icon "DapLogPoint",            texthl = "DiagnosticInfo" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, sign)
    end

    require("mason").setup({
      PATH = "prepend",
      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌"
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>"
        }
      },

      max_concurrent_installers = 10
    })
    require("mason-lspconfig").setup()
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Opt to list sources here, when available in mason.
      },
      automatic_installation = false,
      handlers = {},
    })
    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
      }
    })

    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- tsserver = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          on_attach = require("lsp").on_attach
        }
      end,
    }

    -- local cmp = require "cmp"
    --
    -- local function has_words_before()
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    -- end
    --
    -- local function border(hl_name)
    --   return { { "╭", hl_name }, { "─", hl_name }, { "╮", hl_name }, { "│", hl_name }, { "╯", hl_name },
    --     { "─", hl_name }, { "╰", hl_name }, { "│", hl_name } }
    -- end
    --
    -- local lspkind = require('lspkind')
    --
    -- local options = {
    --   preselect = cmp.PreselectMode.None,
    --   confirm_opts = {
    --     behavior = cmp.ConfirmBehavior.Replace,
    --     select = false,
    --   },
    --   formatting = {
    --     format = lspkind.cmp_format({
    --       mode = 'symbol',       -- show only symbol annotations
    --       maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    --       ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    --
    --       -- The function below will be called before any actual modifications from lspkind
    --       -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    --       before = function(entry, vim_item)
    --         return vim_item
    --       end
    --     })
    --   },
    --   completion = {
    --     completeopt = "menu,menuone"
    --   },
    --
    --   window = {
    --     completion = {
    --       border = 'rounded',
    --       winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
    --       zindex = 1001,
    --       scrolloff = 0,
    --       col_offset = 0,
    --       side_padding = 1,
    --       scrollbar = false
    --     },
    --     documentation = {
    --       border = border "CmpDocBorder",
    --       winhighlight = "Normal:CmpDoc"
    --     }
    --   },
    --   mapping = {
    --     ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    --     ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    --     -- ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    --     -- ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    --     ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    --     ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    --     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    --     ["<C-y>"] = cmp.config.disable,
    --     ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    --     ["<CR>"] = cmp.mapping.confirm { select = false },
    --     ["<Tab>"] = cmp.mapping(function(fallback)
    --         if cmp.visible() then
    --           cmp.select_next_item()
    --         elseif has_words_before() then
    --           cmp.complete()
    --         else
    --           fallback()
    --         end
    --     end, { "i", "s" }),
    --     ["<S-Tab>"] = cmp.mapping(function(fallback)
    --         if cmp.visible() then
    --           cmp.select_prev_item()
    --         else
    --           fallback()
    --         end
    --     end, { "i", "s" }),
    --   },
    --   sources = cmp.config.sources {
    --     { name = "nvim_lsp", priority = 1000 },
    --     { name = "buffer",   priority = 750 },
    --     { name = "path",     priority = 500 },
    --   },
    -- }
    --
    -- require("cmp").setup(options)
  end
}
