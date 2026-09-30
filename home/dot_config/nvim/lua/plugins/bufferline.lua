local Plugin = {'akinsho/bufferline.nvim'}

-- VSCode draws this itself. cond keeps the plugin installed for standalone
-- nvim but never loads it in the embedded instance.
Plugin.cond = not vim.g.vscode

Plugin.event = 'VeryLazy'

Plugin.opts = {
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
  -- :help bufferline-highlights
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = {attribute = 'fg', highlight = 'Function'},
      italic = false
    }
  }
}

return Plugin
