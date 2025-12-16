-- local mason_registry = require("mason-registry")

local function rebuild_project(co, path)
  local spinner = require("easy-dotnet.ui-modules.spinner").new()
  spinner:start_spinner("Building")
  vim.fn.jobstart(string.format("dotnet build %s", path), {
    on_exit = function(_, return_code)
      if return_code == 0 then
        spinner:stop_spinner("Built successfully")
      else
        spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
        error("Build failed")
      end
      coroutine.resume(co)
    end,
  })
  coroutine.yield()
end

local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
local cmd = {
  "roslyn",
  "--stdio",
  "--logLevel=Information",
  "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
  "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
  "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
  "--extension",
  vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
}

return {
  -- {
  --   "mason-org/mason.nvim",
  --   opts = { ensure_installed = { "csharpier", "netcoredbg", "rzls", "roslyn" } },
  --   -- opts = { ensure_installed = { "csharpier", "netcoredbg" } },
  --   config = function()
  --     require("mason").setup({
  --       registries = {
  --         "github:mason-org/mason-registry",
  --         "github:crashdummyy/mason-registry",
  --       },
  --     })
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  -- {
  --   "seblyng/roslyn.nvim",
  --   ft = { "cs", "razor" },
  --   dependencies = {
  --     {
  --       -- By loading as a dependencies, we ensure that we are available to set
  --       -- the handlers for Roslyn.
  --       "tris203/rzls.nvim",
  --       config = true,
  --     },
  --   },
  --   opts = {
  --     filewatching = "off",
  --   },
  --   config = function()
  --     -- Use one of the methods in the Integration section to compose the command.
  --     -- local cmd = {}
  --     vim.lsp.config("roslyn", {
  --       -- require("roslyn").setup({
  --       cmd = cmd,
  --       handlers = require("rzls.roslyn_handlers"),
  --       settings = {
  --         ["csharp|inlay_hints"] = {
  --           csharp_enable_inlay_hints_for_implicit_object_creation = true,
  --           csharp_enable_inlay_hints_for_implicit_variable_types = true,
  --
  --           csharp_enable_inlay_hints_for_lambda_parameter_types = true,
  --           csharp_enable_inlay_hints_for_types = true,
  --           dotnet_enable_inlay_hints_for_indexer_parameters = true,
  --           dotnet_enable_inlay_hints_for_literal_parameters = true,
  --           dotnet_enable_inlay_hints_for_object_creation_parameters = true,
  --           dotnet_enable_inlay_hints_for_other_parameters = true,
  --           dotnet_enable_inlay_hints_for_parameters = true,
  --           dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
  --           dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
  --           dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
  --         },
  --         ["csharp|code_lens"] = {
  --           dotnet_enable_references_code_lens = true,
  --         },
  --       },
  --     })
  --     vim.lsp.enable("roslyn")
  --   end,
  --   init = function()
  --     -- We add the Razor file types before the plugin loads.
  --     vim.filetype.add({
  --       extension = {
  --         razor = "razor",
  --         cshtml = "razor",
  --       },
  --     })
  --   end,
  -- },
  {
    "GustavEikaas/easy-dotnet.nvim",
    -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
    -- are highly recommended for a better experience
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
    config = function()
      local dotnet = require("easy-dotnet")
      -- Options are not required
      dotnet.setup({
        lsp = {
          enabled = true, -- Enable builtin roslyn lsp
          roslynator_enabled = true, -- Automatically enable roslynator analyzer
          analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
          config = {},
        },
        debugger = {
          -- The path to netcoredbg executable
          --example mason path: vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg.cmd"),
          bin_path = "netcoredbg",
          auto_register_dap = true,
          mappings = {
            open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
          },
        },
        ---@type TestRunnerOptions
        test_runner = {
          ---@type "split" | "vsplit" | "float" | "buf"
          viewmode = "float",
          ---@type number|nil
          vsplit_width = nil,
          ---@type string|nil "topleft" | "topright"
          vsplit_pos = nil,
          enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
          noBuild = true,
          icons = {
            passed = "",
            skipped = "",
            failed = "",
            success = "",
            reload = "",
            test = "",
            sln = "󰘐",
            project = "󰘐",
            dir = "",
            package = "",
          },
          mappings = {
            debug_test_from_buffer = { lhs = "<leader>Dr", desc = "run test from buffer" },
            run_test_from_buffer = { lhs = "<leader>Cr", desc = "run test from buffer" },
            peek_stack_trace_from_buffer = { lhs = "<leader>Cp", desc = "peek stack trace from buffer" },
            filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
            debug_test = { lhs = "<leader>d", desc = "debug test" },
            go_to_file = { lhs = "g", desc = "go to file" },
            run_all = { lhs = "<leader>R", desc = "run all tests" },
            run = { lhs = "<leader>r", desc = "run test" },
            peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
            expand = { lhs = "o", desc = "expand" },
            expand_node = { lhs = "E", desc = "expand node" },
            expand_all = { lhs = "-", desc = "expand all" },
            collapse_all = { lhs = "W", desc = "collapse all" },
            close = { lhs = "q", desc = "close testrunner" },
            refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
          },
          --- Optional table of extra args e.g "--blame crash"
          additional_args = {},
        },
        new = {
          project = {
            prefix = "sln", -- "sln" | "none"
          },
        },
        ---@param action "test" | "restore" | "build" | "run"
        terminal = function(path, action, args)
          args = args or ""
          local commands = {
            run = function()
              return string.format("dotnet run --project %s %s", path, args)
            end,
            test = function()
              return string.format("dotnet test %s %s", path, args)
            end,
            restore = function()
              return string.format("dotnet restore %s %s", path, args)
            end,
            build = function()
              return string.format("dotnet build %s %s", path, args)
            end,
            watch = function()
              return string.format("dotnet watch --project %s %s", path, args)
            end,
          }
          local command = commands[action]()
          if require("easy-dotnet.extensions").isWindows() == true then
            command = command .. "\r"
          end
          vim.cmd("vsplit")
          vim.cmd("term " .. command)
        end,
        csproj_mappings = true,
        fsproj_mappings = true,
        auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = "block_scoped",
          enabled = true,
          use_clipboard_json = {
            behavior = "prompt", --'auto' | 'prompt' | 'never',
            register = "+", -- which register to check
          },
        },
        server = {
          ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
          log_level = "All",
        },
        -- choose which picker to use with the plugin
        -- possible values are "telescope" | "fzf" | "snacks" | "basic"
        -- if no picker is specified, the plugin will determine
        -- the available one automatically with this priority:
        -- telescope -> fzf -> snacks ->  basic
        picker = "snacks",
        background_scanning = true,
        notifications = {
          --Set this to false if you have configured lualine to avoid double logging
          handler = function(start_event)
            local spinner = require("easy-dotnet.ui-modules.spinner").new()
            spinner:start_spinner(start_event.job.name)
            ---@param finished_event JobEvent
            return function(finished_event)
              spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
            end
          end,
        },
        diagnostics = {
          default_severity = "error",
          setqflist = false,
        },
      })

      -- Example command
      vim.api.nvim_create_user_command("Secrets", function()
        dotnet.secrets()
      end, {})

      -- Example keybinding
      -- vim.keymap.set("n", "<C-p>", function()
      --   dotnet.run_project()
      -- end)
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        fuzzy = { implementation = "prefer_rust_with_warning" },
        sources = {
          default = { "lsp", "easy-dotnet", "path" },
          providers = {
            ["easy-dotnet"] = {
              name = "easy-dotnet",
              enabled = true,
              module = "easy-dotnet.completion.blink",
              score_offset = 10000,
              async = true,
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    -- optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    config = function()
      local dap = require("dap")

      -- STUB adapter to satisfy 'coreclr'
      dap.adapters.coreclr = {
        type = "executable",
        command = "dotnet",
        args = { "--info" },
      }

      local dotnet = require("easy-dotnet")
      require("easy-dotnet.netcoredbg").register_dap_variables_viewer()

      local debug_dll = nil
      local function ensure_dll()
        if debug_dll ~= nil then
          return debug_dll
        end
        local dll = dotnet.get_debug_dll()
        debug_dll = dll
        return dll
      end

      dap.configurations.cs = {
        {
          type = "easy-dotnet",
          name = "Launch .NET",
          request = "launch",
          env = function()
            local dll = ensure_dll()
            return dotnet.get_environment_variables(dll.project_name, dll.absolute_project_path)
          end,
          program = function()
            local dll = ensure_dll()
            return dll.target_path
          end,
          cwd = function()
            return ensure_dll().absolute_project_path
          end,
        },
      }

      dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
        debug_dll = nil
      end
    end,
    dependencies = {
      { "nvim-neotest/nvim-nio" },
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     -- .NET specific setup using `easy-dotnet`
  --     require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- special variables viewer specific for .NET
  --   end,
  -- },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          dap = {
            adapter_name = "easy-dotnet",
          },
        },
      },
    },
  },
}
