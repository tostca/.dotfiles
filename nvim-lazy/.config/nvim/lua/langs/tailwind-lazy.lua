return {
  -- recommended = function()
  --   return LazyVim.extras.wants({
  --     root = {
  --       "tailwind.config.js",
  --       "tailwind.config.cjs",
  --       "tailwind.config.mjs",
  --       "tailwind.config.ts",
  --       "postcss.config.js",
  --       "postcss.config.cjs",
  --       "postcss.config.mjs",
  --       "postcss.config.ts",
  --       ".git",
  --     },
  --   })
  -- end,
  -- -- add tailwind to mason
  -- Below does not work, run the below command to install tailwindcss-language-server v0.0.16
  -- :MasonInstall tailwindcss-language-server@0.0.16
  -- All versions above breaks the language server for everything that is not javascript...
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, { "tailwindcss-language-server@0.0.16" })
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          mason = false,
          -- exclude a filetype from the default_config
          -- filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          -- filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
          filetypes_include = {
            "html",
            "aspnetcorerazor",
            "astro",
            "astro-markdown",
            "blade",
            "clojure",
            "django-html",
            "htmldjango",
            "edge",
            "eelixir", -- vim ft
            "elixir",
            "ejs",
            "erb",
            "eruby", -- vim ft
            "gohtml",
            "gohtmltmpl",
            "haml",
            "handlebars",
            "hbs",
            "html",
            -- 'HTML (Eex)',
            -- 'HTML (EEx)',
            "html-eex",
            "heex",
            "jade",
            "leaf",
            "liquid",
            "markdown",
            "mdx",
            "mustache",
            "njk",
            "nunjucks",
            "php",
            "razor",
            "slim",
            "twig",
            -- css
            "css",
            "less",
            "postcss",
            "sass",
            "scss",
            "stylus",
            "sugarss",
            -- js
            "javascript",
            "javascriptreact",
            "reason",
            "rescript",
            "typescript",
            "typescriptreact",
            -- mixed
            "vue",
            "svelte",
            "templ",
          },
          init_options = {
            userLanguages = {
              elixir = "phoenix-heex",
              eruby = "erb",
              heex = "phoenix-heex",
              svelte = "html",
              -- heex = "html-eex",
              -- elixir = "html-eex",
              surface = "phoenix-heex",
            },
          },
          experimental = {
            classRegex = {
              [[class= "([^"]*)]],
              [[class: "([^"]*)]],
              [[class= '([^"]*)]],
              [[class: '([^"]*)]],
              '~H""".*class="([^"]*)".*"""',
              '~F""".*class="([^"]*)".*"""',
              [[\bclass:\s*'([^']*)']],
              [[\bclass:\s*\"([^"]*)"]],
              -- 'class[:]\\s*"([^"]*)"',
            },
          },
          -- handlers = {
          --   ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
          --     vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
          --   end,
          -- },
          settings = {
            includeLanguages = {
              typescript = "javascript",
              typescriptreact = "html",
              ["html-eex"] = "html",
              ["phoenix-heex"] = "html",
              heex = "html",
              html = "html",
              eelixir = "html",
              elixir = "html",
              elm = "html",
              erb = "html",
              ruby = "html",
              svelte = "html",
              surface = "html",
            },
          },
          setup = {
            tailwindcss = function(_, opts)
              local tw = require("lspconfig.server_configurations.tailwindcss")
              opts.filetypes = opts.filetypes or {}

              -- Add default filetypes
              -- vim.list_extend(opts.filetypes, tw.default_config.filetypes)

              -- Add experimental classRegex
              vim.list_extend(opts.experimental, tw.default_config.experimental)

              -- Add init_options
              vim.list_extend(opts.init_options, tw.default_config.init_options)

              -- -- Remove excluded filetypes
              -- --- @param ft string
              -- opts.filetypes = vim.tbl_filter(function(ft)
              --   return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
              -- end, opts.filetypes)

              -- Add additional filetypes
              -- vim.list_extend(opts.filetypes, opts.filetypes_include or {})
            end,
          },
        },
      },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
        },
        opts = function(_, opts)
          -- original LazyVim kind icon formatter
          local format_kinds = opts.formatting.format
          opts.formatting.format = function(entry, item)
            format_kinds(entry, item) -- add icons
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
          end
        end,
      },
    },
  },
}
