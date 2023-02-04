local entries = {
  -- add elixir to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "elixir", "eex", "heex" })
    end,
  },

  -- add endwise for automatic end insertion
  -- {
  --   "RRethy/nvim-treesitter-endwise",
  --   event = "BufReadPost",
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     endwise = {
  --       enable = true,
  --     },
  --   },
  -- },

  -- add elixir to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "elixir-ls" })
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 1000 },
      servers = {
        elixirls = {
          settings = {
            elixirLS = {
              filetypes = { "elixir", "eelixir", "heex", "eex", "surface" },
              dialyzerEnabled = false,
              fetchDeps = false,
              enableTestLenses = true,
            },
          },
        },
      },
    },
  },
}

table.insert(entries, {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local null_ls = require("null-ls")

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    opts.sources = vim.list_extend(opts.sources, {
      formatting.mix,
      diagnostics.credo,
    })
  end,
})

return entries
