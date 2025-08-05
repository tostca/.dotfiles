return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- Disable scrolling animations
    },
    explorer = {},
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
        },
      },
    },
  },
}
