local M = {}

local utils = require("utils")
local get_icon = utils.get_icon

local function add_buffer_autocmd(augroup, bufnr, autocmds)
  if not vim.tbl_islist(autocmds) then autocmds = { autocmds } end
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if not cmds_found or vim.tbl_isempty(cmds) then
    vim.api.nvim_create_augroup(augroup, { clear = false })
    for _, autocmd in ipairs(autocmds) do
      local events = autocmd.events
      autocmd.events = nil
      autocmd.group = augroup
      autocmd.buffer = bufnr
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

M.on_attach = function(client, bufnr)
  local maps = utils.empty_map_table()
  local is_available = utils.is_available
  maps.n["<leader>l"] = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" }
  maps.n["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
  maps.n["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
  maps.n["<leader>la"] = {
    function() vim.lsp.buf.code_action() end,
    desc = "LSP code action",
  }
  maps.v["<leader>la"] = maps.n["<leader>la"]
  if client.supports_method "textDocument/formatting" then
    maps.n["<leader>lf"] = {
      function()
        vim.lsp.buf.format({
          format_on_save = { enabled = true }, disabled = {}
        })
      end,
      desc = "Format buffer",
    }
    maps.v["<leader>lf"] = maps.n["<leader>lf"]

    local autoformat = vim.g.autoformat or false
    if autoformat then
      add_buffer_autocmd("lsp_auto_format", bufnr, {
        events = "BufWritePre",
        desc = "autoformat on save",
        callback = function()
          if not (vim.g.autoformat or false) then return end
          vim.lsp.buf.format({
            format_on_save = { enabled = true }, disabled = {}
          })
        end,
      })
    end
    maps.n["<leader>uf"] = {
      function()
        vim.g.autoformat = not vim.g.autoformat
        require("notify")("Autoformatting " .. (vim.g.autoformat and "enabled" or "disabled"),
          vim.log.levels.INFO, {
            title = "Settings"
          })
      end,
      desc = "Toggle autoformatting (global)",
    }
  end

  if client.supports_method "textDocument/definition" then
    maps.n["gd"] = {
      function() vim.lsp.buf.definition() end,
      desc = "Show the definition of current symbol",
    }
  end

  if client.supports_method "textDocument/references" then
    maps.n["gr"] = {
      function() vim.lsp.buf.references() end,
      desc = "References of current symbol",
    }
    maps.n["<leader>lR"] = {
      function() vim.lsp.buf.references() end,
      desc = "Search references",
    }
  end

  if client.supports_method "textDocument/rename" then
    maps.n["<leader>lr"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    }
  end

  if client.supports_method "textDocument/signatureHelp" then
    maps.n["<leader>lh"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
    }
  end

  if client.supports_method "textDocument/typeDefinition" then
    maps.n["gy"] = {
      function() vim.lsp.buf.type_definition() end,
      desc = "Definition of current type",
    }
  end

  if client.supports_method "textDocument/hover" then
    -- TODO: Remove mapping after dropping support for Neovim v0.9, it's automatic
    if vim.fn.has "nvim-0.10" == 0 then
      maps.n["K"] = {
        function() vim.lsp.buf.hover() end,
        desc = "Hover symbol details",
      }
    end
  end

  if client.supports_method "textDocument/implementation" then
    maps.n["gI"] = {
      function() vim.lsp.buf.implementation() end,
      desc = "Implementation of current symbol",
    }
  end

  if is_available "telescope.nvim" then -- setup telescope mappings if available
    if maps.n.gd then maps.n.gd[1] = function() require("telescope.builtin").lsp_definitions() end end
    if maps.n.gI then
      maps.n.gI[1] = function() require("telescope.builtin").lsp_implementations() end
    end
    if maps.n.gr then maps.n.gr[1] = function() require("telescope.builtin").lsp_references() end end
    if maps.n["<leader>lR"] then
      maps.n["<leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
    end
    if maps.n.gy then
      maps.n.gy[1] = function() require("telescope.builtin").lsp_type_definitions() end
    end
    if maps.n["<leader>lG"] then
      maps.n["<leader>lG"][1] = function()
        vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
          if query then
            -- word under cursor if given query is empty
            if query == "" then query = vim.fn.expand "<cword>" end
            require("telescope.builtin").lsp_workspace_symbols {
              query = query,
              prompt_title = ("Find word (%s)"):format(query),
            }
          end
        end)
      end
    end
  end

  utils.set_mappings(maps, { buffer = bufnr })
end

return M
