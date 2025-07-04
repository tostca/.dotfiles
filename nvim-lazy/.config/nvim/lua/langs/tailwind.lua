return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "sass",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
            "erb",
            "eruby",
            "heex",
            "elixir",
            "surface",
            "ruby",
          },
          init_options = {
            userLanguages = {
              elixir = "phoenix-heex",
              heex = "phoenix-heex",
              erb = "html",
              eruby = "html",
              surface = "phoenix-heex",
              ruby = "html",
            },
          },
          settings = {
            includeLanguages = {
              erb = "html",
              eruby = "html",
              heex = "html",
              ["phoenix-heex"] = "html",
              ruby = "html",
              elixir = "html",
              surface = "html",
            },
          },
          experimental = {
            classRegex = {
              [[class= "([^"]*)]],
              [[class: "([^"]*)]],
              [[class= '([^']*)]],
              [[class: '([^']*)]],
              '~H""".*class="([^"]*)".*"""',
              '~F""".*class="([^"]*)".*"""',
              [[\bclass:\s*'([^']*)']],
              [[\bclass:\s*\"([^"]*)"]],
            },
          },
        },
      },
    },
  },
}
