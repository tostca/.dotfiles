require('nvim-tree').setup({
    view = {
        side = "right",
    },
    renderer = {
      icons = {
        webdev_colors = true,
      },
    }
})


vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
