-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local Util = require("lazyvim.util")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set(
--   "n",
--   "<leader>rs",
--   "<cmd>source ~/.config/nvim/lua/snippets/elixir.lua<CR>",
--   { desc = "Reload Lua Snippets" }
-- )

-- yq commands to convert YML to JSON and JSON to YML.
vim.keymap.set("n", "<leader>cj", "<cmd>%!yq -o=json '.'<CR>", { desc = "Convert YAML to JSON" })
vim.keymap.set("n", "<leader>cy", "<cmd>%!yq -P '.'<CR>", { desc = "Convert JSON to YAML" })

-- Toggle conceallevel with max value of 2
-- Obsidian plugin works best with 1 or 2
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
-- vim.keymap.set("n", "<leader>uc", function()
--   Util.toggle("conceallevel", false, { 0, conceallevel })
-- end, { desc = "Toggle Conceal" })

-- Obsidian
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Obsidian find notes by tag" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Obsidian create new note in inbox" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Obsidian create new daily zettlekasten" })

-- Diffing
vim.keymap.set("n", "<leader>cw", "<cmd>windo diffthis<CR>", { desc = "Start diff for open windows" })
-- Could also use <cmd>windo diffoff<CR>
vim.keymap.set("n", "<leader>cW", "<cmd>diffoff!<CR>", { desc = "Stop diff for open windows" })

-- Copilot
vim.keymap.set("n", "<leader>ac", function()
  require("copilot.suggestion").toggle_auto_trigger()
  local state = vim.b.copilot_suggestion_auto_trigger
  vim.notify("Copilot: Auto Trigger " .. (state and "Enabled" or "Disabled"))
end, { desc = "Copilot toggle suggestion auto trigger" })
