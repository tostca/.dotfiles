return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "kotlin" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "kotlin-debug-adapter", "gradle-language-server" })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       kotlin_language_server = {
  --         default_config = {
  --           cmd = {
  --             "/Users/tonystenberg/personal/kotlin-language-server/server/build/install/server/bin/kotlin-language-server",
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
