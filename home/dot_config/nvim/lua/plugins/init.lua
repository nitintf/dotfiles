local Plugins = {
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},
  {'kyazdani42/nvim-web-devicons', lazy = true, cond = not vim.g.vscode},
  {'numToStr/Comment.nvim', config = true, event = 'VeryLazy'},

  -- Themes
  -- {'shaunsingh/nord.nvim'},
  -- {'scottmckendry/cyberdream.nvim'},
  -- {'tanvirtin/monokai.nvim'},
  {'folke/tokyonight.nvim', lazy = false, priority = 1000, cond = not vim.g.vscode, opts = {
    style = 'night',
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = {italic = true},
      keywords = {italic = true},
      sidebars = 'transparent',
      floats = 'transparent',
    },
  }},
}

return Plugins
