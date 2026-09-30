local Plugin = {'nvim-lualine/lualine.nvim'}

-- VSCode draws this itself. cond keeps the plugin installed for standalone
-- nvim but never loads it in the embedded instance.
Plugin.cond = not vim.g.vscode

Plugin.event = 'VeryLazy'

-- See :help lualine.txt
Plugin.opts = {
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {'NvimTree'}
    }
  },
}

function Plugin.init()
  if vim.g.vscode then return end

  vim.opt.showmode = false
end

return Plugin
