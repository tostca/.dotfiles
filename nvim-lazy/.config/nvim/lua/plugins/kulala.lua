return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rco", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy the current request as a curl command" },
    { "<leader>Rci", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste curl from clipboard as http request" },
    { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect the current request" },
  },
}
