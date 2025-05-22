return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "xmlformatter")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft["xml"] = { "xmlformat" }
      opts.formatters.xmlformat = {
        prepend_args = { "--selfclose", "--indent", "4", "--preserve", "literal" },
      }
    end,
  },
}
