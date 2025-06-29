return {
  {
    "mfussenegger/nvim-dap",

    -- stylua: ignore
    keys = {
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    },

    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      local mason_nvim_dap = require("lazy.core.config").spec.plugins["mason-nvim-dap.nvim"]
      local Plugin = require("lazy.core.plugin")
      local mason_nvim_dap_opts = Plugin.values(mason_nvim_dap, "opts", false)
      require("mason-nvim-dap").setup(mason_nvim_dap_opts)

      -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- setup dap config by VsCode launch.json file
      -- local vscode = require("dap.ext.vscode")
      -- local json = require("plenary.json")
      -- vscode.json_decode = function(str)
      --   return vim.json.decode(json.json_strip_comments(str))
      -- end
      --
      -- require("overseer").enable_dap()
    end,
  },
}
