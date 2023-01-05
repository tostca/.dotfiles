local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  -- cmp_tabnine = "[TN]",
  path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` user.
      require("luasnip").lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --['<C-Space>'] = cmp.mapping.complete(),
    ['<C-x>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    --['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,        
      select = true
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
  }), 
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
    })
    -- format = function(entry, vim_item)
      -- 	vim_item.kind = lspkind.presets.default[vim_item.kind]
      -- 	local menu = source_mapping[entry.source.name]
      -- 	if entry.source.name == "cmp_tabnine" then
      -- 		if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
      -- 			menu = entry.completion_item.data.detail .. " " .. menu
      -- 		end
      -- 		vim_item.kind = ""
      -- 	end
      -- 	vim_item.menu = menu
      -- 	return vim_item
      -- end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({

      -- tabnine completion? yayaya

      -- { name = "cmp_tabnine" },

      { name = "nvim_lsp" },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      { name = "luasnip" },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = "buffer", keywork_length = 5 },
    }),
    experimental = {
      ghost_text = true
    },
    completion = {
      autocomplete = true
    },
  })

  -- local tabnine = require("cmp_tabnine.config")
  -- tabnine:setup({
  -- 	max_lines = 1000,
  -- 	max_num_results = 20,
  -- 	sort = true,
  -- 	run_on_every_keystroke = true,
  -- 	snippet_placeholder = "..",
  -- })

  local opts = { noremap=true, silent=true }
  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local on_attach = function(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_command [[augroup Format]]
      vim.api.nvim_command [[autocmd! * <buffer>]]
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
      vim.api.nvim_command [[augroup END]]
    end

  end

  local function config(_config)
    return vim.tbl_deep_extend("force", {
      capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function()
        Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
        Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
        Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
        Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
        Nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
        Nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
        Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
        Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
        Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
        Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
      end,
    }, _config or {})
  end

  local path_to_elixirls = vim.fn.expand("~/elixir-tools/elixir-ls/language_server.sh")
  require("lspconfig").elixirls.setup({
    cmd = {path_to_elixirls},
    capabilities = capabilities,
    on_attach = on_attach
  })


  require("lspconfig").tsserver.setup({
    on_attach = on_attach,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    capabilities = capabilities
  })

  require("lspconfig").intelephense.setup{
    capabilities = capabilities,
    on_attach = on_attach
  }
  require("lspconfig").html.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'html', 'heex', 'eex'},
  }
  require("lspconfig").emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'heex', 'eex' },
  })
  require("lspconfig").cssls.setup(config())
  require("lspconfig").tailwindcss.setup({
    init_options = {
      userLanguages = {
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        svelte = "html",
      },
    },
    -- handlers = {
    --   ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
    --     vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
    --   end,
    -- },
    settings = {
      includeLanguages = {
        typescript = "javascript",
        typescriptreact = "javascript",
        ["html-eex"] = "html",
        ["phoenix-heex"] = "html",
        heex = "html",
        eelixir = "html",
        elm = "html",
        erb = "html",
        svelte = "html",
      },
      tailwindCSS = {
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning",
        },
        experimental = {
          classRegex = {
            [[class= "([^"]*)]],
            [[class: "([^"]*)]],
            '~H""".*class="([^"]*)".*"""',
          },
        },
        validate = true,
      },
    },
    filetypes = {
      "css",
      "scss",
      "sass",
      "html",
      "heex",
      "elixir",
      "eruby",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
    },
    on_attach = on_attach,
  })

  require'lspconfig'.graphql.setup{}
  require'lspconfig'.diagnosticls.setup{
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'pandoc' },
    init_options = {
      linters = {
        eslint = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          debounce = 100,
          args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
          sourceName = 'eslint_d',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint] ${message} [${ruleId}]',
            security = 'severity'
          },
          securities = {
            [2] = 'error',
            [1] = 'warning'
          }
        },
      },
      filetypes = {
        javascript = 'eslint',
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint',
      },
      formatters = {
        eslint_d = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
          rootPatterns = { '.git' },
        },
        prettier = {
          command = 'prettier_d_slim',
          rootPatterns = { '.git' },
          -- requiredFiles: { 'prettier.config.js' },
          args = { '--stdin', '--stdin-filepath', '%filename' }
        }
      },
      formatFiletypes = {
        css = 'prettier',
        javascript = 'prettier',
        javascriptreact = 'prettier',
        json = 'prettier',
        scss = 'prettier',
        less = 'prettier',
        typescript = 'prettier',
        typescriptreact = 'prettier',
        json = 'prettier',
      }
    }
  }

  local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
  }

  require("symbols-outline").setup(opts)

  local snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. "/.vim/plugged/"
    for _, plug in ipairs(plugins) do
      path = root_path .. plug
      if vim.fn.isdirectory(path) ~= 0 then
        table.insert(paths, path)
      end
    end
    return paths
  end

  -- require("luasnip.loaders.from_vscode").lazy_load({
  -- 	paths = snippets_paths(),
  -- 	include = nil, -- Load all languages
  -- 	exclude = {},
  -- })
