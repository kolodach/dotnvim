local utils = require("utils")

M = {}

M.on_attach = function(client, bufnr)
  local lsp_mappings = require("utils").empty_map_table()

  if client.supports_method "textDocument/codeAction" then
    lsp_mappings.n["<leader>la"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
    }
    lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]


    utils.set_mappings(lsp_mappings, { buffer = bufnr })
  end
end

return M
