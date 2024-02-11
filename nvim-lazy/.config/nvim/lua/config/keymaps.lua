-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
-- HARPOON
local harpoon = require("harpoon")
harpoon:setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>ht", function()
  toggle_telescope(harpoon:list())
end, { desc = "Harpoon Telescope" })

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():append()
end, { desc = "Harpoon [A]dd to list" })

vim.keymap.set("n", "<leader>hf", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon toggle quick menu" })

vim.keymap.set("n", "<leader>h1", function()
  harpoon:list():select(1)
end, { desc = "Select 1" })
vim.keymap.set("n", "<leader>h2", function()
  harpoon:list():select(2)
end, { desc = "Select 2" })
vim.keymap.set("n", "<leader>h3", function()
  harpoon:list():select(3)
end, { desc = "Select 3" })
vim.keymap.set("n", "<leader>h4", function()
  harpoon:list():select(4)
end, { desc = "Select 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end, { desc = "Harpoon Previous" })
vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end, { desc = "Harpoon Next" })

-- REFACTORING.NVIM
require("telescope").load_extension("refactoring")

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("telescope").extensions.refactoring.refactors()
end)

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
