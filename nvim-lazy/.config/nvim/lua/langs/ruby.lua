return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("/home/tony/.local/share/mise/installs/ruby/3.4.4/bin/ruby-lsp") },
          -- cmd = { vim.fn.expand("/home/tony/.local/share/mise/installs/ruby/3.4.1/bin/ruby-lsp") },
          -- init_options = {
          --   -- enabledFeatures = enabledFeatures,
          --   -- enableExperimentalFeatures = true,
          -- },
        },
        stimulus_ls = {},
        -- herb_ls = {},
        -- Sorbet requires `watchmen` to be installed on your system
        -- for macos run `brew install watchman`
        -- for other linux see: https://facebook.github.io/watchman/docs/install#linux
        -- Add below gems to your gem file.
        -- gem 'sorbet-static-and-runtime', :group => [:development, :test]
        -- gem 'tapioca', require: false, :group => [:development, :test]
        -- Run `bundle install`
        -- Test that sorbet works by running the below command.
        -- `bundle exec srb`
        -- To initialize Sorbet in an existing project, run:
        -- bundle exec tapioca init
        -- sorbet = {},
      },
    },
  },
  -- {
  --   "mason-org/mason.nvim",
  --   opts = { ensure_installed = { "herb-language-server" } },
  -- },
}
