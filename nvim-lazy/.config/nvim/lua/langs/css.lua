return {
  -- add cssmodules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "cssmodules_ls" })
    end,
  },

  -- add cssmodules to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "cssmodules-language-server" })
    end,
  },

  -- add cssmodules lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssmodules_ls = {},
      },
    },
  },
}
