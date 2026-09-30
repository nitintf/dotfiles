local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('core.settings')
load('core.commands')
load('core.keymaps')
require('core.plugins')

-- VSCode paints the editor itself, the embedded nvim never renders a colorscheme.
if not vim.g.vscode then
  pcall(vim.cmd.colorscheme, 'tokyonight-night')
end
