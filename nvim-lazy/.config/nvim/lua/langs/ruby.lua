local formatter = vim.g.lazyvim_ruby_formatter or "rubocop"

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "ruby",
      root = "Gemfile",
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ruby" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Install the gem. There's no need to require it, since the server is used as a standalone executable.
        -- group :development do
        --   gem "ruby-lsp", require: false
        -- end
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
        },
        -- Install the gem. There's no need to require it, since the server is used as a standalone executable.
        -- group :development do
        --   gem "rubocop", require: false
        -- end
        -- Start a terminal, in the project root run: `ruby_lsp`
        rubocop = {},
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
        sorbet = {},
        stimulus_ls = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "erb-formatter", "erb-lint" } },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "suketa/nvim-dap-ruby",
      config = function()
        require("dap-ruby").setup()
      end,
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = { formatter },
        eruby = { "erb-format" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          -- rspec_cmd = function()
          --   return vim.tbl_flatten({
          --     "bundle",
          --     "exec",
          --     "rspec",
          --   })
          -- end,
        },
      },
    },
  },
}
