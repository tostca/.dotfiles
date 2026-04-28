-- Fix missing async.nvim dependency for refactoring.nvim
-- LazyVim's refactoring extra is missing this new required dependency
-- See: https://github.com/ThePrimeagen/refactoring.nvim/issues/523
return {
  {
    "lewis6991/async.nvim",
    lazy = true,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lewis6991/async.nvim", -- Required since Oct 2025 refactor
    },
  },
}
