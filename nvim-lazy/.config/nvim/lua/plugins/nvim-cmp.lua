return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    opts.mapping["<CR>"] = nil
  end,
  keys = {
    -- disable the keymap to select
    { "<CR>", false },

    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-y>"] = require("cmp").mapping.confirm({ select = true }),
  },
}
