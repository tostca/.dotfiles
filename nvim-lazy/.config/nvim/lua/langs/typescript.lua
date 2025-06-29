return {
  {
    --   "mfussenegger/nvim-dap",
    --   dependencies = {
    --     {
    --       "mxsdev/nvim-dap-vscode-js",
    --       config = function()
    --         require("dap-vscode-js").setup({
    --           debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    --           adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
    --         })
    --       end,
    --     },
    --     {
    --       "microsoft/vscode-js-debug",
    --       build = "npm install && npx gulp vsDebugServerBundle && mv dist out",
    --       version = "1.*",
    --     },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")

      for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
        local pwaType = "pwa-" .. adapterType

        dap.adapters[pwaType] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }

        -- this allow us to handle launch.json configurations
        -- which specify type as "node" or "chrome" or "msedge"
        dap.adapters[adapterType] = function(cb, config)
          local nativeAdapter = dap.adapters[pwaType]

          config.type = pwaType

          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local enter_launch_url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file using Node.js (nvim-dap)",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process using Node.js (nvim-dap)",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          -- requires ts-node to be installed globally or locally
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file using Node.js with ts-node/register (nvim-dap)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeArgs = { "-r", "ts-node/register" },
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome (nvim-dap)",
            url = enter_launch_url,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-msedge",
            request = "launch",
            name = "Launch Edge (nvim-dap)",
            url = enter_launch_url,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end
    end,
  },
}
