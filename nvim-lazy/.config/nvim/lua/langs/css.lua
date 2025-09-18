return {
  -- add cssmodules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "scss" })
    end,
  },

  -- add cssmodules to mason
  {
    "mason-org/mason.nvim",
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
