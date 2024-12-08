return {
  {
    "yetone/avante.nvim",
    init = function()
      require("avante_lib").load()
    end,
    event = "VeryLazy",
    opts = {
      hints = { enabled = false },
      -- provider = "openai",
      -- openai = {
      --   endpoint = "http://localhost:8080/v1",
      --   -- endpoint = "http://localhost:11434/v1", -- doesn't work as well
      --   model = "deepseek-coder-v2-lite-instruct",
      --   temperature = 0,
      --   max_tokens = 4096,
      --   ["local"] = true,
      -- },
    },
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
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
