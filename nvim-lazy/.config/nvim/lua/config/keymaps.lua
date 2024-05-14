-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- REFACTORING.NVIM
-- require("telescope").load_extension("refactoring")
--
-- vim.keymap.set({ "n", "x" }, "<leader>rr", function()
--   require("telescope").extensions.refactoring.refactors()
-- end)

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

-- Toggle conceallevel with max value of 2
-- Obsidian plugin works best with 1 or 2
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
vim.keymap.set("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- Delete all buffers except current
local function delete_all_buffers_except_current()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end
--
-- Delete all buffers
local function delete_all_buffers()
  local bufs = vim.api.nvim_list_bufs()
  for _, i in ipairs(bufs) do
    vim.api.nvim_buf_delete(i, {})
  end
end

vim.keymap.set("n", "<leader>bc", function()
  delete_all_buffers_except_current()
end, { desc = "Delete all buffers but current" })

vim.keymap.set("n", "<leader>ba", function()
  delete_all_buffers()()
end, { desc = "Delete all buffers" })

-- Obsidian
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Obsidian find notes by tag" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Obsidian create new note in inbox" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Obsidian create new daily zettlekasten" })

-- Diffing
vim.keymap.set("n", "<leader>cw", "<cmd>windo diffthis<CR>", { desc = "Start diff for open windows" })
-- Could also use <cmd>windo diffoff<CR>
vim.keymap.set("n", "<leader>cW", "<cmd>diffoff!<CR>", { desc = "Stop diff for open windows" })

-- Refactoring
-- vim.keymap.set({ "n", "x" }, "<leader>rr", function()
--   require("refactoring").select_refactor()
-- end, { desc = "Select refactor" })
--
-- require("telescope").load_extension("refactoring")
--
-- vim.keymap.set({ "n", "x" }, "<leader>rR", function()
--   require("telescope").extensions.refactoring.refactors()
-- end, { desc = "Select refactor with telescope" })
--
-- vim.keymap.set({ "x", "n" }, "<leader>rv", function()
--   require("refactoring").debug.print_var()
-- end, { desc = "Log current variable" })
--
-- vim.keymap.set("n", "<leader>rc", function()
--   require("refactoring").debug.cleanup({})
-- end, { desc = "Cleanup logging variables" })

-- compiler.nvim mappings
vim.api.nvim_set_keymap(
  "n",
  "<leader>cR",
  "<cmd>CompilerOpen<cr>",
  { noremap = true, silent = true, desc = "Open compiler options" }
)

-- vim.api.nvim_set_keymap(
--   "n",
--   "<S-F6>",
--   "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
--     .. "<cmd>CompilerRedo<cr>",
--   { noremap = true, silent = true, desc = "Compiler redo last selected option" }
-- )

vim.api.nvim_set_keymap(
  "n",
  "<leader>ct",
  "<cmd>CompilerToggleResults<cr>",
  { noremap = true, silent = true, desc = "Toggle compiler results" }
)

-- Rest.nvim .http file plugin
vim.keymap.set("n", "<leader>rg", "<cmd>Rest run<cr>", { desc = "Run Rest request under the cursor" })
vim.keymap.set("n", "<leader>rl", "<cmd>Rest run last<cr>", { desc = "Re-run latest rest request under the cursor" })
