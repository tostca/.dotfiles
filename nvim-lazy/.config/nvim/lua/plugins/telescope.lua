return {
  {
    "telescope.nvim",
    keys = {
      -- {},
      {
        "<leader>fw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Find Git Worktrees",
      },
      {
        "<leader>fW",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Create Git Worktree",
      },
    },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("harpoon")
        require("telescope").load_extension("git_worktree")
      end,
    },
  },
}
