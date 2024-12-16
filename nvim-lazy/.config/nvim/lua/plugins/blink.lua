return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = {},
        ["<C-y>"] = { "select_and_accept" },
      },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
      },
    },
  },
}
