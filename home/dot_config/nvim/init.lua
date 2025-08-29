local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('core.settings')
load('core.commands')
load('core.keymaps')
require('core.plugins')

pcall(vim.cmd.colorscheme, 'tokyonight')
