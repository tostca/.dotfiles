return {
  {
    "yetone/avante.nvim",
    init = function()
      require("avante_lib").load()
    end,
    event = "VeryLazy",
    opts = {
      debug = true,
      provider = "ollama",
      providers = {
        ollama = {
          api_key_name = "",
          endpoint = "http://127.0.0.1:11434",
          model = "tony-qwen32",
          extra_request_body = {
            options = {
              num_ctx = 32768,
              temperature = 0,
            },
          },
          stream = true,
        },
      },
      auto_suggestions_provider = "ollama",
      hints = { enabled = true },
      windows = {
        position = "right",
        width = 40,
      },
    },
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            -- use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
}
