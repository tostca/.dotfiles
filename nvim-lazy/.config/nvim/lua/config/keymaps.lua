-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set(
  "n",
  "<leader>rs",
  "<cmd>source ~/.config/nvim/lua/snippets/elixir.lua<CR>",
  { desc = "Reload Lua Snippets" }
)

-- Dadbod database plugin
vim.keymap.set("n", "<leader>at", "<cmd>DBUIToggle<CR>", { desc = "Database UI Toggle" })
vim.keymap.set("n", "<leader>aa", "<cmd>DBUIAddConnection<CR>", { desc = "Database UI Add Connection" })

-- yq commands to convert YML to JSON and JSON to YML.
vim.keymap.set("n", "<leader>cj", "<cmd>%!yq -o=json '.'<CR>", { desc = "Convert YAML to JSON" })
vim.keymap.set("n", "<leader>cy", "<cmd>%!yq -P '.'<CR>", { desc = "Convert JSON to YAML" })
