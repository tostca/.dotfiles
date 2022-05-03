require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'html', 'javascript', 'typescript', 'tsx', 'css', 'json', 'graphql' },
  -- ensure_installed = "all", -- or maintained
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = false
  },
  context_commentstring = {
    enable = true
  }
}
