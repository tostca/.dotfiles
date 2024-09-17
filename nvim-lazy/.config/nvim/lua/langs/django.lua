return {
  -- add django syntax highlighting djlsp
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "htmldjango" })
    end,
  },
  -- add djlsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        djlsp = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "djlint" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        htmldjango = { "djlint" },
        django = { "djlint" },
        -- html = { "djlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
        django = { "djlint" },
      },
    },
  },
}
