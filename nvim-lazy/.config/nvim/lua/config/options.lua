-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.guicursor = ""
opt.scrolloff = 8

opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions

vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_python_lsp = "pyright"
-- vim.g.lazyvim_python_lsp = "basedpyright"
