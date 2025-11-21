local sql_ft = { "sql", "mysql", "plsql" }

-- disable nvim default `sql_completion` plugin to be compatible with blink.cmp's omni
-- while still showing some keywords from the syntax autocomplete sources
vim.g.omni_sql_default_compl_type = "syntax"
vim.g.loaded_sql_completion = true

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = sql_ft,
    })
  end,

  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "sql" } },
  },

  -- blink.cmp integration
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   opts = {
  --     sources = {
  --       default = { "dadbod" },
  --       providers = {
  --         dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "kristijanhusak/vim-dadbod-completion",
  --   },
  -- },

  -- Linters & formatters
  -- {
  --   "mason-org/mason.nvim",
  --   opts = { ensure_installed = { "sqlfluff" } },
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = function(_, opts)
  --     for _, ft in ipairs(sql_ft) do
  --       opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
  --       table.insert(opts.linters_by_ft[ft], "sqlfluff")
  --     end
  --   end,
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.formatters.sqlfluff = {
  --       args = { "format", "--dialect=ansi", "-" },
  --     }
  --     for _, ft in ipairs(sql_ft) do
  --       opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
  --       table.insert(opts.formatters_by_ft[ft], "sqlfluff")
  --     end
  --   end,
  -- },
}
