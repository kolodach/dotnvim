return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    {
      "jay-babu/mason-null-ls.nvim",
      cmd = { "NullLsInstall", "NullLsUninstall" },
      opts = { handlers = {} },
    },
  },
}
