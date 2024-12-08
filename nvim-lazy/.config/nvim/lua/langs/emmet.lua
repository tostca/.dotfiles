return {

  -- add emmet to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "emmet-ls" })
    end,
  },

  -- add emmet lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_ls = {
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "heex",
            "erb",
            "eruby",
            -- "eex",
            -- "elixir",
            "phoenix-heex",
          },
        },
      },
    },
  },
}
