-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Themes
  use 'navarasu/onedark.nvim'

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')

  -- Git related plugins
  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')

  -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-sleuth' 

  -- "gc" to comment visual regions/lines
  use 'numToStr/Comment.nvim' 

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},

      -- Useful status updates for LSP
      {'j-hui/fidget.nvim'},

      -- Additional lua configuration, makes nvim stuff amazing
      {'folke/neodev.nvim'},
	  }
  }

  use("folke/zen-mode.nvim")
  -- use("github/copilot.vim")

  -- Status line
  use({
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- File explorer
  use {
      'nvim-tree/nvim-tree.lua',
      requires = {
          'nvim-tree/nvim-web-devicons', -- optional, for file icons
      }
  }

end)

