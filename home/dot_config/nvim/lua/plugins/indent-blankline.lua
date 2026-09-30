local Plugin = {'lukas-reineke/indent-blankline.nvim'}

-- VSCode draws this itself. cond keeps the plugin installed for standalone
-- nvim but never loads it in the embedded instance.
Plugin.cond = not vim.g.vscode

Plugin.main = 'ibl'

Plugin.event = {'BufReadPost', 'BufNewFile'}

-- See :help ibl.setup()
Plugin.opts = {
  enabled = true,
  scope = {
    enabled = false,
  },
  indent = {
    char = '▏',
  },
}

return Plugin

