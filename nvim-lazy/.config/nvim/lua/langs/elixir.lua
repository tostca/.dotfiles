return {
  -- add elixir to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "elixir", "eex", "heex" })
    end,
  },
}
