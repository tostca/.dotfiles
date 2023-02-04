-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
-- would overwrite `ensure_installed` with the new value.
-- If you'd rather extend the default config, use the code below instead:
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "graphql",
      "php",
      "sql",
      "erlang",
    },
  },
}
