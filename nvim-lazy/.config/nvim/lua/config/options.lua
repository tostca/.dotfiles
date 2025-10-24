-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.guicursor = ""
opt.scrolloff = 8
opt.showtabline = 0
-- opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions

-- Disable all animations
vim.g.snacks_animate = false

-- vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_python_lsp = "pyright"
-- vim.g.lazyvim_python_lsp = "basedpyright"

-- DAP breakpoint icons and colors
-- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "Function", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Comment", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "🠶", texthl = "String", linehl = "DiffAdd", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "Function", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "Comment", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "String", linehl = "DiffAdd", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "String", linehl = "DiffAdd", numhl = "" })
-- local dap_icons = {
--   Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
--   Breakpoint = " ",
--   BreakpointCondition = " ",
--   BreakpointRejected = { " ", "DiagnosticError" },
--   LogPoint = ".>",
-- }
-- for name, sign in pairs(dap_icons) do
--   sign = type(sign) == "table" and sign or { sign }
--   vim.fn.sign_define("Dap" .. name, {
--     text = sign[1],
--     texthl = sign[2] or "DiagnosticInfo",
--     linehl = sign[3],
--     numhl = sign[3],
--   })
-- end
